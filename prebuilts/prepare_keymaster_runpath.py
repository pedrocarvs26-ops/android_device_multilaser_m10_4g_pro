"""Stage original BSP ELF copies with a fixed private RUNPATH for secure exec."""
import hashlib
import json
import shutil
import struct
import subprocess
from pathlib import Path

base = Path(__file__).resolve().parent
source = base / 'keymaster-a10'
target = base / 'keymaster-a10-runpath'
assert not target.exists(), 'Refusing to replace an existing staged stack'
target.mkdir()
runpath = '/vendor/lib64/m10-keymaster-a10'
names = ['android.hardware.keymaster@4.0-unisoc.service', 'libkeymaster4.so',
         'libkeymaster4support.so', 'libkeymaster_messages.so', 'libkeymaster_portable.so',
         'libpuresoftkeymasterdevice.so', 'libtrusty.so',
         'android.hardware.keymaster@4.0.so', 'android.hardware.keymaster@3.0.so']

def section(path, wanted):
    data = path.read_bytes()
    assert data[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', data, 18)[0] == 183
    offset = struct.unpack_from('<Q', data, 40)[0]
    entry_size, count, strings_index = struct.unpack_from('<HHH', data, 58)
    entries = [struct.unpack_from('<IIQQQQIIQQ', data, offset+i*entry_size) for i in range(count)]
    strings = entries[strings_index]
    names_data = data[strings[4]:strings[4]+strings[5]]
    for e in entries:
        name = names_data[e[0]:].split(b'\0', 1)[0].decode()
        if name == wanted:
            return e[3], data[e[4]:e[4]+e[5]]
    raise AssertionError(wanted)

def symbols(path, undefined):
    args = ['nm', '-D', '-u' if undefined else '--defined-only', str(path)]
    return sorted(line.split()[-1] for line in subprocess.check_output(args, text=True).splitlines() if line.strip())

report = {}
for name in names:
    original, patched = source/name, target/name
    shutil.copyfile(original, patched)
    patched.chmod(0o755 if name.endswith('.service') else 0o644)
    subprocess.run(['patchelf', '--set-rpath', runpath, str(patched)], check=True)
    assert subprocess.check_output(['patchelf', '--print-rpath', str(patched)], text=True).strip() == runpath
    assert section(original, '.text') == section(patched, '.text'), name+' text changed'
    assert section(original, '.rodata') == section(patched, '.rodata'), name+' rodata changed'
    assert symbols(original, False) == symbols(patched, False), name+' exports changed'
    assert symbols(original, True) == symbols(patched, True), name+' imports changed'
    needed_original = subprocess.check_output(['patchelf', '--print-needed', str(original)], text=True)
    needed_patched = subprocess.check_output(['patchelf', '--print-needed', str(patched)], text=True)
    assert needed_original == needed_patched
    report[name] = dict(original_sha256=hashlib.sha256(original.read_bytes()).hexdigest(),
                       patched_sha256=hashlib.sha256(patched.read_bytes()).hexdigest(),
                       text_rodata_imports_exports_needed_preserved=True)
output = dict(runpath=runpath, files=report)
(target/'runpath-audit.json').write_text(json.dumps(output, indent=2)+'\n')
print(json.dumps(output, indent=2))
