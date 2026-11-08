import sys
from exe import *
RT=0x7d60
for a in sys.argv[2:]:
    off=int(a,16); print(f'===== RT {off:#x}')
    n=0
    for i in md.disasm(IMG[RT+off:RT+off+300],off):
        print(f'  {i.address:05x} {i.mnemonic} {i.op_str}')
        n+=1
        if n>=int(sys.argv[1]) : break
