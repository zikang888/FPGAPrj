"""Verify and package the 2026-11-02 latest-source migration; no board pass implied."""
from pathlib import Path
from datetime import datetime, timezone, timedelta
import hashlib, json, re, shutil, subprocess, zipfile

repo = Path(__file__).resolve().parents[1]
root = repo.parents[1]
build = root / 'migration_build/2026.1-latest-20261102'
baseline = 'c5f44ff57ff1b551ba32569f4a2103a1b1cf35be'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def git(*args):
    return subprocess.check_output(['git','-C',str(repo),*args]).decode('utf-8').strip()
def require(ok, msg):
    if not ok: raise RuntimeError(msg)

require(not git('status','--porcelain'), 'Commit migration sources before packaging')
require(not git('diff',baseline,'--name-only','--','fpga/rtl','fpga/constraints'),
        'Production RTL or constraints changed from the selected latest source')
before = json.loads((build/'legacy_inventory_before.json').read_text())
legacy = root/'Multi_protocol'
after = {str(p.relative_to(legacy)):{'size':p.stat().st_size,'mtime_ns':p.stat().st_mtime_ns}
         for p in legacy.rglob('*') if p.is_file()}
require(before == after, 'Legacy project metadata changed')
old_repo = root/'migration_work/FPGAPrj_2026_1'
require(subprocess.check_output(['git','-C',str(old_repo),'rev-parse','HEAD']).decode().strip()
        == '9a6411a3f3994e6ee06eb6c12d178c7e9443fd26', 'Previous migration HEAD changed')
require(not subprocess.check_output(['git','-C',str(old_repo),'status','--porcelain']).strip(),
        'Previous migration worktree changed')

for name, marker in [('simulation','SIMULATION_COMPLETED'),('build','MIGRATION_PL_BUILD_DONE:'),
                     ('audit','MIGRATION_AUDIT_DONE'),('vitis_app','MIGRATION_VITIS_APP_DONE:'),
                     ('host_checks','SESSION_CHECKS_PASS')]:
    require(marker in (build/f'logs/{name}.log').read_text(encoding='utf-8',errors='replace'),
            name+' did not finish')
sim_logs = sorted((build/'sim/reports/simulation').glob('*.log'))
require(len(sim_logs)==9, 'Expected eight original RTL tests plus error_retention_tb')
for p in sim_logs:
    t=p.read_text()
    marker='ERROR_RETENTION_PASS:' if p.stem=='error_retention_tb' else 'PASS:'
    require(marker in t and not re.search(r'Fatal:|FATAL_ERROR',t,re.I), 'Failed RTL: '+p.name)
host = (build/'logs/host_checks.log').read_text(encoding='utf-8',errors='replace')
host_tests = re.findall(r'^PASS ([a-z][a-z_]+)\s*$',host,re.M)
require(len(host_tests)==16 and 'PASS saved replay:' in host, 'Host regression incomplete')
require('PASS: session UI rendering' in host,'UI regression incomplete')

reports=build/'pl/reports'
text=(reports/'timing.rpt').read_text()
row=re.search(r'\n\s*(-?\d+\.\d+)\s+(-?\d+\.\d+)\s+\d+\s+\d+\s+(-?\d+\.\d+)\s+(-?\d+\.\d+)',text)
require(row is not None,'No timing summary')
wns,tns,whs,ths=map(float,row.groups())
require(wns>=0 and whs>=0 and tns==ths==0,'Internal timing failed')
cdc_rows=[tuple(map(int,m.groups())) for m in re.finditer(
    r'\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$',(reports/'cdc.rpt').read_text(),re.M)]
require(cdc_rows and all(r[2]==r[3]==r[4]==0 for r in cdc_rows),'CDC has unsafe/unknown endpoints')
skews=[float(m.group(1)) for m in re.finditer(r'Slow\s+\d+\.\d+\s+\d+\.\d+\s+(-?\d+\.\d+)',
                                          (reports/'bus_skew.rpt').read_text())]
require(skews and min(skews)>=0,'Bus skew failed')
require('Module reference is unresolved' not in (reports/'ip_status_final.rpt').read_text(),
        'Unresolved module reference')
require(not re.search(r'\|\s*(Error|Critical Warning)\s*\|',(reports/'drc.rpt').read_text()),
        'DRC contains Error/Critical Warning')

old_bd=json.loads(git('show',baseline+':Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/multi_protocol_bd.bd'))
new_bd=json.loads((build/'pl/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/multi_protocol_bd.bd').read_text())
def ps_params(bd):
    return {k:' '.join(v['value']) if isinstance(v['value'],list) else v['value']
            for k,v in bd['design']['components']['processing_system7_0']['parameters'].items()}
require(ps_params(old_bd)==ps_params(new_bd),'PS7 board parameters differ from latest baseline')
xsa=build/'pl/export/multi_protocol.xsa'
bit=build/'pl/export/multi_protocol.bit'
app=build/'vitis/multi_protocol_app'
elf=app/'build/multi_protocol_app.elf'
for p in (repo/'software/src').iterdir():
    if p.suffix in ('.c','.h','.inc'):
        require(p.read_bytes()==(app/p.name).read_bytes(),'Compiled workspace mismatch: '+p.name)
compile_db=next(app.rglob('compile_commands.json')).read_text()
require('-DSDT' in compile_db and '2018.3' not in compile_db,'Wrong ARM build dependencies')
memory=json.loads((build/'vitis/memory_verification.json').read_text())
require(memory['elf_sha256']==sha(elf) and memory['xsa_sha256']==sha(xsa) and not memory['overlap'],
        'ELF/XSA/memory verification mismatch')

bundle=build/'candidate'
bundle.mkdir(exist_ok=True)
with zipfile.ZipFile(xsa) as z:
    require(z.read('multi_protocol.bit')==bit.read_bytes(),'XSA/BIT mismatch')
    init=z.read('ps7_init.tcl')
    require(init==(build/'vitis/multi_protocol_platform/hw/sdt/ps7_init.tcl').read_bytes(),'PS init mismatch')
    (bundle/'ps7_init.tcl').write_bytes(init)
for p in (xsa,bit,elf,build/'vitis/memory_verification.json'):
    shutil.copy2(p,bundle/p.name)
for name in ('program_2026_1.ps1','program_2026_1.tcl'):
    shutil.copy2(repo/'tools'/name,bundle/name)
shutil.copy2(repo/'README_MIGRATION_2026_1.md',bundle/'README.md')
summary={
    'status':'latest_source_offline_migration_verified_board_not_connected',
    'responsible_member':'member C','created_at':datetime.now(timezone(timedelta(hours=8))).isoformat(),
    'baseline_branch':'codex/ui-four-protocol-20261023','baseline_commit':baseline,
    'migration_commit':git('rev-parse','HEAD'),'part':'xc7z020clg484-2',
    'expected_registers':{'SYS_ID':'0x4D505254','VERSION':'0x00010009','BUILD_ID':'0x20261021','CAPABILITIES':'0x000003FF'},
    'rtl_tests':[p.stem for p in sim_logs],'host_tests':host_tests+['saved_error_replay'],
    'ui_preview':'host rendering and touch-action regression passed; not physical board evidence',
    'timing':{'wns_ns':wns,'tns_ns':tns,'whs_ns':whs,'ths_ns':ths,'bus_skew_min_ns':min(skews),'external_io_timing_complete':False},
    'cdc':{'endpoints':sum(r[0] for r in cdc_rows),'safe':sum(r[1] for r in cdc_rows),'unsafe':0,'unknown':0},
    'production_rtl_and_xdc_match_latest_baseline':True,'ps7_parameters_match_latest_baseline':True,
    'memory':memory,'legacy_files_unchanged_by_size_mtime':len(before),'previous_migration_preserved':True,
    'board_tested_this_run':False,
    'remaining':['JTAG and physical LCD/touch regression of this image','four-protocol normal/error traffic and retained-transaction replay',
                 '2026.1 hw_server enumeration compatibility','external LCD/CAN timing budgets','long-run stability and SD boot if required'],
}
(bundle/'verification.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8')
manifest=dict(summary)
manifest['files']=[{'path':p.name,'bytes':p.stat().st_size,'sha256':sha(p)}
                   for p in sorted(bundle.iterdir()) if p.is_file() and p.name!='manifest.json']
(bundle/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
(build/'verification.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8')
out=build/'multi_protocol_2026_1_latest_20261102_offline_candidate.zip'
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
    for p in bundle.iterdir():
        if p.is_file():z.write(p,'candidate/'+p.name)
    for directory in (reports,build/'sim/reports/simulation',build/'logs',build/'ui_preview'):
        for p in directory.rglob('*'):
            if p.is_file():z.write(p,p.relative_to(build))
    z.write(build/'baseline.json','baseline.json')
    z.writestr('migration_source.patch',subprocess.check_output(['git','-C',str(repo),'diff','--binary',baseline,'HEAD']))
print('LATEST_MIGRATION_PACKAGE_VERIFIED',out)
print('TIMING',wns,whs,'RTL',len(sim_logs),'HOST',len(host_tests)+1)
