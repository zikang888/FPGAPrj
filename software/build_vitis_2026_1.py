"""Vitis 2026.1 standalone build in a dedicated workspace; no legacy SDK input."""
from pathlib import Path
import argparse
import hashlib
import os
import subprocess
import json
import re
import struct
import vitis

repo = Path(__file__).resolve().parents[1]
root = repo.parents[1]
build_root = root / 'migration_build' / '2026.1'
parser = argparse.ArgumentParser()
parser.add_argument('--xsa', type=Path, default=build_root / 'pl/export/multi_protocol.xsa')
parser.add_argument('--platform-only', action='store_true')
args = parser.parse_args()
xsa = args.xsa.resolve(strict=True)
if not xsa.is_relative_to(build_root):
    raise RuntimeError('XSA must come from the dedicated migration build')
ws = build_root / 'vitis'
ws.mkdir(parents=True, exist_ok=True)
client = vitis.create_client()
try:
    client.set_workspace(path=str(ws))
    platform_name = 'multi_protocol_platform'
    domain_name = 'standalone_a9'
    digest = hashlib.sha256(xsa.read_bytes()).hexdigest()
    stamp = ws / 'platform_xsa.sha256'
    if (ws / platform_name).exists():
        platform = client.get_component(name=platform_name)
        if not stamp.exists() or stamp.read_text().strip() != digest:
            platform.update_hw(hw_design=str(xsa))
    else:
        platform = client.create_platform_component(
            name=platform_name, hw_design=str(xsa), cpu='ps7_cortexa9_0',
            os='standalone', domain_name=domain_name,
            compiler='gcc', generate_dtb=False)
    domain = platform.get_domain(name=domain_name)
    domain.set_config(option='os', param='standalone_stdin', value='ps7_uart_1')
    domain.set_config(option='os', param='standalone_stdout', value='ps7_uart_1')
    platform_status = platform.build()
    print('PLATFORM_BUILD_STATUS:', platform_status)
    if platform_status != 0:
        raise RuntimeError('Platform build failed')
    xpfm = ws / platform_name / 'export' / platform_name / (platform_name + '.xpfm')
    if not xpfm.is_file():
        raise RuntimeError('Platform build did not produce an XPFM')
    stamp.write_text(digest + '\n')
    print('MIGRATION_VITIS_PLATFORM_DONE:', xpfm)
    if not args.platform_only:
        if (ws / 'hello_world').exists():
            hello = client.get_component(name='hello_world')
        else:
            hello = client.create_app_component(name='hello_world', platform=str(xpfm),
                domain=domain_name, template='hello_world')
        hello_status = hello.build()
        print('HELLO_BUILD_STATUS:', hello_status)
        if hello_status != 0:
            raise RuntimeError('Hello World build failed')
        if (ws / 'multi_protocol_app').exists():
            app = client.get_component(name='multi_protocol_app')
        else:
            app = client.create_app_component(name='multi_protocol_app', platform=str(xpfm),
                domain=domain_name, template='empty_application')
        sources = repo / 'software/src'
        app.import_files(from_loc=str(sources), files=[p.name for p in sources.iterdir()
            if p.suffix in {'.c', '.h'}])
        app.set_app_config(key='USER_COMPILE_OPTIMIZATION_LEVEL', values='-O3')
        app.set_app_config(key='USER_COMPILE_DEBUG_LEVEL', values='-g1')
        bsp = ws / platform_name / 'ps7_cortexa9_0' / domain_name / 'bsp/include'
        params = (bsp / 'xparameters.h').read_text()
        def macro(name):
            match = re.search(r'^#define\s+' + name + r'\s+(0x[0-9a-fA-F]+|[0-9]+)', params, re.M)
            if not match:
                raise RuntimeError('Missing generated BSP macro: ' + name)
            return int(match.group(1), 0)
        for name, expected in {
            'XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR': 0x40000000,
            'XPAR_XAXIVDMA_0_BASEADDR': 0x43000000,
            'XPAR_XVTC_0_BASEADDR': 0x43c00000,
            'XPAR_XUARTPS_0_BASEADDR': 0xe0001000,
            'XPAR_XIICPS_0_BASEADDR': 0xe0004000,
            'XPAR_XGPIOPS_0_BASEADDR': 0xe000a000,
        }.items():
            if macro(name) != expected:
                raise RuntimeError('Unexpected hardware address: ' + name)
        ddr_base = macro('XPAR_PS7_DDR_0_BASEADDRESS')
        framebuffer = ddr_base + 0x1000000
        reserved_end = framebuffer + 0x240000
        if reserved_end > macro('XPAR_PS7_DDR_0_HIGHADDRESS') + 1:
            raise RuntimeError('Framebuffers exceed physical DDR')
        ld = app.get_ld_script()
        regions = [m for m in ld.get_memory_regions() if 'ddr' in m['name'].lower()]
        if len(regions) != 1 or int(regions[0]['base_address'], 0) != ddr_base:
            raise RuntimeError('Unexpected application DDR linker region')
        ld.update_memory_region(name=regions[0]['name'], base_address=hex(ddr_base),
                                size=hex(framebuffer - ddr_base))
        ld.set_stack_size('0x10000')
        ld.set_heap_size('0x10000')
        app_status = app.build()
        print('APP_BUILD_STATUS:', app_status)
        if app_status != 0:
            raise RuntimeError('Application build failed')
        elf = ws / 'multi_protocol_app/build/multi_protocol_app.elf'
        if not elf.is_file():
            raise RuntimeError('Application build did not produce an ELF')
        data = elf.read_bytes()
        if data[:6] != b'\x7fELF\x01\x01':
            raise RuntimeError('Expected a 32-bit little-endian ARM ELF')
        if struct.unpack_from('<H', data, 18)[0] != 40:
            raise RuntimeError('Expected ARM ELF machine type')
        phoff = struct.unpack_from('<I', data, 28)[0]
        phsize, phnum = struct.unpack_from('<HH', data, 42)
        loads = []
        for i in range(phnum):
            kind, _, vaddr, paddr, filesz, memsz, _, _ = struct.unpack_from('<8I', data, phoff + i * phsize)
            if kind != 1 or memsz == 0:
                continue
            if paddr < reserved_end and paddr + memsz > framebuffer:
                raise RuntimeError('ELF LOAD segment overlaps reserved framebuffers')
            loads.append({'address': hex(paddr), 'memory_size': hex(memsz)})
        (ws / 'memory_verification.json').write_text(json.dumps({
            'xsa_sha256': digest, 'ddr_base': hex(ddr_base),
            'framebuffer_0': hex(framebuffer), 'framebuffer_1': hex(framebuffer + 0x120000),
            'reserved_end': hex(reserved_end), 'load_segments': loads,
            'elf_sha256': hashlib.sha256(data).hexdigest(), 'overlap': False}, indent=2))
        print('MIGRATION_VITIS_APP_DONE:', elf)
finally:
    # The shipped Windows client kills only its cmd wrapper, leaving Java holding
    # the workspace lock. Terminate the process tree owned by this client only.
    server = client._serverObj
    if os.name == 'nt' and server.cp is not None:
        subprocess.run(['taskkill', '/PID', str(server.cp.pid), '/T', '/F'],
                       capture_output=True, check=False)
    vitis.dispose()
