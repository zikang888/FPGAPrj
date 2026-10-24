"""Live two-board regression. Uses pyserial in the system Python environment."""
from pathlib import Path
import argparse, json, re, subprocess, time
import serial
from datetime import datetime

REPO = Path(__file__).resolve().parents[1]
ROOT = REPO.parents[1] / 'migration_build/2026.1/board' / datetime.now().strftime('%Y%m%d')
ROOT.mkdir(parents=True, exist_ok=True)
XSDB = r'E:\AMDDesignTools\2026.1\Vitis\bin\xsdb.bat'
p = argparse.ArgumentParser()
p.add_argument('mode', choices=['load', 'platform', 'protocols', 'home', 'dump', 'faults'])
p.add_argument('--ps', required=True)
p.add_argument('--stm', required=True)
args = p.parse_args()

def jtag(action, label, *extra):
    cp = subprocess.run([XSDB, str(REPO/'fpga/build/board_2026_1.tcl'), action, *map(str, extra)],
                        capture_output=True, timeout=45)
    output = (cp.stdout + cp.stderr).decode('utf-8', errors='replace')
    (ROOT/(label+'.log')).write_text(output, encoding='utf-8')
    print(output if action != 'stats' else '\n'.join(output.splitlines()[:40]), flush=True)
    if cp.returncode or f'BOARD_PROBE_DONE {action}' not in output:
        raise RuntimeError(f'{label} failed or incomplete ({cp.returncode})')
    return {k:int(v, 0) for k,v in re.findall(r'^STAT (\w+) (\w+)', output, re.M)}

with serial.Serial(args.ps, 115200, timeout=.1) as ps, serial.Serial(args.stm, 115200, timeout=.1) as stm:
    log = (ROOT/(args.mode+'_serial.log')).open('a', encoding='utf-8')
    def receive(seconds):
        stop = time.monotonic()+seconds
        data = {'PS':'', 'STM':''}
        while time.monotonic()<stop:
            for label, port in [('PS',ps),('STM',stm)]:
                if port.in_waiting:
                    s=port.read(port.in_waiting).decode('utf-8',errors='replace')
                    data[label]+=s
                    log.write(f'[{label}] {s}'); log.flush()
                    print(f'[{label}] {s}', end='', flush=True)
            time.sleep(.01)
        return data
    def send(port, command, wait=1):
        label='PS' if port is ps else 'STM'
        msg=f'\nSEND {label}: {command}\n'
        print(msg,flush=True); log.write(msg);log.flush()
        port.write((command+'\r').encode())
        return receive(wait)
    receive(.3)
    if args.mode=='load':
        cp = subprocess.Popen([XSDB, str(REPO/'tools/program_2026_1.tcl'), str(ROOT/'candidate')],
                              stdout=(ROOT/'program_fixed.log').open('wb'),stderr=subprocess.STDOUT)
        deadline=time.monotonic()+60
        while cp.poll() is None and time.monotonic()<deadline:receive(.2)
        if cp.poll() is None:
            cp.kill();raise RuntimeError('Loader timeout')
        if cp.returncode or 'JTAG_CANDIDATE_STARTED:' not in (ROOT/'program_fixed.log').read_text(errors='replace'):
            raise RuntimeError('Loader failed or incomplete')
        receive(4)
        send(ps,'status')
    elif args.mode=='platform':
        jtag('platform','platform_verified')
        send(ps,'status')
    elif args.mode=='protocols':
        results={}
        for protocol,command,wait in [('spi','spi jedec 100',12),('uart','uart loop 1',4),('i2c','i2c eeprom 1',4),('can','can loop 1',5)]:
            send(ps,'protocol '+protocol)
            response=send(ps,'test start')['PS']
            if 'TEST START id=' not in response: raise RuntimeError('No test start response')
            jtag('clear',protocol+'_clear')
            stimulus=send(stm,command,wait)['STM']
            live=send(ps,'status')['PS']
            saved=send(ps,'test stop')['PS']
            stats=jtag('stats',protocol+'_stats')
            results[protocol]={'stimulus':stimulus,'live':live,'saved':saved,'stats':stats}
            (ROOT/'protocol_results.json').write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding='utf-8')
            if protocol=='spi':
                expected={'SPI_EVENTS':600,'SPI_STARTS':100,'SPI_DATA':400,'SPI_ENDS':100}
                errors=['EXT_DROPPED','SPI_FRAME','SPI_BOUNDARY','SPI_DUPLICATE','SPI_SEQUENCE','SPI_SHORT','SPI_EXTRA','SPI_MISMATCH']
                results[protocol]['counter_pass']=all(stats[k]==v for k,v in expected.items()) and all(stats[k]==0 for k in errors)
                results[protocol]['stm_pass']='pass=100 fail=0' in stimulus or bool(re.search(r'(?:passed|pass)\s*[=:]\s*100.*(?:failed|fail)\s*[=:]\s*0',stimulus,re.I))
        send(ps,'view history');send(ps,'status')
        send(ps,'view home')
        (ROOT/'protocol_results.json').write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding='utf-8')
    elif args.mode=='home':
        results={}
        for protocol,command in [('spi','spi jedec 1'),('uart','uart loop 1'),('i2c','i2c eeprom 1'),('can','can loop 1')]:
            send(ps,'protocol '+protocol);send(ps,'view home')
            data=send(stm,command,4)
            results[protocol]={'serial':data,'stats':jtag('stats','home_'+protocol)}
            jtag('dump','dump_'+protocol,ROOT/('home_'+protocol))
        (ROOT/'home_results.json').write_text(json.dumps(results,ensure_ascii=False,indent=2),encoding='utf-8')
    elif args.mode=='dump':jtag('dump','display_dump',ROOT/'display')
    elif args.mode=='faults':send(stm,'fault list',2)
    log.close()
