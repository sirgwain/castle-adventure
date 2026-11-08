import sys
from collections import defaultdict
from exe import *
ins=list(md.disasm(CODE,0))
# linear sweep may desync after inline data; report gaps later
calls=defaultdict(list)
for k,i in enumerate(ins):
    if i.mnemonic=='lcall' and i.op_str.startswith('0x7d6,'):
        t=int(i.op_str.split(',')[1],16)
        ctx=[]
        for j in ins[max(0,k-4):k]:
            s=f'{j.mnemonic} {j.op_str}'
            for tok in j.op_str.replace(',',' ').replace(']',' ').replace('[',' ').split():
                if tok.startswith('0x'):
                    st=ds_string(int(tok,16))
                    if st is not None: s+=f' ;"{st[:20]}"'
            ctx.append(s)
        nxt=ins[k+1]
        calls[t].append((i.address,ctx,f'{nxt.mnemonic} {nxt.op_str}'))
for t in sorted(calls):
    v=calls[t]
    print(f'=== {t:#06x}  n={len(v)}')
    for a,ctx,n in v[:3]:
        print(f'   {a:05x}: '+' | '.join(ctx)+f'  -> after: {n}')
