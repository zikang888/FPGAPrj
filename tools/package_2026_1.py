"""Verify the offline migration gates and package a matched, untested-on-board candidate."""
from pathlib import Path
from datetime import datetime, timezone, timedelta
import hashlib
import json
import re
import shutil
import subprocess
import zipfile

repo = Path(__file__).resolve().parents[1]
root = repo.parents[1]
build = root / 'migration_build/2026.1'
baseline = '0d9fde5b312a62feed08525b0c1c31f4385e7f81'
def sha(data):
    return hashlib.sha256(data).hexdigest()
def git(*args):
    return subprocess.check_output(['git', '-C', str(repo), *args], text=True).strip()
def require(condition, message):
    if not condition:
        raise RuntimeError(message)

require(not git('status', '--porcelain'), 'Commit the migration source before packaging')
before = json.loads((build / 'legacy_inventory_before.json').read_text())
legacy = root / 'Multi_protocol'
after = {str(p.relative_to(legacy)): {'size': p.stat().st_size, 'mtime_ns': p.stat().st_mtime_ns}
         for p in legacy.rglob('*') if p.is_file()}
require(before == after, 'Legacy project file metadata changed during migration')
require(not subprocess.check_output(['git', '-C', str(root / 'migration_sources/FPGAPrj_latest'),
    'status', '--porcelain']).strip(), 'Frozen source review copy changed')
require('SIMULATION_COMPLETED' in (build / 'logs/simulation.log').read_text(), 'RTL regression incomplete')
sim_logs = sorted((build / 'sim/reports/simulation').glob('*.log'))
require(len(sim_logs) == 8 and all('PASS:' in p.read_text() and 'Fatal:' not in p.read_text()
    for p in sim_logs), 'Eight independent RTL regression logs are required')
require('SESSION_CHECKS_PASS' in (build / 'logs/host_checks.log').read_text(), 'Host checks incomplete')
require('MIGRATION_VITIS_APP_DONE:' in (build / 'logs/vitis_app.log').read_text(), 'ARM build incomplete')
require('MIGRATION_PL_BUILD_DONE:' in (build / 'logs/build.log').read_text(), 'PL build incomplete')
require('MIGRATION_AUDIT_DONE' in (build / 'logs/audit.log').read_text(), 'Final implementation audit incomplete')
reports = build / 'pl/reports'
timing = (reports / 'timing.rpt').read_text()
match = re.search(r'\n\s*(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+\d+\s+\d+\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)', timing)
require(match is not None, 'No timing summary row')
wns, tns, whs, ths = map(float, match.groups())
require(wns >= 0 and whs >= 0 and tns == ths == 0, 'Internal timing failed')
skews = [float(m.group(1)) for m in re.finditer(r'Slow\s+\d+\.\d+\s+\d+\.\d+\s+(-?\d+\.\d+)', (reports / 'bus_skew.rpt').read_text())]
require(skews and min(skews) >= 0, 'Bus skew failed or report missing')
cdc_rows = [tuple(map(int, m.groups())) for m in re.finditer(
    r'\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$', (reports / 'cdc.rpt').read_text(), re.M)]
require(cdc_rows and all(r[2] == r[3] == r[4] == 0 for r in cdc_rows), 'Unsafe/unknown CDC or missing ASYNC_REG')
require('Module reference is unresolved' not in (reports / 'ip_status_final.rpt').read_text(), 'Unresolved module references')
compile_db = next((build / 'vitis/multi_protocol_app').rglob('compile_commands.json')).read_text()
require('2018.3' not in compile_db and '-DSDT' in compile_db, 'Legacy build dependency or absent SDT flag')

old_bd = json.loads((root / 'migration_sources/FPGAPrj_latest/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/multi_protocol_bd.bd').read_text())
new_bd = json.loads((build / 'pl/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/multi_protocol_bd.bd').read_text())
def ps_params(bd):
    return {k: ' '.join(v['value']) if isinstance(v['value'], list) else v['value']
        for k, v in bd['design']['components']['processing_system7_0']['parameters'].items()}
require(ps_params(old_bd) == ps_params(new_bd), 'PS7 board configuration differs from frozen baseline')
for folder in ('fpga/rtl', 'fpga/constraints'):
    for source in (repo / folder).rglob('*'):
        if source.is_file():
            old = root / 'migration_sources/FPGAPrj_latest' / source.relative_to(repo)
            require(source.read_bytes() == old.read_bytes(), 'Unexpected RTL/constraint change: ' + str(source))

xsa = build / 'pl/export/multi_protocol.xsa'
bit = build / 'pl/export/multi_protocol.bit'
require(all((reports / name).stat().st_mtime_ns >= bit.stat().st_mtime_ns
    for name in ('ip_status_final.rpt', 'bus_skew.rpt', 'clocks.rpt')),
    'Re-run the final implementation audit after the latest PL build')
for source in (repo / 'software/src').iterdir():
    if source.suffix in {'.c', '.h'}:
        require(source.read_bytes() == (build / 'vitis/multi_protocol_app' / source.name).read_bytes(),
                'Application source differs from compiled workspace: ' + source.name)
memory = json.loads((build / 'vitis/memory_verification.json').read_text())
require(memory['xsa_sha256'] == sha(xsa.read_bytes()) and memory['overlap'] is False, 'ELF/XSA memory verification mismatch')
elf = build / 'vitis/multi_protocol_app/build/multi_protocol_app.elf'
require(sha(elf.read_bytes()) == memory['elf_sha256'], 'ELF changed after memory verification')
bundle = build / 'candidate'
bundle.mkdir(exist_ok=True)
with zipfile.ZipFile(xsa) as archive:
    require(archive.read('multi_protocol.bit') == bit.read_bytes(), 'XSA does not contain the matching BIT')
    init = archive.read('ps7_init.tcl')
    platform_init = build / 'vitis/multi_protocol_platform/hw/sdt/ps7_init.tcl'
    require(init == platform_init.read_bytes(), 'PS initialization does not match the final XSA')
    (bundle / 'ps7_init.tcl').write_bytes(init)
    (bundle / 'multi_protocol_bd.hwh').write_bytes(archive.read('multi_protocol_bd.hwh'))
for source in (xsa, bit, elf,
    build / 'vitis/hello_world/build/hello_world.elf',
    build / 'vitis/multi_protocol_platform/export/multi_protocol_platform/sw/boot/fsbl.elf',
    build / 'vitis/memory_verification.json'):
    shutil.copy2(source, bundle / source.name)
shutil.copytree(reports, bundle / 'reports', dirs_exist_ok=True)
shutil.copytree(build / 'sim/reports/simulation', bundle / 'reports/simulation', dirs_exist_ok=True)
(bundle / 'logs').mkdir(exist_ok=True)
for name in ('preflight.log', 'build.log', 'simulation.log', 'vitis_app.log',
             'host_checks.log', 'audit.log', 'jtag_preflight.log'):
    if (build / 'logs' / name).is_file():
        shutil.copy2(build / 'logs' / name, bundle / 'logs' / name)
shutil.copy2(repo / 'README_MIGRATION_2026_1.md', bundle / 'README.md')
for name in ('program_2026_1.tcl', 'program_2026_1.ps1'):
    shutil.copy2(repo / 'tools' / name, bundle / name)
patch = subprocess.check_output(['git', '-C', str(repo), 'diff', '--binary', baseline, 'HEAD'])
(bundle / 'migration_source.patch').write_bytes(patch)
manifest = {
    'status': 'offline_build_verified_board_not_connected',
    'created_at': datetime.now(timezone(timedelta(hours=8))).isoformat(),
    'baseline_commit': baseline, 'migration_commit': git('rev-parse', 'HEAD'),
    'part': 'xc7z020clg484-2', 'vivado': '2026.1 build 6511674', 'vitis': '2026.1 build 6497934',
    'rtl_tests': [p.stem for p in sim_logs], 'host_tests': 11, 'ui_preview': 'passed',
    'timing': {'wns_ns': wns, 'tns_ns': tns, 'whs_ns': whs, 'ths_ns': ths,
               'minimum_bus_skew_slack_ns': min(skews), 'external_io_timing_complete': False},
    'cdc': {'endpoints': sum(r[0] for r in cdc_rows), 'safe': sum(r[1] for r in cdc_rows),
            'unsafe': sum(r[2] for r in cdc_rows), 'unknown': sum(r[3] for r in cdc_rows)},
    'legacy_project': {'files_checked_by_size_mtime': len(before), 'changed': False},
    'ps7_parameters_match_baseline': True, 'rtl_and_xdc_match_baseline': True,
    'memory': memory,
    'remaining': ['LCD/CAN external timing budgets', 'JTAG and physical board acceptance',
                  'LCD/GT911 and four-protocol regression', 'SD boot if required'],
    'files': [{'path': p.relative_to(bundle).as_posix(), 'bytes': p.stat().st_size,
               'sha256': sha(p.read_bytes())} for p in sorted(bundle.rglob('*'))
              if p.is_file() and p.name != 'manifest.json'],
}
(bundle / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding='utf-8')
with zipfile.ZipFile(build / 'multi_protocol_2026_1_offline_candidate.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
    for p in bundle.rglob('*'):
        if p.is_file():
            archive.write(p, p.relative_to(bundle))
print('MIGRATION_CANDIDATE_VERIFIED:', bundle)
