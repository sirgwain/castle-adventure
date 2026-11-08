L001A:
  0001a  lcall 0xe78, 0
  0001f  push bp
  00020  mov bp, sp
  00022  sub sp, 2
  00026  lcall 0x7d6, 0x2582
  0002b  lcall 0x7d6, 0x1c9a  db 44 6f
  00032  lcall 0x7d6, 0x1c9a  db 39 6b
L0039:
  00039  mov bx, 0x70ec
  0003c  lcall 0x7d6, 0x16bc
  00041  mov bx, 0x28
  00044  lcall 0x7d6, 0x300b
  00049  mov di, 0xf1a
  0004c  mov si, 0x1040
  0004f  lcall 0x7d6, 0x10a6
  00054  mov di, 0xf1e
  00057  mov si, 0x1044
  0005a  lcall 0x7d6, 0x10a6
  0005f  mov di, 0xf22
  00062  lcall 0x7d6, 0x10a6
  00067  mov di, 0xf26
  0006a  mov si, 0x1040
  0006d  lcall 0x7d6, 0x10a6
  00072  mov di, 0xf2a
  00075  lcall 0x7d6, 0x10a6
  0007a  mov di, 0xf2e
  0007d  mov si, 0x1048
  00080  lcall 0x7d6, 0x10a6
  00085  mov si, 0x1040
  00088  lcall 0x7d6, 0x10bd
  0008d  jmp 0xe1
L0090:
  00090  mov si, 0xf32
  00093  mov dx, si
  00095  lcall 0x7d6, 0x227f
  0009a  shl bx, 1
  0009c  shl bx, 1
  0009e  mov cx, bx
  000a0  add bx, 0xc26
  000a4  lcall 0x7d6, 0x25fa
  000a9  mov bx, cx
  000ab  add cx, 0xc82
  000af  mov ax, bx
  000b1  mov bx, cx
  000b3  lcall 0x7d6, 0x260f
  000b8  mov bx, ax
  000ba  add ax, 0xe46
  000bd  xchg bx, ax
  000be  lcall 0x7d6, 0x25fa
  000c3  mov bx, ax
  000c5  add ax, 0xcde
  000c8  xchg bx, ax
  000c9  lcall 0x7d6, 0x25fa
  000ce  add ax, 0xd3a
  000d1  xchg bx, ax
  000d2  lcall 0x7d6, 0x25fa
  000d7  mov si, dx
  000d9  mov di, 0x1040
  000dc  lcall 0x7d6, 0x1772
L00E1:
  000e1  mov di, 0xf32
  000e4  lcall 0x7d6, 0x10a3
  000e9  mov si, di
  000eb  mov di, 0x104c
  000ee  lcall 0x7d6, 0x19ce
  000f3  jbe 0x90
  000f5  mov si, 0x1040
  000f8  lcall 0x7d6, 0x10bd
  000fd  jmp 0x15c
L0100:
  00100  mov si, 0xf32
  00103  mov dx, si
  00105  lcall 0x7d6, 0x227f
  0010a  shl bx, 1
  0010c  shl bx, 1
  0010e  mov cx, bx
  00110  add bx, 0xd96
  00114  lcall 0x7d6, 0x25fa
  00119  mov bx, cx
  0011b  add cx, 0xe1a
  0011f  mov ax, bx
  00121  mov bx, cx
  00123  lcall 0x7d6, 0x260f
  00128  mov bx, ax
  0012a  add ax, 0xea2
  0012d  xchg bx, ax
  0012e  lcall 0x7d6, 0x25fa
  00133  mov bx, ax
  00135  add ax, 0xdc2
  00138  xchg bx, ax
  00139  lcall 0x7d6, 0x25fa
  0013e  mov bx, ax
  00140  add ax, 0xdee
  00143  xchg bx, ax
  00144  lcall 0x7d6, 0x25fa
  00149  add ax, 0xeee
  0014c  xchg bx, ax
  0014d  lcall 0x7d6, 0x25fa
  00152  mov si, dx
  00154  mov di, 0x1040
  00157  lcall 0x7d6, 0x1772
L015C:
  0015c  mov di, 0xf32
  0015f  lcall 0x7d6, 0x10a3
  00164  mov si, di
  00166  mov di, 0x1050
  00169  lcall 0x7d6, 0x19ce
  0016e  jbe 0x100
  00170  mov bx, 0x1054  ; 'CASTLE.RAN'
  00173  lcall 0x7d6, 0x2136
  00178  mov dx, bx
  0017a  mov bx, 2
  0017d  lcall 0x7d6, 0xd15
  00182  mov bx, 1
  00185  mov cx, 0x23f
  00188  lcall 0x7d6, 0xd24
  0018d  mov bx, 1
  00190  lcall 0x7d6, 0x2ed8
  00195  mov bx, 0xf36
  00198  mov dx, 0x18
  0019b  lcall 0x7d6, 0x2efa
  001a0  mov bx, 0xf3a
  001a3  lcall 0x7d6, 0x2efa
  001a8  mov bx, 0xf3e
  001ab  lcall 0x7d6, 0x2efa
  001b0  mov bx, 0xf42
  001b3  lcall 0x7d6, 0x2efa
  001b8  mov bx, 0xf46
  001bb  lcall 0x7d6, 0x2efa
  001c0  mov bx, 0xf4a
  001c3  lcall 0x7d6, 0x2efa
  001c8  mov bx, 0xf4e
  001cb  lcall 0x7d6, 0x2efa
  001d0  mov bx, 0xf52
  001d3  lcall 0x7d6, 0x2efa
  001d8  mov bx, 0xf56
  001db  lcall 0x7d6, 0x2efa
  001e0  mov bx, 0xf5a
  001e3  lcall 0x7d6, 0x2efa
  001e8  mov bx, 0xf5e
  001eb  lcall 0x7d6, 0x2efa
  001f0  mov bx, 0xf62
  001f3  lcall 0x7d6, 0x2efa
  001f8  mov bx, 0xf66
  001fb  lcall 0x7d6, 0x2efa
  00200  mov bx, 0xf6a
  00203  lcall 0x7d6, 0x2efa
  00208  mov bx, 0xf6e
  0020b  lcall 0x7d6, 0x2efa
  00210  mov bx, 0xf72
  00213  lcall 0x7d6, 0x2efa
  00218  mov bx, 0xf76
  0021b  lcall 0x7d6, 0x2efa
  00220  mov bx, 0xf7a
  00223  lcall 0x7d6, 0x2efa
  00228  mov bx, 0xf7e
  0022b  mov dx, 0x7d
  0022e  lcall 0x7d6, 0x2efa
  00233  mov bx, 0xf82
  00236  mov dx, 0x12
  00239  lcall 0x7d6, 0x2efa
L023E:
  0023e  mov di, 0x1062
  00241  mov si, 0xf1a
  00244  lcall 0x7d6, 0x1772
  00249  mov dx, si
  0024b  lcall 0x7d6, 0x22ca
  00250  xchg bx, ax
  00251  mov bx, dx
  00253  mov cx, 0xa
  00256  cdq 
  00257  idiv cx
  00259  imul cx
  0025b  inc ax
  0025c  xchg bx, ax
  0025d  lcall 0x7d6, 0x2237
  00262  mov di, 0xf86
  00265  lcall 0x7d6, 0x10a3
  0026a  xchg si, ax
  0026b  lcall 0x7d6, 0x175d
  00270  mov di, 0x1040
  00273  lcall 0x7d6, 0x1767
  00278  mov di, 0xf8a
  0027b  lcall 0x7d6, 0x10a3
  00280  mov di, 0x1066
  00283  mov si, 0xf86
  00286  lcall 0x7d6, 0x1772
  0028b  mov di, 0xf8e
  0028e  mov bx, si
  00290  lcall 0x7d6, 0x10a3
  00295  mov si, bx
  00297  lcall 0x7d6, 0x10bd
  0029c  jmp 0x452
L029F:
  0029f  mov si, 0xf92
  002a2  mov dx, si
  002a4  lcall 0x7d6, 0x227f
  002a9  mov cx, dx
  002ab  mov dx, bx
  002ad  mov bx, 1
  002b0  lcall 0x7d6, 0xccb
  002b5  mov si, cx
  002b7  mov di, 0xf86
  002ba  lcall 0x7d6, 0x175d
  002bf  mov di, 0x1040
  002c2  lcall 0x7d6, 0x1767
  002c7  mov di, 0xf32
  002ca  lcall 0x7d6, 0x10a3
  002cf  mov si, 0xf32
  002d2  lcall 0x7d6, 0x227f
  002d7  xchg bx, ax
  002d8  mov bx, 0x54
  002db  imul bx
  002dd  mov bx, ax
  002df  add ax, 0x876
  002e2  xchg dx, ax
  002e3  mov cx, bx
  002e5  mov bx, 0xf36
  002e8  lcall 0x7d6, 0xf62
  002ed  mov bx, cx
  002ef  add cx, 0x87a
  002f3  mov dx, cx
  002f5  mov ax, bx
  002f7  mov bx, 0xf3a
  002fa  lcall 0x7d6, 0xf62
  002ff  mov bx, ax
  00301  add ax, 0x87e
  00304  xchg dx, ax
  00305  mov cx, bx
  00307  mov bx, 0xf3e
  0030a  lcall 0x7d6, 0xf62
  0030f  mov bx, cx
  00311  add cx, 0x882
  00315  mov dx, cx
  00317  mov ax, bx
  00319  mov bx, 0xf42
  0031c  lcall 0x7d6, 0xf62
  00321  add ax, 0x886
  00324  xchg dx, ax
  00325  mov bx, 0xf46
  00328  lcall 0x7d6, 0xf62
  0032d  mov si, 0xf32
  00330  lcall 0x7d6, 0x227f
  00335  xchg bx, ax
  00336  mov bx, 0x54
  00339  imul bx
  0033b  mov bx, ax
  0033d  add ax, 0x88a
  00340  xchg dx, ax
  00341  mov cx, bx
  00343  mov bx, 0xf4a
  00346  lcall 0x7d6, 0xf62
  0034b  mov bx, cx
  0034d  add cx, 0x88e
  00351  mov dx, cx
  00353  mov ax, bx
  00355  mov bx, 0xf4e
  00358  lcall 0x7d6, 0xf62
  0035d  mov bx, ax
  0035f  add ax, 0x892
  00362  xchg dx, ax
  00363  mov cx, bx
  00365  mov bx, 0xf52
  00368  lcall 0x7d6, 0xf62
  0036d  mov bx, cx
  0036f  add cx, 0x896
  00373  mov dx, cx
  00375  mov ax, bx
  00377  mov bx, 0xf56
  0037a  lcall 0x7d6, 0xf62
  0037f  add ax, 0x89a
  00382  xchg dx, ax
  00383  mov bx, 0xf5a
  00386  lcall 0x7d6, 0xf62
  0038b  mov si, 0xf32
  0038e  lcall 0x7d6, 0x227f
  00393  xchg bx, ax
  00394  mov bx, 0x54
  00397  imul bx
  00399  mov bx, ax
  0039b  add ax, 0x89e
  0039e  xchg dx, ax
  0039f  mov cx, bx
  003a1  mov bx, 0xf5e
  003a4  lcall 0x7d6, 0xf62
  003a9  mov bx, cx
  003ab  add cx, 0x8a2
  003af  mov dx, cx
  003b1  mov ax, bx
  003b3  mov bx, 0xf62
  003b6  lcall 0x7d6, 0xf62
  003bb  mov bx, ax
  003bd  add ax, 0x8a6
  003c0  xchg dx, ax
  003c1  mov cx, bx
  003c3  mov bx, 0xf66
  003c6  lcall 0x7d6, 0xf62
  003cb  mov bx, cx
  003cd  add cx, 0x8aa
  003d1  mov dx, cx
  003d3  mov ax, bx
  003d5  mov bx, 0xf6a
  003d8  lcall 0x7d6, 0xf62
  003dd  add ax, 0x8ae
  003e0  xchg dx, ax
  003e1  mov bx, 0xf6e
  003e4  lcall 0x7d6, 0xf62
  003e9  mov si, 0xf32
  003ec  lcall 0x7d6, 0x227f
  003f1  xchg bx, ax
  003f2  mov bx, 0x54
  003f5  imul bx
  003f7  mov bx, ax
  003f9  add ax, 0x8b2
  003fc  xchg dx, ax
  003fd  mov cx, bx
  003ff  mov bx, 0xf72
  00402  lcall 0x7d6, 0xf62
  00407  mov bx, cx
  00409  add cx, 0x8b6
  0040d  mov dx, cx
  0040f  mov ax, bx
  00411  mov bx, 0xf76
  00414  lcall 0x7d6, 0xf62
  00419  mov bx, ax
  0041b  add ax, 0x8ba
  0041e  xchg dx, ax
  0041f  mov cx, bx
  00421  mov bx, 0xf7a
  00424  lcall 0x7d6, 0xf62
  00429  mov bx, cx
  0042b  add cx, 0x8be
  0042f  mov dx, cx
  00431  mov ax, bx
  00433  mov bx, 0xf7e
  00436  lcall 0x7d6, 0xf62
  0043b  add ax, 0x8c2
  0043e  xchg dx, ax
  0043f  mov bx, 0xf82
  00442  lcall 0x7d6, 0xf62
  00447  mov di, 0x1040
  0044a  mov si, 0xf92
  0044d  lcall 0x7d6, 0x1772
L0452:
  00452  mov di, 0xf92
  00455  lcall 0x7d6, 0x10a3
  0045a  mov si, di
  0045c  mov di, 0xf8e
  0045f  lcall 0x7d6, 0x19ce
  00464  ja 0x469
  00466  jmp 0x29f
L0469:
  00469  lcall 0x7d6, 0x789
  0046e  mov bx, 0x106a  ; ''
  00471  mov dx, 0xf96
  00474  lcall 0x7d6, 0xf62
  00479  xor bx, bx
  0047b  lcall 0x7d6, 0x13c9
  00480  mov bx, 0x41c
  00483  mov ds, word ptr [0x90]
  00487  mov bl, byte ptr [bx]
  00489  xor bh, bh
  0048b  push es
  0048c  pop ds
  0048d  xchg bx, ax
  0048e  mov bx, 0x41a
  00491  mov ds, word ptr [0x90]
  00495  mov byte ptr [bx], al
  00497  push es
  00498  pop ds
  00499  mov si, 0x1040
  0049c  lcall 0x7d6, 0x10bd
  004a1  jmp 0x4d2
L04A4:
  004a4  mov si, 0xf32
  004a7  mov dx, si
  004a9  lcall 0x7d6, 0x227f
  004ae  lcall 0x7d6, 0xffd
  004b3  mov bx, 0x19
  004b6  lcall 0x7d6, 0x1017
  004bb  lcall 0x7d6, 0x3021
  004c0  mov bx, 0x106e  ; '│'
  004c3  lcall 0x7d6, 0x2d8d
  004c8  mov si, dx
  004ca  mov di, 0x1040
  004cd  lcall 0x7d6, 0x1772
L04D2:
  004d2  mov di, 0xf32
  004d5  lcall 0x7d6, 0x10a3
  004da  mov si, di
  004dc  mov di, 0x1074
  004df  lcall 0x7d6, 0x19ce
  004e4  jbe 0x4a4
  004e6  mov si, 0x1040
  004e9  lcall 0x7d6, 0x10bd
  004ee  jmp 0x51f
L04F1:
  004f1  mov bx, 0x13
  004f4  lcall 0x7d6, 0xffd
  004f9  mov si, 0xf32
  004fc  mov dx, si
  004fe  lcall 0x7d6, 0x227f
  00503  lcall 0x7d6, 0x1017
  00508  lcall 0x7d6, 0x3021
  0050d  mov bx, 0x1078  ; '─'
  00510  lcall 0x7d6, 0x2d8d
  00515  mov si, dx
  00517  mov di, 0x1040
  0051a  lcall 0x7d6, 0x1772
L051F:
  0051f  mov di, 0xf32
  00522  lcall 0x7d6, 0x10a3
  00527  mov si, di
  00529  mov di, 0x107e
  0052c  lcall 0x7d6, 0x19ce
  00531  jbe 0x4f1
  00533  mov bx, 0x13
  00536  lcall 0x7d6, 0xffd
  0053b  mov bx, 0x19
  0053e  lcall 0x7d6, 0x1017
  00543  lcall 0x7d6, 0x3021
  00548  mov bx, 0x1082  ; '┘'
  0054b  lcall 0x7d6, 0x2d8d
  00550  mov si, 0x1040
  00553  lcall 0x7d6, 0x10bd
  00558  jmp 0x5ac
L055B:
  0055b  mov si, 0xf32
  0055e  mov dx, si
  00560  lcall 0x7d6, 0x227f
  00565  lcall 0x7d6, 0xffd
  0056a  mov cx, bx
  0056c  mov bx, 1
  0056f  lcall 0x7d6, 0xffd
  00574  xor bx, bx
  00576  lcall 0x7d6, 0x1017
  0057b  lcall 0x7d6, 0x3021
  00580  mov bx, dx
  00582  mov dx, bx
  00584  mov si, 0xf8a
  00587  lcall 0x7d6, 0x227f
  0058c  xchg bx, ax
  0058d  mov bx, dx
  0058f  mov dx, 0x15
  00592  imul dx
  00594  add ax, cx
  00596  shl ax, 1
  00598  shl ax, 1
  0059a  add ax, 0x872
  0059d  xchg bx, ax
  0059e  lcall 0x7d6, 0x2d8d
  005a3  xchg si, ax
  005a4  mov di, 0x1040
  005a7  lcall 0x7d6, 0x1772
L05AC:
  005ac  mov di, 0xf32
  005af  lcall 0x7d6, 0x10a3
  005b4  mov si, di
  005b6  mov di, 0x1074
  005b9  lcall 0x7d6, 0x19ce
  005be  jbe 0x55b
  005c0  mov si, 0xf8a
  005c3  lcall 0x7d6, 0x227f
  005c8  xchg bx, ax
  005c9  mov bx, 0x54
  005cc  imul bx
  005ce  add ax, 0x8be
  005d1  xchg bx, ax
  005d2  mov dx, 0xf9a
  005d5  lcall 0x7d6, 0xf62
  005da  mov bx, dx
  005dc  lcall 0x7d6, 0x2386
  005e1  cmp bx, 0x7d
  005e4  jl 0x5e9
  005e6  jmp 0x606
L05E9:
  005e9  mov bx, dx
  005eb  lcall 0x7d6, 0x2386
  005f0  sub bx, 0x7d
  005f3  neg bx
  005f5  lcall 0x7d6, 0x24b5
  005fa  xchg dx, ax
  005fb  lcall 0x7d6, 0xf98
  00600  xchg dx, ax
  00601  lcall 0x7d6, 0xf62
L0606:
  00606  mov si, 0x1088
  00609  lcall 0x7d6, 0x10bd
  0060e  jmp 0x668
L0611:
  00611  mov di, 0x1040
  00614  mov si, 0xf32
  00617  lcall 0x7d6, 0x1772
  0061c  mov dx, si
  0061e  lcall 0x7d6, 0x10d1
  00623  sbb word ptr [bp + si + 0x22ca], 0x7d6
  00629  shl bx, 1
  0062b  shl bx, 1
  0062d  add bx, 0xc0e
  00631  mov si, dx
  00633  mov cx, di
  00635  mov di, 0x108c
  00638  lcall 0x7d6, 0x18aa
  0063d  mov di, cx
  0063f  lcall 0x7d6, 0x1767
  00644  mov dx, bx
  00646  lcall 0x7d6, 0x22ca
  0064b  mov ax, dx
  0064d  mov dx, bx
  0064f  mov bx, 0xf9a
  00652  mov cx, 0x19
  00655  lcall 0x7d6, 0x2486
  0065a  xchg dx, ax
  0065b  lcall 0x7d6, 0xf62
  00660  mov si, 0x102a
  00663  lcall 0x7d6, 0x10bd
L0668:
  00668  mov di, 0xf32
  0066b  lcall 0x7d6, 0x10a3
  00670  mov si, di
  00672  mov di, 0x1090
  00675  lcall 0x7d6, 0x19ce
  0067a  jbe 0x611
  0067c  mov si, 0x1040
  0067f  lcall 0x7d6, 0x10bd
  00684  jmp 0x6c9
L0687:
  00687  mov di, 0x1094
  0068a  mov si, 0xf32
  0068d  lcall 0x7d6, 0x1772
  00692  mov dx, si
  00694  lcall 0x7d6, 0x22ca
  00699  lcall 0x7d6, 0xffd
  0069e  mov bx, 1
  006a1  lcall 0x7d6, 0x1017
  006a6  lcall 0x7d6, 0x3021
  006ab  mov si, dx
  006ad  lcall 0x7d6, 0x227f
  006b2  shl bx, 1
  006b4  shl bx, 1
  006b6  add bx, 0xc0e
  006ba  lcall 0x7d6, 0x2d79
  006bf  mov si, dx
  006c1  mov di, 0x1040
  006c4  lcall 0x7d6, 0x1772
L06C9:
  006c9  mov di, 0xf32
  006cc  lcall 0x7d6, 0x10a3
  006d1  mov si, di
  006d3  mov di, 0x1098
  006d6  lcall 0x7d6, 0x19ce
  006db  jbe 0x687
  006dd  mov di, 0xf9e
  006e0  mov si, 0x109c
  006e3  lcall 0x7d6, 0x10a6
  006e8  mov si, 0x1040
  006eb  lcall 0x7d6, 0x10bd
  006f0  jmp 0x7e6
L06F3:
  006f3  mov si, 0xf32
  006f6  lcall 0x7d6, 0x227f
  006fb  mov si, bx
  006fd  shl si, 1
  006ff  shl si, 1
  00701  mov bx, si
  00703  add si, 0xc26
  00707  mov di, 0xf1a
  0070a  lcall 0x7d6, 0x19ce
  0070f  je 0x714
  00711  jmp 0x754
L0714:
  00714  mov dx, bx
  00716  add bx, 0xcde
  0071a  mov si, bx
  0071c  lcall 0x7d6, 0x227f
  00721  lcall 0x7d6, 0xffd
  00726  mov bx, dx
  00728  add dx, 0xd3a
  0072c  mov si, dx
  0072e  mov cx, bx
  00730  lcall 0x7d6, 0x227f
  00735  lcall 0x7d6, 0x1017
  0073a  lcall 0x7d6, 0x3021
  0073f  add cx, 0xe46
  00743  mov si, cx
  00745  lcall 0x7d6, 0x227f
  0074a  lcall 0x7d6, 0x23be
  0074f  lcall 0x7d6, 0x2d79
L0754:
  00754  mov si, 0xf32
  00757  lcall 0x7d6, 0x227f
  0075c  mov si, bx
  0075e  shl si, 1
  00760  shl si, 1
  00762  mov bx, si
  00764  add si, 0xc26
  00768  mov di, 0xf1a
  0076b  lcall 0x7d6, 0x19ce
  00770  je 0x775
  00772  jmp 0x7db
L0775:
  00775  mov di, 0x1040
  00778  mov si, 0xf9e
  0077b  lcall 0x7d6, 0x1772
  00780  mov di, si
  00782  lcall 0x7d6, 0x10a3
  00787  mov si, di
  00789  mov di, 0x10a0
  0078c  lcall 0x7d6, 0x19ce
  00791  jb 0x796
  00793  jmp 0x7db
L0796:
  00796  mov dx, bx
  00798  lcall 0x7d6, 0x227f
  0079d  lcall 0x7d6, 0xffd
  007a2  mov bx, 0x1a
  007a5  lcall 0x7d6, 0x1017
  007aa  lcall 0x7d6, 0x3021
  007af  mov bx, dx
  007b1  add dx, 0xe46
  007b5  mov si, dx
  007b7  mov cx, bx
  007b9  lcall 0x7d6, 0x227f
  007be  lcall 0x7d6, 0x23be
  007c3  lcall 0x7d6, 0x2d79
  007c8  mov bx, 0x10a4  ; ' '
  007cb  lcall 0x7d6, 0x2d79
  007d0  add cx, 0xc82
  007d4  mov bx, cx
  007d6  lcall 0x7d6, 0x2d79
L07DB:
  007db  mov di, 0x1040
  007de  mov si, 0xf32
  007e1  lcall 0x7d6, 0x1772
L07E6:
  007e6  mov di, 0xf32
  007e9  lcall 0x7d6, 0x10a3
  007ee  mov si, di
  007f0  mov di, 0x104c
  007f3  lcall 0x7d6, 0x19ce
  007f8  ja 0x7fd
  007fa  jmp 0x6f3
L07FD:
  007fd  mov di, 0x10aa
  00800  mov si, 0xf1a
  00803  lcall 0x7d6, 0x19ce
  00808  mov bx, 0
  0080b  jne 0x80e
  0080d  dec bx
L080E:
  0080e  mov dx, di
  00810  mov di, 0x10ae
  00813  mov si, 0xfa2
  00816  lcall 0x7d6, 0x19ce
  0081b  mov cx, 0
  0081e  je 0x821
  00820  dec cx
L0821:
  00821  and cx, bx
  00823  and cx, cx
  00825  jne 0x82a
  00827  jmp 0x84a
L082A:
  0082a  mov si, dx
  0082c  mov di, 0xdbe
  0082f  lcall 0x7d6, 0x10a6
  00834  mov di, 0xdea
  00837  mov si, 0x1050
  0083a  lcall 0x7d6, 0x10a6
  0083f  mov di, 0xe16
  00842  mov si, 0x1040
  00845  lcall 0x7d6, 0x10a6
L084A:
  0084a  mov di, 0x10b2
  0084d  mov si, 0xf1a
  00850  lcall 0x7d6, 0x19ce
  00855  mov bx, 0
  00858  jne 0x85b
  0085a  dec bx
L085B:
  0085b  mov dx, di
  0085d  mov di, 0x10ae
  00860  mov si, 0xfa2
  00863  lcall 0x7d6, 0x19ce
  00868  mov cx, 0
  0086b  je 0x86e
  0086d  dec cx
L086E:
  0086e  and cx, bx
  00870  and cx, cx
  00872  jne 0x877
  00874  jmp 0x897
L0877:
  00877  mov si, dx
  00879  mov di, 0xdbe
  0087c  lcall 0x7d6, 0x10a6
  00881  mov di, 0xdea
  00884  mov si, 0x1040
  00887  lcall 0x7d6, 0x10a6
  0088c  mov di, 0xe16
  0088f  mov si, 0x10b6
  00892  lcall 0x7d6, 0x10a6
L0897:
  00897  mov di, 0xfa6
  0089a  mov si, 0x10ba
  0089d  lcall 0x7d6, 0x10a6
  008a2  mov di, 0xfaa
  008a5  lcall 0x7d6, 0x10a6
  008aa  mov si, 0x1040
  008ad  lcall 0x7d6, 0x10bd
  008b2  jmp 0x9e3
L08B5:
  008b5  mov si, 0xf32
  008b8  mov dx, si
  008ba  lcall 0x7d6, 0x227f
  008bf  mov si, bx
  008c1  shl si, 1
  008c3  shl si, 1
  008c5  mov bx, si
  008c7  add si, 0xd96
  008cb  mov di, 0xf1a
  008ce  lcall 0x7d6, 0x19ce
  008d3  je 0x8d8
  008d5  jmp 0x947
L08D8:
  008d8  mov cx, bx
  008da  add bx, 0xdc2
  008de  mov si, bx
  008e0  lcall 0x7d6, 0x227f
  008e5  lcall 0x7d6, 0xffd
  008ea  mov bx, cx
  008ec  add cx, 0xdee
  008f0  mov si, cx
  008f2  mov ax, bx
  008f4  lcall 0x7d6, 0x227f
  008f9  lcall 0x7d6, 0x1017
  008fe  lcall 0x7d6, 0x3021
  00903  mov bx, ax
  00905  add ax, 0xea2
  00908  xchg si, ax
  00909  mov cx, bx
  0090b  lcall 0x7d6, 0x227f
  00910  lcall 0x7d6, 0x23be
  00915  lcall 0x7d6, 0x2d79
  0091a  mov si, dx
  0091c  mov di, 0x1066
  0091f  lcall 0x7d6, 0x19ce
  00924  jb 0x929
  00926  jmp 0x947
L0929:
  00929  add cx, 0xeee
  0092d  mov si, cx
  0092f  mov di, 0x1062
  00932  lcall 0x7d6, 0x19ce
  00937  ja 0x93c
  00939  jmp 0x947
L093C:
  0093c  mov di, 0xfaa
  0093f  mov si, 0x1040
  00942  lcall 0x7d6, 0x10a6
L0947:
  00947  mov si, 0xf32
  0094a  lcall 0x7d6, 0x227f
  0094f  mov si, bx
  00951  shl si, 1
  00953  shl si, 1
  00955  mov bx, si
  00957  add si, 0xd96
  0095b  mov di, 0xf1a
  0095e  lcall 0x7d6, 0x19ce
  00963  je 0x968
  00965  jmp 0x9d8
L0968:
  00968  mov di, 0x1040
  0096b  mov si, 0xfa6
  0096e  lcall 0x7d6, 0x1772
  00973  mov di, si
  00975  lcall 0x7d6, 0x10a3
  0097a  mov si, di
  0097c  mov di, 0x10be
  0097f  lcall 0x7d6, 0x19ce
  00984  jb 0x989
  00986  jmp 0x9d8
L0989:
  00989  mov di, si
  0098b  mov si, 0xf9e
  0098e  lcall 0x7d6, 0x1772
  00993  mov dx, bx
  00995  lcall 0x7d6, 0x22ca
  0099a  lcall 0x7d6, 0xffd
  0099f  mov bx, 0x1a
  009a2  lcall 0x7d6, 0x1017
  009a7  lcall 0x7d6, 0x3021
  009ac  mov bx, dx
  009ae  add dx, 0xea2
  009b2  mov si, dx
  009b4  mov cx, bx
  009b6  lcall 0x7d6, 0x227f
  009bb  lcall 0x7d6, 0x23be
  009c0  lcall 0x7d6, 0x2d79
  009c5  mov bx, 0x10a4  ; ' '
  009c8  lcall 0x7d6, 0x2d79
  009cd  add cx, 0xe1a
  009d1  mov bx, cx
  009d3  lcall 0x7d6, 0x2d79
L09D8:
  009d8  mov di, 0x1040
  009db  mov si, 0xf32
  009de  lcall 0x7d6, 0x1772
L09E3:
  009e3  mov di, 0xf32
  009e6  lcall 0x7d6, 0x10a3
  009eb  mov si, di
  009ed  mov di, 0x1050
  009f0  lcall 0x7d6, 0x19ce
  009f5  ja 0x9fa
  009f7  jmp 0x8b5
L09FA:
  009fa  mov di, 0x10c2
  009fd  mov si, 0xfa2
  00a00  lcall 0x7d6, 0x19ce
  00a05  je 0xa0a
  00a07  jmp 0xa95
L0A0A:
  00a0a  mov di, 0xf1e
  00a0d  mov si, 0x1050
  00a10  lcall 0x7d6, 0x10a6
  00a15  mov bx, di
  00a17  mov di, 0xf22
  00a1a  mov si, 0x10c6
  00a1d  lcall 0x7d6, 0x10a6
  00a22  mov dx, di
  00a24  mov di, 0xfae
  00a27  mov si, 0x10ca
  00a2a  lcall 0x7d6, 0x10a6
  00a2f  mov cx, bx
  00a31  mov si, cx
  00a33  lcall 0x7d6, 0x227f
  00a38  lcall 0x7d6, 0xffd
  00a3d  mov si, dx
  00a3f  lcall 0x7d6, 0x227f
  00a44  lcall 0x7d6, 0x1017
  00a49  lcall 0x7d6, 0x3021
  00a4e  mov bx, 5
  00a51  lcall 0x7d6, 0x23be
  00a56  lcall 0x7d6, 0x2d79
  00a5b  mov di, 0xfb2
  00a5e  mov si, 0x1090
  00a61  lcall 0x7d6, 0x10a6
  00a66  mov bx, 0x10ce  ; 'There is a puff'
  00a69  mov dx, 0xed2
  00a6c  lcall 0x7d6, 0xf62
  00a71  mov bx, 0x10e2  ; 'of smoke & you'
  00a74  mov dx, 0xed6
  00a77  lcall 0x7d6, 0xf62
  00a7c  mov bx, 0x10f4  ; 'appear in the'
  00a7f  mov dx, 0xeda
  00a82  lcall 0x7d6, 0xf62
  00a87  mov bx, 0x1106  ; 'Sorcerers room!'
  00a8a  mov dx, 0xede
  00a8d  lcall 0x7d6, 0xf62
  00a92  jmp 0x1bd7
L0A95:
  00a95  mov di, 0x111a
  00a98  mov si, 0xfa2
  00a9b  lcall 0x7d6, 0x19ce
  00aa0  je 0xaa5
  00aa2  jmp 0xac2
L0AA5:
  00aa5  mov bx, 0x12
  00aa8  lcall 0x7d6, 0xffd
  00aad  mov bx, 0xb
  00ab0  lcall 0x7d6, 0x1017
  00ab5  lcall 0x7d6, 0x3021
  00aba  mov bx, 0x111e  ; '▌  ▐'
  00abd  lcall 0x7d6, 0x2d79
L0AC2:
  00ac2  mov di, 0x1126
  00ac5  mov si, 0xf1a
  00ac8  lcall 0x7d6, 0x19ce
  00acd  mov bx, 0
  00ad0  jne 0xad3
  00ad2  dec bx
L0AD3:
  00ad3  mov di, 0x1040
  00ad6  mov si, 0xf26
  00ad9  lcall 0x7d6, 0x19ce
  00ade  mov dx, 0
  00ae1  jne 0xae4
  00ae3  dec dx
L0AE4:
  00ae4  and dx, bx
  00ae6  and dx, dx
  00ae8  jne 0xaed
  00aea  jmp 0xb1d
L0AED:
  00aed  mov bx, 0xf
  00af0  lcall 0x7d6, 0xffd
  00af5  mov bx, 9
  00af8  lcall 0x7d6, 0x1017
  00afd  lcall 0x7d6, 0x3021
  00b02  mov bx, 8
  00b05  mov dx, bx
  00b07  lcall 0x7d6, 0x23be
  00b0c  lcall 0x7d6, 0x2d79
  00b11  mov bx, dx
  00b13  lcall 0x7d6, 0x23be
  00b18  lcall 0x7d6, 0x2d79
L0B1D:
  00b1d  mov di, 0x112a
  00b20  mov si, 0xf1a
  00b23  lcall 0x7d6, 0x19ce
  00b28  mov bx, 0
  00b2b  jne 0xb2e
  00b2d  dec bx
L0B2E:
  00b2e  mov di, 0x1040
  00b31  mov si, 0xf2a
  00b34  lcall 0x7d6, 0x19ce
  00b39  mov dx, 0
  00b3c  jne 0xb3f
  00b3e  dec dx
L0B3F:
  00b3f  and dx, bx
  00b41  and dx, dx
  00b43  jne 0xb48
  00b45  jmp 0xb8e
L0B48:
  00b48  mov bx, 9
  00b4b  lcall 0x7d6, 0xffd
  00b50  mov bx, 0xe
  00b53  lcall 0x7d6, 0x1017
  00b58  lcall 0x7d6, 0x3021
  00b5d  mov dx, bx
  00b5f  mov bx, 8
  00b62  mov cx, bx
  00b64  lcall 0x7d6, 0x23be
  00b69  lcall 0x7d6, 0x2d79
  00b6e  mov bx, 0xa
  00b71  lcall 0x7d6, 0xffd
  00b76  mov bx, dx
  00b78  lcall 0x7d6, 0x1017
  00b7d  lcall 0x7d6, 0x3021
  00b82  mov bx, cx
  00b84  lcall 0x7d6, 0x23be
  00b89  lcall 0x7d6, 0x2d79
L0B8E:
  00b8e  mov si, 0xf22
  00b91  lcall 0x7d6, 0x227f
  00b96  mov dx, bx
  00b98  mov si, 0xf1e
  00b9b  lcall 0x7d6, 0x227f
  00ba0  mov cx, 0x7fff
  00ba3  mov ax, bx
  00ba5  lcall 0x7d6, 0xb3b
  00baa  lcall 0x7d6, 0x2237
  00baf  mov di, 0xfae
  00bb2  lcall 0x7d6, 0x10a3
  00bb7  xchg bx, ax
  00bb8  lcall 0x7d6, 0xffd
  00bbd  mov bx, dx
  00bbf  lcall 0x7d6, 0xffd
  00bc4  xor bx, bx
  00bc6  lcall 0x7d6, 0x1017
  00bcb  lcall 0x7d6, 0x3021
  00bd0  mov bx, 5
  00bd3  lcall 0x7d6, 0x23be
  00bd8  lcall 0x7d6, 0x2d79
  00bdd  xor bx, bx
  00bdf  lcall 0x7d6, 0x13c9
  00be4  mov bx, 0x41c
  00be7  mov ds, word ptr [0x90]
  00beb  mov bl, byte ptr [bx]
  00bed  xor bh, bh
  00bef  push es
  00bf0  pop ds
  00bf1  xchg bx, ax
  00bf2  mov bx, 0x41a
  00bf5  mov ds, word ptr [0x90]
  00bf9  mov byte ptr [bx], al
  00bfb  push es
  00bfc  pop ds
L0BFD:
  00bfd  mov bx, 0x17
  00c00  lcall 0x7d6, 0xffd
  00c05  mov bx, 0x1a
  00c08  lcall 0x7d6, 0xffd
  00c0d  xor bx, bx
  00c0f  lcall 0x7d6, 0x1017
  00c14  lcall 0x7d6, 0x3021
  00c19  mov bx, 0x112e  ; '?'
  00c1c  lcall 0x7d6, 0x2d79
  00c21  mov bx, 0xf96
  00c24  lcall 0x7d6, 0x2d79
  00c29  mov bx, 0xf96
  00c2c  lcall 0x7d6, 0x2386
  00c31  cmp bx, 0xe
  00c34  jl 0xc39
  00c36  jmp 0xc56
L0C39:
  00c39  mov bx, 0x17
  00c3c  lcall 0x7d6, 0x820
  00c41  lcall 0x7d6, 0x3021
  00c46  mov bx, 0x1134  ; '_'
  00c49  lcall 0x7d6, 0x2d79
  00c4e  mov bx, 7
  00c51  lcall 0x7d6, 0x820
L0C56:
  00c56  mov bx, 0xf96
  00c59  mov dx, bx
  00c5b  lcall 0x7d6, 0x2386
  00c60  cmp bx, 0xe
  00c63  jl 0xc68
  00c65  jmp 0xc83
L0C68:
  00c68  lcall 0x7d6, 0x3021
  00c6d  mov bx, dx
  00c6f  lcall 0x7d6, 0x2386
  00c74  sub bx, 0xd
  00c77  neg bx
  00c79  lcall 0x7d6, 0x24b5
  00c7e  lcall 0x7d6, 0x2d79
L0C83:
  00c83  mov di, 0x1040
  00c86  mov si, 0xfb6
  00c89  lcall 0x7d6, 0x1772
  00c8e  mov di, si
  00c90  lcall 0x7d6, 0x10a3
  00c95  mov si, di
  00c97  mov di, 0x113a
  00c9a  lcall 0x7d6, 0x19ce
  00c9f  je 0xca4
  00ca1  jmp 0xcb1
L0CA4:
  00ca4  mov di, si
  00ca6  mov si, 0x113e
  00ca9  lcall 0x7d6, 0x10a6
  00cae  jmp 0x1cb8
L0CB1:
  00cb1  lcall 0x7d6, 0x23a1
  00cb6  mov dx, 0xfba
  00cb9  lcall 0x7d6, 0xf62
  00cbe  mov bx, 0x106a  ; ''
  00cc1  mov ax, 0xfba
  00cc4  lcall 0x7d6, 0xfd2
  00cc9  je 0xc83
  00ccb  mov si, 0xc32
  00cce  lcall 0x7d6, 0x26aa
  00cd3  jne 0xcd8
  00cd5  jmp 0xd2b
L0CD8:
  00cd8  mov di, 0x1142
  00cdb  mov si, 0xf1a
  00cde  lcall 0x7d6, 0x19ce
  00ce3  mov bx, 0
  00ce6  jne 0xce9
  00ce8  dec bx
L0CE9:
  00ce9  mov di, 0x1044
  00cec  mov si, 0xf22
  00cef  lcall 0x7d6, 0x19ce
  00cf4  mov dx, 0
  00cf7  jne 0xcfa
  00cf9  dec dx
L0CFA:
  00cfa  and dx, bx
  00cfc  and dx, dx
  00cfe  jne 0xd03
  00d00  jmp 0xd2b
L0D03:
  00d03  mov di, 0x1146
  00d06  mov si, 0xf1e
  00d09  lcall 0x7d6, 0x19ce
  00d0e  mov bx, 0
  00d11  jne 0xd14
  00d13  dec bx
L0D14:
  00d14  mov di, 0x114a
  00d17  lcall 0x7d6, 0x19ce
  00d1c  mov dx, 0
  00d1f  jne 0xd22
  00d21  dec dx
L0D22:
  00d22  or dx, bx
  00d24  and dx, dx
  00d26  je 0xd2b
  00d28  jmp 0x568a
L0D2B:
  00d2b  mov si, 0xc32
  00d2e  lcall 0x7d6, 0x26aa
  00d33  jne 0xd38
  00d35  jmp 0xd8b
L0D38:
  00d38  mov di, 0x114e
  00d3b  mov si, 0xf1a
  00d3e  lcall 0x7d6, 0x19ce
  00d43  mov bx, 0
  00d46  jne 0xd49
  00d48  dec bx
L0D49:
  00d49  mov di, 0x1074
  00d4c  mov si, 0xf22
  00d4f  lcall 0x7d6, 0x19ce
  00d54  mov dx, 0
  00d57  jne 0xd5a
  00d59  dec dx
L0D5A:
  00d5a  and dx, bx
  00d5c  and dx, dx
  00d5e  jne 0xd63
  00d60  jmp 0xd8b
L0D63:
  00d63  mov di, 0x1066
  00d66  mov si, 0xf1e
  00d69  lcall 0x7d6, 0x19ce
  00d6e  mov bx, 0
  00d71  jne 0xd74
  00d73  dec bx
L0D74:
  00d74  mov di, 0x1050
  00d77  lcall 0x7d6, 0x19ce
  00d7c  mov dx, 0
  00d7f  jne 0xd82
  00d81  dec dx
L0D82:
  00d82  or dx, bx
  00d84  and dx, dx
  00d86  je 0xd8b
  00d88  jmp 0x57df
L0D8B:
  00d8b  mov bx, 0xfba
  00d8e  lcall 0x7d6, 0x2386
  00d93  cmp bx, 2
  00d96  jge 0xd9b
  00d98  jmp 0xef1
L0D9B:
  00d9b  mov bx, 0xfba
  00d9e  mov dx, 1
  00da1  mov cx, bx
  00da3  lcall 0x7d6, 0x2478  ; 'You pour the'
  00da8  mov dx, cx
  00daa  lcall 0x7d6, 0xf62
  00daf  mov bx, 0x1152  ; 'G'
  00db2  mov ax, 0xfba
  00db5  lcall 0x7d6, 0xfd2
  00dba  je 0xdbf
  00dbc  jmp 0xdd5
L0DBF:
  00dbf  mov di, 0xfbe
  00dc2  mov si, 0x1062
  00dc5  lcall 0x7d6, 0x10a6
  00dca  mov di, 0xfc2
  00dcd  lcall 0x7d6, 0x10a6
  00dd2  jmp 0x103e
L0DD5:
  00dd5  mov bx, 0x1158  ; 'H'
  00dd8  mov ax, 0xfba
  00ddb  lcall 0x7d6, 0xfd2
  00de0  je 0xde5
  00de2  jmp 0xdfe
L0DE5:
  00de5  mov di, 0xfbe
  00de8  mov si, 0x1062
  00deb  lcall 0x7d6, 0x10a6
  00df0  mov di, 0xfc2
  00df3  mov si, 0x115e
  00df6  lcall 0x7d6, 0x10a6
  00dfb  jmp 0x103e
L0DFE:
  00dfe  mov bx, 0x1162  ; 'I'
  00e01  mov ax, 0xfba
  00e04  lcall 0x7d6, 0xfd2
  00e09  je 0xe0e
  00e0b  jmp 0xe27
L0E0E:
  00e0e  mov di, 0xfbe
  00e11  mov si, 0x1062
  00e14  lcall 0x7d6, 0x10a6
  00e19  mov di, 0xfc2
  00e1c  mov si, 0x1040
  00e1f  lcall 0x7d6, 0x10a6
  00e24  jmp 0x103e
L0E27:
  00e27  mov bx, 0x1168  ; 'K'
  00e2a  mov ax, 0xfba
  00e2d  lcall 0x7d6, 0xfd2
  00e32  je 0xe37
  00e34  jmp 0xe50
L0E37:
  00e37  mov di, 0xfbe
  00e3a  mov si, 0x1088
  00e3d  lcall 0x7d6, 0x10a6
  00e42  mov di, 0xfc2
  00e45  mov si, 0x1062
  00e48  lcall 0x7d6, 0x10a6
  00e4d  jmp 0x103e
L0E50:
  00e50  mov bx, 0x116e  ; 'M'
  00e53  mov ax, 0xfba
  00e56  lcall 0x7d6, 0xfd2
  00e5b  je 0xe60
  00e5d  jmp 0xe79
L0E60:
  00e60  mov di, 0xfbe
  00e63  mov si, 0x115e
  00e66  lcall 0x7d6, 0x10a6
  00e6b  mov di, 0xfc2
  00e6e  mov si, 0x1040
  00e71  lcall 0x7d6, 0x10a6
  00e76  jmp 0x103e
L0E79:
  00e79  mov bx, 0x1174  ; 'O'
  00e7c  mov ax, 0xfba
  00e7f  lcall 0x7d6, 0xfd2
  00e84  je 0xe89
  00e86  jmp 0xea2
L0E89:
  00e89  mov di, 0xfbe
  00e8c  mov si, 0x1040
  00e8f  lcall 0x7d6, 0x10a6
  00e94  mov di, 0xfc2
  00e97  mov si, 0x1062
  00e9a  lcall 0x7d6, 0x10a6
  00e9f  jmp 0x103e
L0EA2:
  00ea2  mov bx, 0x117a  ; 'P'
  00ea5  mov ax, 0xfba
  00ea8  lcall 0x7d6, 0xfd2
  00ead  je 0xeb2
  00eaf  jmp 0xecb
L0EB2:
  00eb2  mov di, 0xfbe
  00eb5  mov si, 0x1040
  00eb8  lcall 0x7d6, 0x10a6
  00ebd  mov di, 0xfc2
  00ec0  mov si, 0x1088
  00ec3  lcall 0x7d6, 0x10a6
  00ec8  jmp 0x103e
L0ECB:
  00ecb  mov bx, 0x1180  ; 'Q'
  00ece  mov ax, 0xfba
  00ed1  lcall 0x7d6, 0xfd2
  00ed6  je 0xedb
  00ed8  jmp 0xef1
L0EDB:
  00edb  mov di, 0xfbe
  00ede  mov si, 0x1040
  00ee1  lcall 0x7d6, 0x10a6
  00ee6  mov di, 0xfc2
  00ee9  lcall 0x7d6, 0x10a6
  00eee  jmp 0x103e
L0EF1:
  00ef1  mov bx, 0xd
  00ef4  lcall 0x7d6, 0x23be
  00ef9  xchg bx, ax
  00efa  mov bx, 0xfba
  00efd  lcall 0x7d6, 0xfd2
  00f02  je 0xf07
  00f04  jmp 0xf2c
L0F07:
  00f07  mov bx, 0x17
  00f0a  lcall 0x7d6, 0xffd
  00f0f  mov bx, 0x1a
  00f12  lcall 0x7d6, 0x1017
  00f17  lcall 0x7d6, 0x3021
  00f1c  mov bx, 0xf
  00f1f  lcall 0x7d6, 0x24b5
  00f24  lcall 0x7d6, 0x2d79
  00f29  jmp 0x142d
L0F2C:
  00f2c  mov bx, 8
  00f2f  lcall 0x7d6, 0x23be
  00f34  xchg bx, ax
  00f35  mov bx, 0xfba
  00f38  lcall 0x7d6, 0xfd2
  00f3d  mov dx, 0
  00f40  jne 0xf43
  00f42  dec dx
L0F43:
  00f43  mov bx, 0xf96
  00f46  mov cx, bx
  00f48  lcall 0x7d6, 0x2386
  00f4d  or bx, bx
  00f4f  mov ax, 0
  00f52  jle 0xf55
  00f54  dec ax
L0F55:
  00f55  and ax, dx
  00f57  and ax, ax
  00f59  jne 0xf5e
  00f5b  jmp 0xf7a
L0F5E:
  00f5e  mov bx, cx
  00f60  lcall 0x7d6, 0x2386
  00f65  dec bx
  00f66  mov ax, bx
  00f68  mov bx, cx
  00f6a  xchg dx, ax
  00f6b  lcall 0x7d6, 0x246f
  00f70  mov dx, cx
  00f72  lcall 0x7d6, 0xf62
  00f77  jmp 0xbfd
L0F7A:
  00f7a  mov bx, 0xf96
  00f7d  lcall 0x7d6, 0x2386
  00f82  cmp bx, 0xe
  00f85  je 0xf8a
  00f87  jmp 0xf98
L0F8A:
  00f8a  mov bx, 0x96
  00f8d  mov dx, 0x1040
  00f90  lcall 0x7d6, 0x635
  00f95  jmp 0xbfd
L0F98:
  00f98  mov bx, 0x10a4  ; ' '
  00f9b  mov ax, 0xfba
  00f9e  lcall 0x7d6, 0xfd2
  00fa3  jne 0xfa8
  00fa5  jmp 0x102a
L0FA8:
  00fa8  mov bx, 0xfba
  00fab  lcall 0x7d6, 0x238d
  00fb0  lcall 0x7d6, 0x2237
  00fb5  mov di, 0xfc6
  00fb8  lcall 0x7d6, 0x10a3
  00fbd  mov di, 0x1186
  00fc0  mov si, 0xfc6
  00fc3  lcall 0x7d6, 0x19ce
  00fc8  mov bx, 0
  00fcb  jbe 0xfce
  00fcd  dec bx
L0FCE:
  00fce  mov di, 0x118a
  00fd1  lcall 0x7d6, 0x19ce
  00fd6  mov dx, 0
  00fd9  jae 0xfdc
  00fdb  dec dx
L0FDC:
  00fdc  and dx, bx
  00fde  and dx, dx
  00fe0  jne 0xfe5
  00fe2  jmp 0x1002
L0FE5:
  00fe5  mov di, 0x118e
  00fe8  lcall 0x7d6, 0x1772
  00fed  lcall 0x7d6, 0x22ca
  00ff2  lcall 0x7d6, 0x23be
  00ff7  mov dx, 0xfba
  00ffa  lcall 0x7d6, 0xf62
  00fff  jmp 0xfa8
L1002:
  01002  mov di, 0x1192
  01005  mov si, 0xfc6
  01008  lcall 0x7d6, 0x19ce
  0100d  mov bx, 0
  01010  jae 0x1013
  01012  dec bx
L1013:
  01013  mov di, 0x1196
  01016  lcall 0x7d6, 0x19ce
  0101b  mov dx, 0
  0101e  jbe 0x1021
  01020  dec dx
L1021:
  01021  or dx, bx
  01023  and dx, dx
  01025  je 0x102a
  01027  jmp 0xbfd
L102A:
  0102a  mov bx, 0xfba
  0102d  mov ax, 0xf96
  01030  lcall 0x7d6, 0xf98
  01035  xchg dx, ax
  01036  lcall 0x7d6, 0xf62
  0103b  jmp 0xbfd
L103E:
  0103e  mov di, 0xfbe
  01041  mov si, 0xf1e
  01044  lcall 0x7d6, 0x1772
  01049  mov di, 0xfca
  0104c  lcall 0x7d6, 0x10a3
  01051  mov di, 0xfc2
  01054  mov si, 0xf22
  01057  lcall 0x7d6, 0x1772
  0105c  mov di, 0xfce
  0105f  lcall 0x7d6, 0x10a3
  01064  mov si, 0xfce
  01067  lcall 0x7d6, 0x227f
  0106c  mov dx, bx
  0106e  mov si, 0xfca
  01071  lcall 0x7d6, 0x227f
  01076  mov cx, 0x7fff
  01079  lcall 0x7d6, 0xb3b
  0107e  lcall 0x7d6, 0x2237
  01083  mov di, 0xfd2
  01086  lcall 0x7d6, 0x10a3
  0108b  mov di, 0x1040
  0108e  mov si, 0xfca
  01091  lcall 0x7d6, 0x19ce
  01096  jb 0x109b
  01098  jmp 0x10b4
L109B:
  0109b  mov bx, 0x119a  ; 'N'
  0109e  mov dx, 0xf9a
  010a1  lcall 0x7d6, 0xf62
  010a6  mov di, 0xf1e
  010a9  mov si, 0x1074
  010ac  lcall 0x7d6, 0x10a6
  010b1  jmp 0x123c
L10B4:
  010b4  mov di, 0x1074
  010b7  mov si, 0xfca
  010ba  lcall 0x7d6, 0x19ce
  010bf  ja 0x10c4
  010c1  jmp 0x10dd
L10C4:
  010c4  mov bx, 0x11a0  ; 'S'
  010c7  mov dx, 0xf9a
  010ca  lcall 0x7d6, 0xf62
  010cf  mov di, 0xf1e
  010d2  mov si, 0x1040
  010d5  lcall 0x7d6, 0x10a6
  010da  jmp 0x123c
L10DD:
  010dd  mov di, 0x1040
  010e0  mov si, 0xfce
  010e3  lcall 0x7d6, 0x19ce
  010e8  jb 0x10ed
  010ea  jmp 0x1106  ; 'Sorcerers room!'
L10ED:
  010ed  mov bx, 0x11a6  ; 'W'
  010f0  mov dx, 0xf9a
  010f3  lcall 0x7d6, 0xf62
  010f8  mov di, 0xf22
  010fb  mov si, 0x107e
  010fe  lcall 0x7d6, 0x10a6
  01103  jmp 0x123c
L1106:
  01106  mov di, 0x107e
  01109  mov si, 0xfce
  0110c  lcall 0x7d6, 0x19ce
  01111  ja 0x1116
  01113  jmp 0x112f
L1116:
  01116  mov bx, 0x11ac  ; 'E'
  01119  mov dx, 0xf9a
  0111c  lcall 0x7d6, 0xf62
  01121  mov di, 0xf22
  01124  mov si, 0x1040
  01127  lcall 0x7d6, 0x10a6
  0112c  jmp 0x123c
L112F:
  0112f  mov si, 0xfd2
  01132  lcall 0x7d6, 0x227f
  01137  lcall 0x7d6, 0x23be
  0113c  xchg bx, ax
  0113d  mov bx, 0x11b2  ; 'U'
  01140  lcall 0x7d6, 0xfd2
  01145  je 0x114a
  01147  jmp 0x1155
L114A:
  0114a  mov dx, 0xf9a
  0114d  lcall 0x7d6, 0xf62
  01152  jmp 0x123c
L1155:
  01155  mov si, 0xfd2
  01158  lcall 0x7d6, 0x227f
  0115d  lcall 0x7d6, 0x23be
  01162  xchg bx, ax
  01163  mov bx, 0x11b8  ; 'D'
  01166  lcall 0x7d6, 0xfd2
  0116b  je 0x1170
  0116d  jmp 0x117b
L1170:
  01170  mov dx, 0xf9a
  01173  lcall 0x7d6, 0xf62
  01178  jmp 0x123c
L117B:
  0117b  mov di, 0x10ca
  0117e  mov si, 0xfd2
  01181  lcall 0x7d6, 0x19ce
  01186  jne 0x118b
  01188  jmp 0x1199
L118B:
  0118b  mov bx, 0x32
  0118e  mov dx, 0x11be
  01191  lcall 0x7d6, 0x635
  01196  jmp 0x1911
L1199:
  01199  mov si, 0xf1e
  0119c  lcall 0x7d6, 0x227f
  011a1  lcall 0x7d6, 0xffd
  011a6  mov si, 0xf22
  011a9  lcall 0x7d6, 0x227f
  011ae  lcall 0x7d6, 0x1017
  011b3  lcall 0x7d6, 0x3021
  011b8  mov si, 0xfae
  011bb  mov dx, si
  011bd  lcall 0x7d6, 0x227f
  011c2  lcall 0x7d6, 0x23be
  011c7  lcall 0x7d6, 0x2d79
  011cc  mov si, 0xfce
  011cf  lcall 0x7d6, 0x227f
  011d4  mov cx, bx
  011d6  mov si, 0xfca
  011d9  lcall 0x7d6, 0x227f
  011de  mov ax, dx
  011e0  mov dx, cx
  011e2  mov cx, 0x7fff
  011e5  lcall 0x7d6, 0xb3b
  011ea  lcall 0x7d6, 0x2237
  011ef  xchg di, ax
  011f0  lcall 0x7d6, 0x10a3
  011f5  mov di, 0xf1e
  011f8  mov si, 0xfca
  011fb  lcall 0x7d6, 0x10a6
  01200  mov bx, di
  01202  mov di, 0xf22
  01205  mov si, 0xfce
  01208  lcall 0x7d6, 0x10a6
  0120d  mov dx, bx
  0120f  mov si, dx
  01211  lcall 0x7d6, 0x227f
  01216  lcall 0x7d6, 0xffd
  0121b  mov si, di
  0121d  lcall 0x7d6, 0x227f
  01222  lcall 0x7d6, 0x1017
  01227  lcall 0x7d6, 0x3021
  0122c  mov bx, 5
  0122f  lcall 0x7d6, 0x23be
  01234  lcall 0x7d6, 0x2d79
  01239  jmp 0xbfd
L123C:
  0123c  mov si, 0xf8a
  0123f  lcall 0x7d6, 0x227f
  01244  xchg bx, ax
  01245  mov bx, 0x54
  01248  imul bx
  0124a  add ax, 0x8c2
  0124d  xchg bx, ax
  0124e  mov dx, 0xf9a
  01251  lcall 0x7d6, 0x245e
  01256  lcall 0x7d6, 0x2237
  0125b  mov di, 0xfd2
  0125e  lcall 0x7d6, 0x10a3
  01263  mov bx, 0x106a  ; ''
  01266  mov dx, 0xfd6
  01269  lcall 0x7d6, 0xf62
L126E:
  0126e  mov di, 0x1040
  01271  mov si, 0xfd2
  01274  lcall 0x7d6, 0x1772
  01279  mov di, si
  0127b  lcall 0x7d6, 0x10a3
  01280  mov si, 0xf8a
  01283  lcall 0x7d6, 0x227f
  01288  xchg bx, ax
  01289  mov bx, 0x54
  0128c  imul bx
  0128e  add ax, 0x8c2
  01291  xchg bx, ax
  01292  lcall 0x7d6, 0x2386
  01297  lcall 0x7d6, 0x2237
  0129c  lcall 0x7d6, 0x19c3
  012a1  jae 0x12a6
  012a3  jmp 0x1325
L12A6:
  012a6  mov si, 0xfd2
  012a9  lcall 0x7d6, 0x227f
  012ae  mov dx, bx
  012b0  mov si, 0xf8a
  012b3  lcall 0x7d6, 0x227f
  012b8  xchg bx, ax
  012b9  mov bx, dx
  012bb  mov dx, 0x54
  012be  imul dx
  012c0  add ax, 0x8c2
  012c3  xchg bx, ax
  012c4  xchg dx, ax
  012c5  mov cx, 1
  012c8  lcall 0x7d6, 0x2486
  012cd  lcall 0x7d6, 0x238d
  012d2  lcall 0x7d6, 0x2237
  012d7  mov di, 0xfc6
  012da  lcall 0x7d6, 0x10a3
  012df  mov di, 0x10ae
  012e2  mov si, 0xfc6
  012e5  lcall 0x7d6, 0x19ce
  012ea  mov bx, 0
  012ed  jbe 0x12f0
  012ef  dec bx
L12F0:
  012f0  mov di, 0x11c2
  012f3  lcall 0x7d6, 0x19ce
  012f8  mov dx, 0
  012fb  jae 0x12fe
  012fd  dec dx
L12FE:
  012fe  or dx, bx
  01300  and dx, dx
  01302  je 0x1307
  01304  jmp 0x1325
L1307:
  01307  mov si, 0xfc6
  0130a  lcall 0x7d6, 0x227f
  0130f  lcall 0x7d6, 0x23be
  01314  mov ax, 0xfd6
  01317  lcall 0x7d6, 0xf98
  0131c  xchg dx, ax
  0131d  lcall 0x7d6, 0xf62
  01322  jmp 0x126e
L1325:
  01325  mov bx, 0xfd6
  01328  lcall 0x7d6, 0x1a00
  0132d  mov di, 0x11c6
  01330  lcall 0x7d6, 0x19aa
  01335  mov dx, 0
  01338  jne 0x133b
  0133a  dec dx
L133B:
  0133b  lcall 0x7d6, 0x1a00
  01340  mov di, 0x11ce
  01343  lcall 0x7d6, 0x19aa
  01348  mov bx, 0
  0134b  jne 0x134e
  0134d  dec bx
L134E:
  0134e  or bx, dx
  01350  and bx, bx
  01352  jne 0x1357
  01354  jmp 0x13b1
L1357:
  01357  mov si, 0xc2a
  0135a  lcall 0x7d6, 0x26aa
  0135f  jne 0x1364
  01361  jmp 0x13b1
L1364:
  01364  mov di, 0xfb2
  01367  mov si, 0x11d6
  0136a  lcall 0x7d6, 0x10a6
  0136f  mov bx, 0x11da  ; "It's too dark"
  01372  mov dx, 0xed2
  01375  lcall 0x7d6, 0xf62
  0137a  mov bx, 0x11ec  ; 'to go that way!'
  0137d  mov dx, 0xed6
  01380  lcall 0x7d6, 0xf62
  01385  mov bx, 0x64
  01388  mov dx, 0x1040
  0138b  lcall 0x7d6, 0x635
  01390  mov di, 0x1200
  01393  mov si, 0xf1a
  01396  lcall 0x7d6, 0x19ce
  0139b  je 0x13a0  ; 'KILL'
  0139d  jmp 0x13ae
L13A0:
  013a0  mov di, 0xf1e
  013a3  mov si, 0x1074
  013a6  lcall 0x7d6, 0x10a6
  013ab  jmp 0x1bd7
L13AE:
  013ae  jmp 0x1bd7
L13B1:
  013b1  mov di, 0xfa2
  013b4  mov si, 0xf1a
  013b7  lcall 0x7d6, 0x10a6
  013bc  mov bx, 0xfd6
  013bf  lcall 0x7d6, 0x1a00
  013c4  lcall 0x7d6, 0x2259
  013c9  mov di, si
  013cb  lcall 0x7d6, 0x10a3
  013d0  mov si, di
  013d2  lcall 0x7d6, 0x26aa
  013d7  jne 0x13dc
  013d9  jmp 0x653f
L13DC:
  013dc  mov di, 0xf86
  013df  mov si, 0xf1a
  013e2  lcall 0x7d6, 0x19ce
  013e7  mov bx, 0
  013ea  jae 0x13ed
  013ec  dec bx
L13ED:
  013ed  mov dx, si
  013ef  mov si, di
  013f1  mov di, 0x1066
  013f4  lcall 0x7d6, 0x1772
  013f9  mov di, dx
  013fb  lcall 0x7d6, 0x19c3
  01400  mov cx, 0
  01403  jae 0x1406
  01405  dec cx
L1406:
  01406  or cx, bx
  01408  and cx, cx
  0140a  je 0x140f
  0140c  jmp 0x23e
L140F:
  0140f  mov di, 0xf86
  01412  mov si, 0xf1a
  01415  lcall 0x7d6, 0x175d
  0141a  mov di, 0x1040
  0141d  lcall 0x7d6, 0x1767
  01422  mov di, 0xf8a
  01425  lcall 0x7d6, 0x10a3
  0142a  jmp 0x469
L142D:
  0142d  mov bx, 0xf96
  01430  mov dx, bx
  01432  lcall 0x7d6, 0x2386
  01437  cmp bx, 2
  0143a  jg 0x143f
  0143c  jmp 0x1457
L143F:
  0143f  mov bx, dx
  01441  mov dx, 3
  01444  lcall 0x7d6, 0x246f
  01449  xchg bx, ax
  0144a  mov bx, 0x1204  ; 'INV'
  0144d  lcall 0x7d6, 0xfd2
  01452  jne 0x1457
  01454  jmp 0x43e5
L1457:
  01457  mov bx, 0x120c  ; 'QUIT'
  0145a  mov ax, 0xf96
  0145d  lcall 0x7d6, 0xfd2
  01462  je 0x1467
  01464  jmp 0x14a2
L1467:
  01467  lcall 0x7d6, 0x789
  0146c  mov bx, 2
  0146f  lcall 0x7d6, 0xffd
  01474  mov bx, 9
  01477  lcall 0x7d6, 0x1017
  0147c  lcall 0x7d6, 0x3021
  01481  mov bx, 0x1214  ; "You've ended the game!"
  01484  lcall 0x7d6, 0x2d8d
  01489  mov di, 0xfda
  0148c  mov si, 0x1088
  0148f  lcall 0x7d6, 0x10a6
  01494  mov bx, 0x106a  ; ''
  01497  mov dx, 0xfd6
  0149a  lcall 0x7d6, 0xf62
  0149f  jmp 0x6577
L14A2:
  014a2  mov bx, 0x20
  014a5  lcall 0x7d6, 0x23be
  014aa  mov dx, bx
  014ac  mov bx, 0xf96
  014af  lcall 0x7d6, 0x245e
  014b4  lcall 0x7d6, 0x2237
  014b9  mov di, 0xfb2
  014bc  lcall 0x7d6, 0x10a3
  014c1  mov di, 0x11d6
  014c4  mov si, 0xfb2
  014c7  lcall 0x7d6, 0x19ce
  014cc  mov bx, 0
  014cf  jae 0x14d2
  014d1  dec bx
L14D2:
  014d2  mov dx, bx
  014d4  mov bx, 0xf96
  014d7  mov cx, bx
  014d9  lcall 0x7d6, 0x2386
  014de  lcall 0x7d6, 0x2237
  014e3  mov di, si
  014e5  lcall 0x7d6, 0x19c3
  014ea  mov bx, 0
  014ed  ja 0x14f0
  014ef  dec bx
L14F0:
  014f0  or bx, dx
  014f2  and bx, bx
  014f4  jne 0x14f9
  014f6  jmp 0x1506
L14F9:
  014f9  mov dx, cx
  014fb  mov bx, 0x106a  ; ''
  014fe  lcall 0x7d6, 0xf62
  01503  jmp 0x18a5
L1506:
  01506  mov di, 0x1062
  01509  mov si, 0xfb2
  0150c  lcall 0x7d6, 0x1772
  01511  mov dx, si
  01513  lcall 0x7d6, 0x22ca
  01518  mov cx, dx
  0151a  mov dx, bx
  0151c  mov bx, 0xf96
  0151f  mov ax, bx
  01521  lcall 0x7d6, 0x246f
  01526  mov dx, 0xfde
  01529  lcall 0x7d6, 0xf62
  0152e  xchg bx, ax
  0152f  mov dx, bx
  01531  lcall 0x7d6, 0x2386
  01536  lcall 0x7d6, 0x2237
  0153b  mov di, cx
  0153d  lcall 0x7d6, 0x1752
  01542  lcall 0x7d6, 0x22ca
  01547  xchg bx, dx
  01549  mov cx, bx
  0154b  lcall 0x7d6, 0x2478  ; 'You pour the'
  01550  mov dx, 0xfe2
  01553  lcall 0x7d6, 0xf62
  01558  mov dx, cx
  0155a  mov bx, 0x106a  ; ''
  0155d  lcall 0x7d6, 0xf62
  01562  mov bx, 0x122e  ; 'LOOK'
  01565  mov ax, 0xfde
  01568  lcall 0x7d6, 0xfd2
  0156d  mov dx, 0
  01570  jne 0x1573
  01572  dec dx
L1573:
  01573  mov bx, 0x1236  ; 'SEARCH'
  01576  lcall 0x7d6, 0xfd2
  0157b  mov cx, 0
  0157e  jne 0x1581
  01580  dec cx
L1581:
  01581  or cx, dx
  01583  mov bx, 0x1240  ; 'EXAMINE'
  01586  lcall 0x7d6, 0xfd2
  0158b  mov dx, 0
  0158e  jne 0x1591
  01590  dec dx
L1591:
  01591  or dx, cx
  01593  and dx, dx
  01595  je 0x159a
  01597  jmp 0x22ea
L159A:
  0159a  mov bx, 0x124c  ; 'DROP'
  0159d  mov ax, 0xfde
  015a0  lcall 0x7d6, 0xfd2
  015a5  mov dx, 0
  015a8  jne 0x15ab
  015aa  dec dx
L15AB:
  015ab  mov bx, 0x1254  ; 'THROW'
  015ae  lcall 0x7d6, 0xfd2
  015b3  mov cx, 0
  015b6  jne 0x15b9
  015b8  dec cx
L15B9:
  015b9  or cx, dx
  015bb  and cx, cx
  015bd  je 0x15c2
  015bf  jmp 0x3670
L15C2:
  015c2  mov bx, 0x125e  ; 'FILL'
  015c5  mov ax, 0xfde
  015c8  lcall 0x7d6, 0xfd2
  015cd  mov dx, 0
  015d0  jne 0x15d3
  015d2  dec dx
L15D3:
  015d3  mov bx, 0x1266  ; 'FLASK'
  015d6  mov cx, ax
  015d8  mov ax, 0xfe2
  015db  lcall 0x7d6, 0xfd2
  015e0  mov word ptr [bp - 2], dx
  015e3  mov dx, 0
  015e6  jne 0x15e9
  015e8  dec dx
L15E9:
  015e9  and dx, word ptr [bp - 2]
  015ec  and dx, dx
  015ee  jne 0x15f3
  015f0  jmp 0x1624  ; 'STAIRCASE'
L15F3:
  015f3  mov dx, cx
  015f5  mov bx, 0x1270  ; 'GET'
  015f8  lcall 0x7d6, 0xf62
  015fd  mov di, 0x1126
  01600  mov si, 0xf1a
  01603  lcall 0x7d6, 0x19ce
  01608  je 0x160d
  0160a  jmp 0x1619
L160D:
  0160d  xchg dx, ax
  0160e  mov bx, 0x1278  ; 'WINE'
  01611  lcall 0x7d6, 0xf62
  01616  jmp 0x1624  ; 'STAIRCASE'
L1619:
  01619  mov bx, 0x1280  ; 'WATER'
  0161c  mov dx, 0xfe2
  0161f  lcall 0x7d6, 0xf62
L1624:
  01624  mov bx, 0x1270  ; 'GET'
  01627  mov ax, 0xfde
  0162a  lcall 0x7d6, 0xfd2
  0162f  mov dx, 0
  01632  jne 0x1635
  01634  dec dx
L1635:
  01635  mov bx, 0x128a  ; 'TAKE'
  01638  lcall 0x7d6, 0xfd2
  0163d  mov cx, 0
  01640  jne 0x1643
  01642  dec cx
L1643:
  01643  or cx, dx
  01645  and cx, cx
  01647  je 0x164c
  01649  jmp 0x38d5
L164C:
  0164c  mov bx, 0x1292  ; 'WEAR'
  0164f  mov ax, 0xfde
  01652  lcall 0x7d6, 0xfd2
  01657  jne 0x165c
  01659  jmp 0x44ec
L165C:
  0165c  mov bx, 0x129a  ; 'PLAY'
  0165f  mov ax, 0xfde
  01662  lcall 0x7d6, 0xfd2
  01667  jne 0x166c
  01669  jmp 0x46ea
L166C:
  0166c  mov bx, 0x12a2  ; 'WAVE'
  0166f  mov ax, 0xfde
  01672  lcall 0x7d6, 0xfd2
  01677  jne 0x167c
  01679  jmp 0x48f6
L167C:
  0167c  mov bx, 0x12aa  ; 'RUB'
  0167f  mov ax, 0xfde
  01682  lcall 0x7d6, 0xfd2
  01687  mov dx, 0
  0168a  jne 0x168d
  0168c  dec dx
L168D:
  0168d  mov bx, 0x12b2  ; 'CLEAN'
  01690  lcall 0x7d6, 0xfd2
  01695  mov cx, 0
  01698  jne 0x169b
  0169a  dec cx
L169B:
  0169b  or cx, dx
  0169d  and cx, cx
  0169f  je 0x16a4  ; 'looks Mean!'
  016a1  jmp 0x4d53
L16A4:
  016a4  mov bx, 0x12bc  ; 'SAY'
  016a7  mov ax, 0xfde
  016aa  lcall 0x7d6, 0xfd2
  016af  jne 0x16b4  ; 'looks Dead!'
  016b1  jmp 0x4eb5
L16B4:
  016b4  mov bx, 0x12c4  ; 'OPEN'
  016b7  mov ax, 0xfde
  016ba  lcall 0x7d6, 0xfd2
  016bf  je 0x16c4  ; ' The '
  016c1  jmp 0x16cd
L16C4:
  016c4  xchg dx, ax
  016c5  mov bx, 0x12cc  ; 'UNLOCK'
  016c8  lcall 0x7d6, 0xf62
L16CD:
  016cd  mov bx, 0x12d6  ; 'CLOSE'
  016d0  mov ax, 0xfde
  016d3  lcall 0x7d6, 0xfd2
  016d8  je 0x16dd
  016da  jmp 0x16e6
L16DD:
  016dd  xchg dx, ax
  016de  mov bx, 0x12e0  ; 'LOCK'
  016e1  lcall 0x7d6, 0xf62
L16E6:
  016e6  mov bx, 0x12e0  ; 'LOCK'
  016e9  mov ax, 0xfde
  016ec  lcall 0x7d6, 0xfd2
  016f1  mov dx, 0
  016f4  jne 0x16f7
  016f6  dec dx
L16F7:
  016f7  mov bx, 0x12cc  ; 'UNLOCK'
  016fa  lcall 0x7d6, 0xfd2
  016ff  mov cx, 0
  01702  jne 0x1705
  01704  dec cx
L1705:
  01705  or cx, dx
  01707  mov bx, 0x12c4  ; 'OPEN'
  0170a  lcall 0x7d6, 0xfd2
  0170f  mov dx, 0
  01712  jne 0x1715
  01714  dec dx
L1715:
  01715  or dx, cx
  01717  mov bx, 0x12d6  ; 'CLOSE'
  0171a  lcall 0x7d6, 0xfd2
  0171f  mov cx, 0
  01722  jne 0x1725
  01724  dec cx
L1725:
  01725  or cx, dx
  01727  and cx, cx
  01729  je 0x172e
  0172b  jmp 0x4fe1
L172E:
  0172e  mov bx, 0x12e8  ; 'DRINK'
  01731  mov ax, 0xfde
  01734  lcall 0x7d6, 0xfd2
  01739  jne 0x173e
  0173b  jmp 0x58f2
L173E:
  0173e  mov bx, 0x12f2  ; 'EAT'
  01741  mov ax, 0xfde
  01744  lcall 0x7d6, 0xfd2
  01749  je 0x174e
  0174b  jmp 0x1772
L174E:
  0174e  mov di, 0xfb2
  01751  mov si, 0x11d6
  01754  lcall 0x7d6, 0x10a6
  01759  mov bx, 0x12fa  ; " I'm not"
  0175c  mov dx, 0xed2
  0175f  lcall 0x7d6, 0xf62
  01764  mov bx, 0x1306  ; ' hungry!'
  01767  mov dx, 0xed6
  0176a  lcall 0x7d6, 0xf62
  0176f  jmp 0x1bd7
L1772:
  01772  mov bx, 0x1312  ; 'READ'
  01775  mov ax, 0xfde
  01778  lcall 0x7d6, 0xfd2
  0177d  jne 0x1782
  0177f  jmp 0x5509
L1782:
  01782  mov bx, 0x131a  ; 'JUMP'
  01785  mov ax, 0xfde
  01788  lcall 0x7d6, 0xfd2
  0178d  mov dx, 0
  01790  jne 0x1793
  01792  dec dx
L1793:
  01793  mov bx, 0x1322  ; 'LEEP'
  01796  lcall 0x7d6, 0xfd2
  0179b  mov cx, 0
  0179e  jne 0x17a1
  017a0  dec cx
L17A1:
  017a1  or cx, dx
  017a3  and cx, cx
  017a5  je 0x17aa
  017a7  jmp 0x55e4
L17AA:
  017aa  mov bx, 0x132a  ; 'POUR'
  017ad  mov ax, 0xfde
  017b0  lcall 0x7d6, 0xfd2
  017b5  jne 0x17ba
  017b7  jmp 0x5a04
L17BA:
  017ba  mov bx, 0x1332  ; 'CLIMB'
  017bd  mov ax, 0xfde
  017c0  lcall 0x7d6, 0xfd2
  017c5  je 0x17ca
  017c7  jmp 0x17ee
L17CA:
  017ca  mov di, 0xfb2
  017cd  mov si, 0x11d6
  017d0  lcall 0x7d6, 0x10a6
  017d5  mov bx, 0x133c  ; "I don't need"
  017d8  mov dx, 0xed2
  017db  lcall 0x7d6, 0xf62
  017e0  mov bx, 0x134c  ; 'to climb.'
  017e3  mov dx, 0xed6
  017e6  lcall 0x7d6, 0xf62
  017eb  jmp 0x1bd7
L17EE:
  017ee  mov di, 0x135a
  017f1  mov si, 0xf1a
  017f4  lcall 0x7d6, 0x19ce
  017f9  je 0x17fe
  017fb  jmp 0x1855
L17FE:
  017fe  mov bx, 0x135e  ; 'MIRROR'
  01801  mov ax, 0xfde
  01804  lcall 0x7d6, 0xfd2
  01809  mov dx, 0
  0180c  jne 0x180f
  0180e  dec dx
L180F:
  0180f  mov ax, 0xfe2
  01812  lcall 0x7d6, 0xfd2
  01817  mov cx, 0
  0181a  jne 0x181d
  0181c  dec cx
L181D:
  0181d  and cx, dx
  0181f  and cx, cx
  01821  jne 0x1826
  01823  jmp 0x1855
L1826:
  01826  mov di, 0xfb2
  01829  mov si, 0x10be
  0182c  lcall 0x7d6, 0x10a6
  01831  mov bx, 0x1368  ; ' The wicked'
  01834  mov dx, 0xed2
  01837  lcall 0x7d6, 0xf62
  0183c  mov bx, 0x1378  ; 'witch never'
  0183f  mov dx, 0xed6
  01842  lcall 0x7d6, 0xf62
  01847  mov bx, 0x1388  ; 'lived here!!'
  0184a  mov dx, 0xeda
  0184d  lcall 0x7d6, 0xf62
  01852  jmp 0x1bd7
L1855:
  01855  mov bx, 0x1398  ; 'PET'
  01858  mov ax, 0xfde
  0185b  lcall 0x7d6, 0xfd2
  01860  jne 0x1865
  01862  jmp 0x5af4
L1865:
  01865  mov bx, 0x13a0  ; 'KILL'
  01868  mov ax, 0xfde
  0186b  lcall 0x7d6, 0xfd2
  01870  jne 0x1875
  01872  jmp 0x5c28
L1875:
  01875  mov bx, 0x13a8  ; 'SHOW'
  01878  mov ax, 0xfde
  0187b  lcall 0x7d6, 0xfd2
  01880  jne 0x1885
  01882  jmp 0x5d46
L1885:
  01885  mov bx, 0x13b0  ; 'SAVE'
  01888  mov ax, 0xfde
  0188b  lcall 0x7d6, 0xfd2
  01890  jne 0x1895
  01892  jmp 0x601e
L1895:
  01895  mov bx, 0x13b8  ; 'LOAD'
  01898  mov ax, 0xfde
  0189b  lcall 0x7d6, 0xfd2
  018a0  jne 0x18a5
  018a2  jmp 0x61a0
L18A5:
  018a5  mov bx, 0x19
  018a8  lcall 0x7d6, 0xffd
  018ad  mov bx, 0x1a
  018b0  lcall 0x7d6, 0x1017
  018b5  lcall 0x7d6, 0x3021
  018ba  mov bx, 0x13c0  ; 'What???'
  018bd  lcall 0x7d6, 0x2d79
  018c2  lcall 0x7d6, 0x627
  018c7  mov si, 0x1040
  018ca  lcall 0x7d6, 0x10bd
  018cf  jmp 0x18dd
L18D2:
  018d2  mov di, 0x1040
  018d5  mov si, 0xf32
  018d8  lcall 0x7d6, 0x1772
L18DD:
  018dd  mov di, 0xf32
  018e0  lcall 0x7d6, 0x10a3
  018e5  mov si, di
  018e7  mov di, 0x13cc
  018ea  lcall 0x7d6, 0x19ce
  018ef  jbe 0x18d2
  018f1  mov bx, 0x19
  018f4  lcall 0x7d6, 0xffd
  018f9  mov bx, 0x1a
  018fc  lcall 0x7d6, 0x1017
  01901  lcall 0x7d6, 0x3021
  01906  mov bx, 0x13d0  ; '       '
  01909  lcall 0x7d6, 0x2d79
  0190e  jmp 0xbfd
L1911:
  01911  mov si, 0x1040
  01914  lcall 0x7d6, 0x10bd
  01919  jmp 0x1946
L191C:
  0191c  mov si, 0xf32
  0191f  lcall 0x7d6, 0x227f
  01924  mov si, bx
  01926  shl si, 1
  01928  shl si, 1
  0192a  add si, 0xe46
  0192e  mov di, 0xfd2
  01931  lcall 0x7d6, 0x19ce
  01936  jne 0x193b
  01938  jmp 0x1b42
L193B:
  0193b  mov di, 0x1040
  0193e  mov si, 0xf32
  01941  lcall 0x7d6, 0x1772
L1946:
  01946  mov di, 0xf32
  01949  lcall 0x7d6, 0x10a3
  0194e  mov si, di
  01950  mov di, 0x104c
  01953  lcall 0x7d6, 0x19ce
  01958  jbe 0x191c
  0195a  mov di, 0x13dc
  0195d  mov si, 0xfd2
  01960  lcall 0x7d6, 0x19ce
  01965  je 0x196a
  01967  jmp 0x1999
L196A:
  0196a  mov bx, 0x32
  0196d  mov dx, 0x13e0
  01970  lcall 0x7d6, 0x635
  01975  mov di, 0xfb2
  01978  mov si, 0x11d6
  0197b  lcall 0x7d6, 0x10a6
  01980  mov bx, 0x13e4  ; 'The Door is'
  01983  mov dx, 0xed2
  01986  lcall 0x7d6, 0xf62
  0198b  mov bx, 0x13f4  ; 'locked.'
  0198e  mov dx, 0xed6
  01991  lcall 0x7d6, 0xf62
  01996  jmp 0x1bd7
L1999:
  01999  mov di, 0x1400
  0199c  mov si, 0xfd2
  0199f  lcall 0x7d6, 0x19ce
  019a4  je 0x19a9
  019a6  jmp 0x19d8
L19A9:
  019a9  mov bx, 0x32
  019ac  mov dx, 0x1040
  019af  lcall 0x7d6, 0x635
  019b4  mov di, 0xfb2
  019b7  mov si, 0x11d6
  019ba  lcall 0x7d6, 0x10a6
  019bf  mov bx, 0x1404  ; 'The Gate is'
  019c2  mov dx, 0xed2
  019c5  lcall 0x7d6, 0xf62
  019ca  mov bx, 0x13f4  ; 'locked.'
  019cd  mov dx, 0xed6
  019d0  lcall 0x7d6, 0xf62
  019d5  jmp 0x1bd7
L19D8:
  019d8  mov di, 0x1098
  019db  mov si, 0xfd2
  019de  lcall 0x7d6, 0x19ce
  019e3  je 0x19e8
  019e5  jmp 0x1a2d
L19E8:
  019e8  mov bx, 0x32
  019eb  mov dx, 0x1040
  019ee  lcall 0x7d6, 0x635
  019f3  mov di, 0xfb2
  019f6  mov si, 0x1090
  019f9  lcall 0x7d6, 0x10a6
  019fe  mov bx, 0x1414  ; 'The Vampire'
  01a01  mov dx, 0xed2
  01a04  lcall 0x7d6, 0xf62
  01a09  mov bx, 0x1424  ; 'is blocking'
  01a0c  mov dx, 0xed6
  01a0f  lcall 0x7d6, 0xf62
  01a14  mov bx, 0x1434  ; 'your way. He'
  01a17  mov dx, 0xeda
  01a1a  lcall 0x7d6, 0xf62
  01a1f  mov bx, 0x1444  ; "can't be hurt."
  01a22  mov dx, 0xede
  01a25  lcall 0x7d6, 0xf62
  01a2a  jmp 0x1bd7
L1A2D:
  01a2d  mov di, 0x1456
  01a30  mov si, 0xfd2
  01a33  lcall 0x7d6, 0x19ce
  01a38  je 0x1a3d
  01a3a  jmp 0x1a82
L1A3D:
  01a3d  mov bx, 0x32
  01a40  mov dx, 0x1040
  01a43  lcall 0x7d6, 0x635
  01a48  mov di, 0xfb2
  01a4b  mov si, 0x1090
  01a4e  lcall 0x7d6, 0x10a6
  01a53  mov bx, 0x145a  ; 'The Fairy'
  01a56  mov dx, 0xed2
  01a59  lcall 0x7d6, 0xf62
  01a5e  mov bx, 0x1424  ; 'is blocking'
  01a61  mov dx, 0xed6
  01a64  lcall 0x7d6, 0xf62
  01a69  mov bx, 0x1434  ; 'your way. He'
  01a6c  mov dx, 0xeda
  01a6f  lcall 0x7d6, 0xf62
  01a74  mov bx, 0x1444  ; "can't be hurt."
  01a77  mov dx, 0xede
  01a7a  lcall 0x7d6, 0xf62
  01a7f  jmp 0x1bd7
L1A82:
  01a82  mov si, 0xfaa
  01a85  lcall 0x7d6, 0x26aa
  01a8a  jne 0x1a8f
  01a8c  jmp 0x1b1f
L1A8F:
  01a8f  mov si, 0x1040
  01a92  lcall 0x7d6, 0x10bd
  01a97  jmp 0x1b08  ; ' a staircase!'
L1A9A:
  01a9a  mov si, 0xf32
  01a9d  mov dx, si
  01a9f  lcall 0x7d6, 0x227f
  01aa4  mov si, bx
  01aa6  shl si, 1
  01aa8  shl si, 1
  01aaa  mov bx, si
  01aac  add si, 0xea2
  01ab0  mov di, 0xfd2
  01ab3  lcall 0x7d6, 0x19ce
  01ab8  je 0x1abd
  01aba  jmp 0x1afd
L1ABD:
  01abd  mov cx, bx
  01abf  add bx, 0xdc2
  01ac3  mov si, bx
  01ac5  mov di, 0xfca
  01ac8  lcall 0x7d6, 0x19ce
  01acd  mov ax, 0
  01ad0  jne 0x1ad3
  01ad2  dec ax
L1AD3:
  01ad3  add cx, 0xdee
  01ad7  mov si, cx
  01ad9  mov di, 0xfce
  01adc  lcall 0x7d6, 0x19ce
  01ae1  mov bx, 0
  01ae4  jne 0x1ae7
  01ae6  dec bx
L1AE7:
  01ae7  and bx, ax
  01ae9  and bx, bx
  01aeb  jne 0x1af0
  01aed  jmp 0x1afd
L1AF0:
  01af0  mov si, dx
  01af2  mov di, 0xfe6
  01af5  lcall 0x7d6, 0x10a6
  01afa  jmp 0x20bf
L1AFD:
  01afd  mov di, 0x1040
  01b00  mov si, 0xf32
  01b03  lcall 0x7d6, 0x1772
L1B08:
  01b08  mov di, 0xf32
  01b0b  lcall 0x7d6, 0x10a3
  01b10  mov si, di
  01b12  mov di, 0x13dc
  01b15  lcall 0x7d6, 0x19ce
  01b1a  ja 0x1b1f
  01b1c  jmp 0x1a9a
L1B1F:
  01b1f  xor bx, bx
  01b21  lcall 0x7d6, 0x13c9
  01b26  mov bx, 0x41c
  01b29  mov ds, word ptr [0x90]
  01b2d  mov bl, byte ptr [bx]
  01b2f  xor bh, bh
  01b31  push es
  01b32  pop ds
  01b33  xchg bx, ax
  01b34  mov bx, 0x41a
  01b37  mov ds, word ptr [0x90]
  01b3b  mov byte ptr [bx], al
  01b3d  push es
  01b3e  pop ds
  01b3f  jmp 0xc83
L1B42:
  01b42  mov bx, 0x1f4
  01b45  mov dx, 0x1040
  01b48  lcall 0x7d6, 0x635
  01b4d  mov di, 0x1468
  01b50  mov si, 0xfea
  01b53  lcall 0x7d6, 0x19ce
  01b58  je 0x1b5d
  01b5a  jmp 0x1b81
L1B5D:
  01b5d  mov di, 0xfb2
  01b60  mov si, 0x11d6
  01b63  lcall 0x7d6, 0x10a6
  01b68  mov bx, 0x146c  ; " Can't carry"
  01b6b  mov dx, 0xed2
  01b6e  lcall 0x7d6, 0xf62
  01b73  mov bx, 0x147c  ; ' any more!'
  01b76  mov dx, 0xed6
  01b79  lcall 0x7d6, 0xf62
  01b7e  jmp 0x1bd7
L1B81:
  01b81  mov di, 0x1040
  01b84  mov si, 0xfea
  01b87  lcall 0x7d6, 0x1772
  01b8c  mov di, si
  01b8e  lcall 0x7d6, 0x10a3
  01b93  mov si, 0xf32
  01b96  lcall 0x7d6, 0x227f
  01b9b  mov di, bx
  01b9d  shl di, 1
  01b9f  shl di, 1
  01ba1  add di, 0xc26
  01ba5  mov si, 0x1088
  01ba8  lcall 0x7d6, 0x10a6
  01bad  mov si, 0xfca
  01bb0  lcall 0x7d6, 0x227f
  01bb5  lcall 0x7d6, 0xffd
  01bba  mov si, 0xfce
  01bbd  lcall 0x7d6, 0x227f
  01bc2  lcall 0x7d6, 0x1017
  01bc7  lcall 0x7d6, 0x3021
  01bcc  mov bx, 0x10a4  ; ' '
  01bcf  lcall 0x7d6, 0x2d79
  01bd4  jmp 0xc83
L1BD7:
  01bd7  mov si, 0x1146
  01bda  lcall 0x7d6, 0x10bd
  01bdf  jmp 0x1c15
L1BE2:
  01be2  mov si, 0xf32
  01be5  mov dx, si
  01be7  lcall 0x7d6, 0x227f
  01bec  lcall 0x7d6, 0xffd
  01bf1  mov bx, 0x1a
  01bf4  lcall 0x7d6, 0x1017
  01bf9  lcall 0x7d6, 0x3021
  01bfe  mov bx, 0xf
  01c01  lcall 0x7d6, 0x24b5
  01c06  lcall 0x7d6, 0x2d79
  01c0b  mov si, dx
  01c0d  mov di, 0x1040
  01c10  lcall 0x7d6, 0x1772
L1C15:
  01c15  mov di, 0xf32
  01c18  lcall 0x7d6, 0x10a3
  01c1d  mov si, di
  01c1f  mov di, 0x1094
  01c22  lcall 0x7d6, 0x19ce
  01c27  jbe 0x1be2
  01c29  mov di, 0xfee
  01c2c  mov si, 0xfb2
  01c2f  lcall 0x7d6, 0x10a6
  01c34  mov si, 0x1040
  01c37  lcall 0x7d6, 0x10bd
  01c3c  jmp 0x1c81
L1C3F:
  01c3f  mov di, 0x10b6
  01c42  mov si, 0xf32
  01c45  lcall 0x7d6, 0x1772
  01c4a  mov dx, si
  01c4c  lcall 0x7d6, 0x22ca
  01c51  lcall 0x7d6, 0xffd
  01c56  mov bx, 0x1a
  01c59  lcall 0x7d6, 0x1017
  01c5e  lcall 0x7d6, 0x3021
  01c63  mov si, dx
  01c65  lcall 0x7d6, 0x227f
  01c6a  shl bx, 1
  01c6c  shl bx, 1
  01c6e  add bx, 0xece
  01c72  lcall 0x7d6, 0x2d79
  01c77  mov si, dx
  01c79  mov di, 0x1040
  01c7c  lcall 0x7d6, 0x1772
L1C81:
  01c81  mov di, 0xf32
  01c84  lcall 0x7d6, 0x10a3
  01c89  mov si, di
  01c8b  mov di, 0xfee
  01c8e  lcall 0x7d6, 0x19ce
  01c93  jbe 0x1c3f
  01c95  xor bx, bx
  01c97  lcall 0x7d6, 0x13c9
  01c9c  mov bx, 0x41c
  01c9f  mov ds, word ptr [0x90]
  01ca3  mov bl, byte ptr [bx]
  01ca5  xor bh, bh
  01ca7  push es
  01ca8  pop ds
  01ca9  xchg bx, ax
  01caa  mov bx, 0x41a
  01cad  mov ds, word ptr [0x90]
  01cb1  mov byte ptr [bx], al
  01cb3  push es
  01cb4  pop ds
  01cb5  jmp 0xbfd
L1CB8:
  01cb8  mov si, 0x1040
  01cbb  lcall 0x7d6, 0x10bd
  01cc0  jmp 0x1d0d
L1CC3:
  01cc3  mov si, 0xf32
  01cc6  lcall 0x7d6, 0x227f
  01ccb  mov si, bx
  01ccd  shl si, 1
  01ccf  shl si, 1
  01cd1  mov bx, si
  01cd3  add si, 0xd96
  01cd7  mov di, 0xf1a
  01cda  lcall 0x7d6, 0x19ce
  01cdf  mov dx, 0
  01ce2  jne 0x1ce5
  01ce4  dec dx
L1CE5:
  01ce5  add bx, 0xeee
  01ce9  mov si, bx
  01ceb  mov di, 0x1062
  01cee  lcall 0x7d6, 0x19ce
  01cf3  mov cx, 0
  01cf6  jbe 0x1cf9
  01cf8  dec cx
L1CF9:
  01cf9  and cx, dx
  01cfb  and cx, cx
  01cfd  je 0x1d02
  01cff  jmp 0x1d24
L1D02:
  01d02  mov di, 0x1040
  01d05  mov si, 0xf32
  01d08  lcall 0x7d6, 0x1772
L1D0D:
  01d0d  mov di, 0xf32
  01d10  lcall 0x7d6, 0x10a3
  01d15  mov si, di
  01d17  mov di, 0x13dc
  01d1a  lcall 0x7d6, 0x19ce
  01d1f  jbe 0x1cc3
  01d21  jmp 0xcb1
L1D24:
  01d24  mov di, 0xff2
  01d27  mov si, 0x115e
  01d2a  lcall 0x7d6, 0x10a6
  01d2f  mov di, 0xff6
  01d32  lcall 0x7d6, 0x10a6
  01d37  mov si, 0xf32
  01d3a  lcall 0x7d6, 0x227f
  01d3f  mov si, bx
  01d41  shl si, 1
  01d43  shl si, 1
  01d45  add si, 0xdc2
  01d49  mov di, 0xf1e
  01d4c  lcall 0x7d6, 0x19ce
  01d51  jb 0x1d56
  01d53  jmp 0x1d61
L1D56:
  01d56  mov di, 0xff2
  01d59  mov si, 0x1040
  01d5c  lcall 0x7d6, 0x10a6
L1D61:
  01d61  mov si, 0xf32
  01d64  lcall 0x7d6, 0x227f
  01d69  mov si, bx
  01d6b  shl si, 1
  01d6d  shl si, 1
  01d6f  add si, 0xdc2
  01d73  mov di, 0xf1e
  01d76  lcall 0x7d6, 0x19ce
  01d7b  ja 0x1d80
  01d7d  jmp 0x1d8b
L1D80:
  01d80  mov di, 0xff2
  01d83  mov si, 0x1062
  01d86  lcall 0x7d6, 0x10a6
L1D8B:
  01d8b  mov si, 0xf32
  01d8e  lcall 0x7d6, 0x227f
  01d93  mov si, bx
  01d95  shl si, 1
  01d97  shl si, 1
  01d99  add si, 0xdee
  01d9d  mov di, 0xf22
  01da0  lcall 0x7d6, 0x19ce
  01da5  jb 0x1daa
  01da7  jmp 0x1db5
L1DAA:
  01daa  mov di, 0xff6
  01dad  mov si, 0x1040
  01db0  lcall 0x7d6, 0x10a6
L1DB5:
  01db5  mov si, 0xf32
  01db8  lcall 0x7d6, 0x227f
  01dbd  mov si, bx
  01dbf  shl si, 1
  01dc1  shl si, 1
  01dc3  add si, 0xdee
  01dc7  mov di, 0xf22
  01dca  lcall 0x7d6, 0x19ce
  01dcf  ja 0x1dd4
  01dd1  jmp 0x1ddf
L1DD4:
  01dd4  mov di, 0xff6
  01dd7  mov si, 0x1062
  01dda  lcall 0x7d6, 0x10a6
L1DDF:
  01ddf  mov si, 0xf32
  01de2  lcall 0x7d6, 0x227f
  01de7  mov si, bx
  01de9  shl si, 1
  01deb  shl si, 1
  01ded  mov bx, si
  01def  add si, 0xdee
  01df3  mov di, 0xff6
  01df6  lcall 0x7d6, 0x1772
  01dfb  mov dx, bx
  01dfd  lcall 0x7d6, 0x22ca
  01e02  add dx, 0xdc2
  01e06  mov si, dx
  01e08  mov di, 0xff2
  01e0b  lcall 0x7d6, 0x1772
  01e10  mov dx, bx
  01e12  lcall 0x7d6, 0x22ca
  01e17  mov cx, 0x7fff
  01e1a  lcall 0x7d6, 0xb3b
  01e1f  lcall 0x7d6, 0x2237
  01e24  mov di, 0xffa
  01e27  lcall 0x7d6, 0x10a3
  01e2c  mov di, 0x1098
  01e2f  mov si, 0xffa
  01e32  lcall 0x7d6, 0x19ce
  01e37  jne 0x1e3c
  01e39  jmp 0x1f1b
L1E3C:
  01e3c  mov di, 0x10ca
  01e3f  mov si, 0xffa
  01e42  lcall 0x7d6, 0x19ce
  01e47  je 0x1e4c
  01e49  jmp 0x1d02
L1E4C:
  01e4c  mov si, 0xf32
  01e4f  lcall 0x7d6, 0x227f
  01e54  mov si, bx
  01e56  shl si, 1
  01e58  shl si, 1
  01e5a  mov bx, si
  01e5c  add si, 0xdc2
  01e60  mov dx, bx
  01e62  lcall 0x7d6, 0x227f
  01e67  lcall 0x7d6, 0xffd
  01e6c  add dx, 0xdee
  01e70  mov si, dx
  01e72  lcall 0x7d6, 0x227f
  01e77  lcall 0x7d6, 0x1017
  01e7c  lcall 0x7d6, 0x3021
  01e81  mov bx, 0x20
  01e84  lcall 0x7d6, 0x23be
  01e89  lcall 0x7d6, 0x2d79
  01e8e  mov si, 0xf32
  01e91  lcall 0x7d6, 0x227f
  01e96  mov di, bx
  01e98  shl di, 1
  01e9a  shl di, 1
  01e9c  mov bx, di
  01e9e  add di, 0xdc2
  01ea2  mov si, di
  01ea4  mov di, 0xff2
  01ea7  lcall 0x7d6, 0x1772
  01eac  mov di, si
  01eae  lcall 0x7d6, 0x10a3
  01eb3  add bx, 0xdee
  01eb7  mov di, bx
  01eb9  mov si, bx
  01ebb  mov di, 0xff6
  01ebe  lcall 0x7d6, 0x1772
  01ec3  mov di, bx
  01ec5  lcall 0x7d6, 0x10a3
  01eca  mov si, 0xf32
  01ecd  lcall 0x7d6, 0x227f
  01ed2  mov si, bx
  01ed4  shl si, 1
  01ed6  shl si, 1
  01ed8  mov bx, si
  01eda  add si, 0xdc2
  01ede  mov dx, bx
  01ee0  lcall 0x7d6, 0x227f
  01ee5  lcall 0x7d6, 0xffd
  01eea  mov bx, dx
  01eec  add dx, 0xdee
  01ef0  mov si, dx
  01ef2  mov cx, bx
  01ef4  lcall 0x7d6, 0x227f
  01ef9  lcall 0x7d6, 0x1017
  01efe  lcall 0x7d6, 0x3021
  01f03  add cx, 0xea2
  01f07  mov si, cx
  01f09  lcall 0x7d6, 0x227f
  01f0e  lcall 0x7d6, 0x23be
  01f13  lcall 0x7d6, 0x2d79
  01f18  jmp 0x1d02
L1F1B:
  01f1b  lcall 0x7d6, 0x2809
  01f20  mov di, 0x1048
  01f23  lcall 0x7d6, 0x189f
  01f28  mov bx, 0xaa
  01f2b  lcall 0x7d6, 0x273e
  01f30  mov di, 0x1040
  01f33  lcall 0x7d6, 0x1767
  01f38  mov di, 0xffe
  01f3b  lcall 0x7d6, 0x10a3
  01f40  mov si, 0xc4e
  01f43  lcall 0x7d6, 0x26aa
  01f48  je 0x1f4d
  01f4a  jmp 0x1f5e
L1F4D:
  01f4d  mov si, di
  01f4f  mov di, 0x148a
  01f52  lcall 0x7d6, 0x1772
  01f57  mov di, si
  01f59  lcall 0x7d6, 0x10a3
L1F5E:
  01f5e  mov di, 0x148e
  01f61  mov si, 0xffe
  01f64  lcall 0x7d6, 0x19ce
  01f69  jbe 0x1f6e
  01f6b  jmp 0x1f71
L1F6E:
  01f6e  jmp 0x1d02
L1F71:
  01f71  mov si, 0xf32
  01f74  lcall 0x7d6, 0x227f
  01f79  shl bx, 1
  01f7b  shl bx, 1
  01f7d  add bx, 0xe1a
  01f81  mov dx, 0x1002
  01f84  lcall 0x7d6, 0xf62
  01f89  mov bx, dx
  01f8b  mov dx, 0x10a4  ; ' '
  01f8e  mov cx, bx
  01f90  lcall 0x7d6, 0x245e
  01f95  lcall 0x7d6, 0x2237
  01f9a  mov di, 0xffa
  01f9d  lcall 0x7d6, 0x10a3
  01fa2  mov si, di
  01fa4  lcall 0x7d6, 0x26aa
  01fa9  ja 0x1fae
  01fab  jmp 0x1fd5
L1FAE:
  01fae  mov bx, cx
  01fb0  lcall 0x7d6, 0x2386
  01fb5  lcall 0x7d6, 0x2237
  01fba  lcall 0x7d6, 0x1752
  01fbf  lcall 0x7d6, 0x22ca
  01fc4  mov ax, bx
  01fc6  mov bx, cx
  01fc8  xchg dx, ax
  01fc9  lcall 0x7d6, 0x2478  ; 'You pour the'
  01fce  mov dx, cx
  01fd0  lcall 0x7d6, 0xf62
L1FD5:
  01fd5  mov di, 0xfb2
  01fd8  mov si, 0x11d6
  01fdb  lcall 0x7d6, 0x10a6
  01fe0  mov bx, 0x1002
  01fe3  mov ax, 0x1492  ; 'The '
  01fe6  lcall 0x7d6, 0xf98
  01feb  mov dx, 0xed2
  01fee  lcall 0x7d6, 0xf62
  01ff3  mov bx, 0x149a  ; 'Struck you!'
  01ff6  mov dx, 0xed6
  01ff9  lcall 0x7d6, 0xf62
  01ffe  mov bx, 0x96
  02001  mov dx, 0x1040
  02004  lcall 0x7d6, 0x635
  02009  mov bx, 0x5a
  0200c  mov dx, 0x14aa
  0200f  lcall 0x7d6, 0x635
  02014  mov bx, 0x28
  02017  lcall 0x7d6, 0x635
  0201c  lcall 0x7d6, 0x2809
  02021  mov di, 0x108c
  02024  lcall 0x7d6, 0x189f
  02029  mov bx, 0xaa
  0202c  lcall 0x7d6, 0x273e
  02031  mov si, 0xf2e
  02034  lcall 0x7d6, 0x175a
  02039  mov di, 0x1098
  0203c  mov bx, si
  0203e  lcall 0x7d6, 0x1767
  02043  mov di, bx
  02045  lcall 0x7d6, 0x10a3
  0204a  mov si, 0xf2e
  0204d  lcall 0x7d6, 0x26aa
  02052  jb 0x2057
  02054  jmp 0x2083
L2057:
  02057  mov di, 0xfb2
  0205a  mov si, 0x11d6
  0205d  lcall 0x7d6, 0x10a6
  02062  mov bx, 0x1002
  02065  mov ax, 0x1492  ; 'The '
  02068  lcall 0x7d6, 0xf98
  0206d  mov dx, 0xed2
  02070  lcall 0x7d6, 0xf62
  02075  mov bx, 0x14ae  ; 'has Killed you!'
  02078  mov dx, 0xed6
  0207b  lcall 0x7d6, 0xf62
  02080  jmp 0x63b0
L2083:
  02083  mov si, 0xc4e
  02086  lcall 0x7d6, 0x26aa
  0208b  je 0x2090
  0208d  jmp 0x20bc
L2090:
  02090  mov di, 0xfb2
  02093  mov si, 0x1098
  02096  lcall 0x7d6, 0x10a6
  0209b  mov bx, 0x106a  ; ''
  0209e  mov dx, 0xeda
  020a1  lcall 0x7d6, 0xf62
  020a6  mov bx, 0x14c2  ; 'The Helmet'
  020a9  mov dx, 0xede
  020ac  lcall 0x7d6, 0xf62
  020b1  mov bx, 0x14d0  ; 'helped.'
  020b4  mov dx, 0xee2
  020b7  lcall 0x7d6, 0xf62
L20BC:
  020bc  jmp 0x1bd7
L20BF:
  020bf  mov si, 0xc3e
  020c2  lcall 0x7d6, 0x26aa
  020c7  jne 0x20cc
  020c9  jmp 0x20f0
L20CC:
  020cc  mov di, 0xfb2
  020cf  mov si, 0x11d6
  020d2  lcall 0x7d6, 0x10a6
  020d7  mov bx, 0x14dc  ; 'You have no'
  020da  mov dx, 0xed2
  020dd  lcall 0x7d6, 0xf62
  020e2  mov bx, 0x14ec  ; 'Weapon!'
  020e5  mov dx, 0xed6
  020e8  lcall 0x7d6, 0xf62
  020ed  jmp 0x1bd7
L20F0:
  020f0  lcall 0x7d6, 0x2809
  020f5  mov di, 0x1048
  020f8  lcall 0x7d6, 0x189f
  020fd  mov bx, 0xaa
  02100  lcall 0x7d6, 0x273e
  02105  mov di, 0x1040
  02108  lcall 0x7d6, 0x1767
  0210d  mov di, 0xffe
  02110  lcall 0x7d6, 0x10a3
  02115  mov di, 0x14f8
  02118  mov si, 0xffe
  0211b  lcall 0x7d6, 0x19ce
  02120  jbe 0x2125
  02122  jmp 0x2128
L2125:
  02125  jmp 0xbfd
L2128:
  02128  mov si, 0xfe6
  0212b  lcall 0x7d6, 0x227f
  02130  shl bx, 1
  02132  shl bx, 1
  02134  add bx, 0xe1a
  02138  mov dx, 0x1002
  0213b  lcall 0x7d6, 0xf62
  02140  mov bx, dx
  02142  mov dx, 0x10a4  ; ' '
  02145  mov cx, bx
  02147  lcall 0x7d6, 0x245e
  0214c  lcall 0x7d6, 0x2237
  02151  mov di, 0xffa
  02154  lcall 0x7d6, 0x10a3
  02159  mov si, di
  0215b  lcall 0x7d6, 0x26aa
  02160  ja 0x2165
  02162  jmp 0x218c  ; '    '
L2165:
  02165  mov bx, cx
  02167  lcall 0x7d6, 0x2386
  0216c  lcall 0x7d6, 0x2237
  02171  lcall 0x7d6, 0x1752
  02176  lcall 0x7d6, 0x22ca
  0217b  mov ax, bx
  0217d  mov bx, cx
  0217f  xchg dx, ax
  02180  lcall 0x7d6, 0x2478  ; 'You pour the'
  02185  mov dx, cx
  02187  lcall 0x7d6, 0xf62
L218C:
  0218c  mov si, 0xfe6
  0218f  lcall 0x7d6, 0x227f
  02194  mov di, bx
  02196  shl di, 1
  02198  shl di, 1
  0219a  mov bx, di
  0219c  add di, 0xeee
  021a0  lcall 0x7d6, 0x2809
  021a5  mov dx, di
  021a7  mov di, 0x108c
  021aa  lcall 0x7d6, 0x189f
  021af  mov cx, bx
  021b1  mov bx, 0xaa
  021b4  lcall 0x7d6, 0x273e
  021b9  mov si, dx
  021bb  lcall 0x7d6, 0x175a
  021c0  mov di, 0x1098
  021c3  lcall 0x7d6, 0x1767
  021c8  mov di, dx
  021ca  lcall 0x7d6, 0x10a3
  021cf  add cx, 0xeee
  021d3  mov si, cx
  021d5  lcall 0x7d6, 0x26aa
  021da  jae 0x21df
  021dc  jmp 0x2214
L21DF:
  021df  mov di, 0xfb2
  021e2  mov si, 0x11d6
  021e5  lcall 0x7d6, 0x10a6
  021ea  mov bx, 0x14fc  ; 'You struck'
  021ed  mov dx, 0xed2
  021f0  lcall 0x7d6, 0xf62
  021f5  mov bx, 0x1002
  021f8  mov ax, 0x150a  ; 'the '
  021fb  lcall 0x7d6, 0xf98
  02200  xchg bx, ax
  02201  mov bx, 0x1512  ; '!'
  02204  lcall 0x7d6, 0xf98
  02209  mov dx, 0xed6
  0220c  lcall 0x7d6, 0xf62
  02211  jmp 0x1bd7
L2214:
  02214  mov di, 0xfb2
  02217  mov si, 0x11d6
  0221a  lcall 0x7d6, 0x10a6
  0221f  mov bx, 0x1518  ; 'You Killed'
  02222  mov dx, 0xed2
  02225  lcall 0x7d6, 0xf62
  0222a  mov bx, 0x1002
  0222d  mov ax, 0x150a  ; 'the '
  02230  lcall 0x7d6, 0xf98
  02235  xchg bx, ax
  02236  mov bx, 0x1512  ; '!'
  02239  lcall 0x7d6, 0xf98
  0223e  mov dx, 0xed6
  02241  lcall 0x7d6, 0xf62
  02246  mov di, 0xfaa
  02249  mov si, 0x1088
  0224c  lcall 0x7d6, 0x10a6
  02251  mov si, 0xfe6
  02254  lcall 0x7d6, 0x227f
  02259  shl bx, 1
  0225b  shl bx, 1
  0225d  add bx, 0xe1a
  02261  mov dx, bx
  02263  mov bx, 0x1002
  02266  mov ax, 0x1526  ; 'Dead '
  02269  lcall 0x7d6, 0xf98
  0226e  lcall 0x7d6, 0xf62
  02273  mov si, 0x1040
  02276  lcall 0x7d6, 0x10bd
  0227b  jmp 0x22d3
L227E:
  0227e  mov si, 0xf32
  02281  lcall 0x7d6, 0x227f
  02286  mov si, bx
  02288  shl si, 1
  0228a  shl si, 1
  0228c  mov bx, si
  0228e  add si, 0xd96
  02292  mov di, 0xf1a
  02295  lcall 0x7d6, 0x19ce
  0229a  mov dx, 0
  0229d  jne 0x22a0
  0229f  dec dx
L22A0:
  022a0  add bx, 0xeee
  022a4  mov si, bx
  022a6  mov di, 0x1062
  022a9  lcall 0x7d6, 0x19ce
  022ae  mov cx, 0
  022b1  jbe 0x22b4
  022b3  dec cx
L22B4:
  022b4  and cx, dx
  022b6  and cx, cx
  022b8  jne 0x22bd
  022ba  jmp 0x22c8
L22BD:
  022bd  mov di, 0xfaa
  022c0  mov si, 0x1040
  022c3  lcall 0x7d6, 0x10a6
L22C8:
  022c8  mov di, 0x1040
  022cb  mov si, 0xf32
  022ce  lcall 0x7d6, 0x1772
L22D3:
  022d3  mov di, 0xf32
  022d6  lcall 0x7d6, 0x10a3
  022db  mov si, di
  022dd  mov di, 0x13dc
  022e0  lcall 0x7d6, 0x19ce
  022e5  jbe 0x227e
  022e7  jmp 0x1bd7
L22EA:
  022ea  mov si, 0x1040
  022ed  lcall 0x7d6, 0x10bd
  022f2  jmp 0x237c
L22F5:
  022f5  mov si, 0xf32
  022f8  lcall 0x7d6, 0x227f
  022fd  shl bx, 1
  022ff  shl bx, 1
  02301  add bx, 0xc82
  02305  mov dx, 0xfd6
  02308  lcall 0x7d6, 0xf62
  0230d  mov bx, 0x20
  02310  lcall 0x7d6, 0x23be
  02315  xchg bx, dx
  02317  lcall 0x7d6, 0x245e
  0231c  lcall 0x7d6, 0x2237
  02321  mov di, 0xfb2
  02324  lcall 0x7d6, 0x10a3
  02329  mov si, 0xfb2
  0232c  lcall 0x7d6, 0x26aa
  02331  ja 0x2336  ; 'DOWN'
  02333  jmp 0x2361
L2336:
  02336  mov bx, 0xfd6
  02339  mov dx, bx
  0233b  lcall 0x7d6, 0x2386
  02340  lcall 0x7d6, 0x2237
  02345  mov di, si
  02347  lcall 0x7d6, 0x1752
  0234c  lcall 0x7d6, 0x22ca
  02351  xchg bx, dx
  02353  mov cx, bx
  02355  lcall 0x7d6, 0x2478  ; 'You pour the'
  0235a  mov dx, cx
  0235c  lcall 0x7d6, 0xf62
L2361:
  02361  mov bx, 0xfd6
  02364  mov ax, 0xfe2
  02367  lcall 0x7d6, 0xfd2
  0236c  jne 0x2371
  0236e  jmp 0x2854
L2371:
  02371  mov di, 0x1040
  02374  mov si, 0xf32
  02377  lcall 0x7d6, 0x1772
L237C:
  0237c  mov di, 0xf32
  0237f  lcall 0x7d6, 0x10a3
  02384  mov si, di
  02386  mov di, 0x104c
  02389  lcall 0x7d6, 0x19ce
  0238e  ja 0x2393
  02390  jmp 0x22f5
L2393:
  02393  mov bx, 0x1530  ; 'TABLE'
  02396  mov ax, 0xfe2
  02399  lcall 0x7d6, 0xfd2
  0239e  jne 0x23a3
  023a0  jmp 0x2b15
L23A3:
  023a3  mov bx, 0x153a  ; 'DESK'
  023a6  mov ax, 0xfe2
  023a9  lcall 0x7d6, 0xfd2
  023ae  jne 0x23b3
  023b0  jmp 0x2ba1
L23B3:
  023b3  mov bx, 0x1542  ; 'BED'
  023b6  mov ax, 0xfe2
  023b9  lcall 0x7d6, 0xfd2
  023be  mov dx, 0
  023c1  jne 0x23c4
  023c3  dec dx
L23C4:
  023c4  mov bx, 0x154a  ; 'BEDS'
  023c7  lcall 0x7d6, 0xfd2
  023cc  mov cx, 0
  023cf  jne 0x23d2
  023d1  dec cx
L23D2:
  023d2  or cx, dx
  023d4  and cx, cx
  023d6  je 0x23db
  023d8  jmp 0x2d32
L23DB:
  023db  mov bx, 0x1552  ; 'SHELF'
  023de  mov ax, 0xfe2
  023e1  lcall 0x7d6, 0xfd2
  023e6  mov dx, 0
  023e9  jne 0x23ec
  023eb  dec dx
L23EC:
  023ec  mov bx, 0x155c  ; 'SHELVES'
  023ef  lcall 0x7d6, 0xfd2
  023f4  mov cx, 0
  023f7  jne 0x23fa
  023f9  dec cx
L23FA:
  023fa  or cx, dx
  023fc  and cx, cx
  023fe  je 0x2403
  02400  jmp 0x2ed8
L2403:
  02403  mov bx, 0x1568  ; 'THRONE'
  02406  mov ax, 0xfe2
  02409  lcall 0x7d6, 0xfd2
  0240e  jne 0x2413
  02410  jmp 0x315b
L2413:
  02413  mov bx, 0x1572  ; 'FOUNTAIN'
  02416  mov ax, 0xfe2
  02419  lcall 0x7d6, 0xfd2
  0241e  jne 0x2423
  02420  jmp 0x31b3
L2423:
  02423  mov bx, 0x157e  ; 'STATUE'
  02426  mov ax, 0xfe2
  02429  lcall 0x7d6, 0xfd2
  0242e  jne 0x2433
  02430  jmp 0x322c
L2433:
  02433  mov bx, 0x135e  ; 'MIRROR'
  02436  mov ax, 0xfe2
  02439  lcall 0x7d6, 0xfd2
  0243e  jne 0x2443
  02440  jmp 0x32ce
L2443:
  02443  mov bx, 0x1588  ; 'BARREL'
  02446  mov ax, 0xfe2
  02449  lcall 0x7d6, 0xfd2
  0244e  mov dx, 0
  02451  jne 0x2454
  02453  dec dx
L2454:
  02454  mov bx, 0x1592  ; 'BARRELS'
  02457  lcall 0x7d6, 0xfd2
  0245c  mov cx, 0
  0245f  jne 0x2462
  02461  dec cx
L2462:
  02462  or cx, dx
  02464  and cx, cx
  02466  je 0x246b
  02468  jmp 0x3326
L246B:
  0246b  mov bx, 0x159e  ; 'CHAIN'
  0246e  mov ax, 0xfe2
  02471  lcall 0x7d6, 0xfd2
  02476  mov dx, 0
  02479  jne 0x247c
  0247b  dec dx
L247C:
  0247c  mov bx, 0x15a8  ; 'CHAINS'
  0247f  lcall 0x7d6, 0xfd2
  02484  mov cx, 0
  02487  jne 0x248a
  02489  dec cx
L248A:
  0248a  or cx, dx
  0248c  and cx, cx
  0248e  je 0x2493
  02490  jmp 0x33ba
L2493:
  02493  mov bx, 0x15b2  ; 'WALLS'
  02496  mov ax, 0xfe2
  02499  lcall 0x7d6, 0xfd2
  0249e  mov dx, 0
  024a1  jne 0x24a4  ; 'the ground.'
  024a3  dec dx
L24A4:
  024a4  mov bx, 0x15bc  ; 'WALL'
  024a7  lcall 0x7d6, 0xfd2
  024ac  mov cx, 0
  024af  jne 0x24b2
  024b1  dec cx
L24B2:
  024b2  or cx, dx
  024b4  mov bx, 0x15c4  ; 'ROOF'
  024b7  lcall 0x7d6, 0xfd2
  024bc  mov dx, 0
  024bf  jne 0x24c2
  024c1  dec dx
L24C2:
  024c2  or dx, cx
  024c4  mov bx, 0x15cc  ; 'FLOOR'
  024c7  lcall 0x7d6, 0xfd2
  024cc  mov cx, 0
  024cf  jne 0x24d2
  024d1  dec cx
L24D2:
  024d2  or cx, dx
  024d4  mov bx, 0x15d6  ; 'CEILING'
  024d7  lcall 0x7d6, 0xfd2
  024dc  mov dx, 0
  024df  jne 0x24e2
  024e1  dec dx
L24E2:
  024e2  or dx, cx
  024e4  mov bx, 0x15e2  ; 'ARCHWAY'
  024e7  lcall 0x7d6, 0xfd2
  024ec  mov cx, 0
  024ef  jne 0x24f2
  024f1  dec cx
L24F2:
  024f2  or cx, dx
  024f4  mov bx, 0x15ee  ; 'ARCHWAYS'
  024f7  lcall 0x7d6, 0xfd2
  024fc  mov dx, 0
  024ff  jne 0x2502
  02501  dec dx
L2502:
  02502  or dx, cx
  02504  and dx, dx
  02506  je 0x250b
  02508  jmp 0x344e
L250B:
  0250b  mov bx, 0x15fa  ; 'GARDEN'
  0250e  mov ax, 0xfe2
  02511  lcall 0x7d6, 0xfd2
  02516  mov dx, 0
  02519  jne 0x251c
  0251b  dec dx
L251C:
  0251c  mov bx, 0x1604  ; 'GARDENS'
  0251f  lcall 0x7d6, 0xfd2
  02524  mov cx, 0
  02527  jne 0x252a  ; '.'
  02529  dec cx
L252A:
  0252a  or cx, dx
  0252c  and cx, cx
  0252e  je 0x2533
  02530  jmp 0x356b
L2533:
  02533  mov bx, 0x1610  ; 'STAIRS'
  02536  mov ax, 0xfe2
  02539  lcall 0x7d6, 0xfd2
  0253e  mov dx, 0
  02541  jne 0x2544
  02543  dec dx
L2544:
  02544  mov bx, 0x161a  ; 'STAIR'
  02547  lcall 0x7d6, 0xfd2
  0254c  mov cx, 0
  0254f  jne 0x2552
  02551  dec cx
L2552:
  02552  or cx, dx
  02554  mov bx, 0x1624  ; 'STAIRCASE'
  02557  lcall 0x7d6, 0xfd2
  0255c  mov dx, 0
  0255f  jne 0x2562
  02561  dec dx
L2562:
  02562  or dx, cx
  02564  and dx, dx
  02566  je 0x256b
  02568  jmp 0x2ff3
L256B:
  0256b  mov bx, 0x1632  ; 'BALCONY'
  0256e  mov ax, 0xfe2
  02571  lcall 0x7d6, 0xfd2
  02576  jne 0x257b
  02578  jmp 0x3618
L257B:
  0257b  mov bx, 0x163e  ; 'GATE'
  0257e  mov ax, 0xfe2
  02581  lcall 0x7d6, 0xfd2
  02586  mov dx, 0
  02589  jne 0x258c
  0258b  dec dx
L258C:
  0258c  mov di, 0x1040
  0258f  mov si, 0xf1a
  02592  lcall 0x7d6, 0x19ce
  02597  mov bx, 0
  0259a  jne 0x259d
  0259c  dec bx
L259D:
  0259d  and bx, dx
  0259f  and bx, bx
  025a1  jne 0x25a6
  025a3  jmp 0x25ca
L25A6:
  025a6  mov di, 0xfb2
  025a9  mov si, 0x11d6
  025ac  lcall 0x7d6, 0x10a6
  025b1  mov bx, 0x1646  ; ' It looks'
  025b4  mov dx, 0xed2
  025b7  lcall 0x7d6, 0xf62
  025bc  mov bx, 0x1654  ; ' very Strong.'
  025bf  mov dx, 0xed6
  025c2  lcall 0x7d6, 0xf62
  025c7  jmp 0x1bd7
L25CA:
  025ca  mov bx, 0x1666  ; 'DOOR'
  025cd  mov ax, 0xfe2
  025d0  lcall 0x7d6, 0xfd2
  025d5  je 0x25da
  025d7  jmp 0x2626
L25DA:
  025da  mov di, 0x112a
  025dd  mov si, 0xf1a
  025e0  lcall 0x7d6, 0x19ce
  025e5  mov bx, 0
  025e8  jne 0x25eb
  025ea  dec bx
L25EB:
  025eb  mov di, 0x1126
  025ee  lcall 0x7d6, 0x19ce
  025f3  mov dx, 0
  025f6  jne 0x25f9
  025f8  dec dx
L25F9:
  025f9  or dx, bx
  025fb  and dx, dx
  025fd  jne 0x2602
  025ff  jmp 0x2626
L2602:
  02602  mov di, 0xfb2
  02605  mov si, 0x11d6
  02608  lcall 0x7d6, 0x10a6
  0260d  mov bx, 0x1646  ; ' It looks'
  02610  mov dx, 0xed2
  02613  lcall 0x7d6, 0xf62
  02618  mov bx, 0x1654  ; ' very Strong.'
  0261b  mov dx, 0xed6
  0261e  lcall 0x7d6, 0xf62
  02623  jmp 0x1bd7
L2626:
  02626  mov si, 0x1040
  02629  lcall 0x7d6, 0x10bd
  0262e  jmp 0x26df
L2631:
  02631  mov si, 0xf32
  02634  lcall 0x7d6, 0x227f
  02639  shl bx, 1
  0263b  shl bx, 1
  0263d  add bx, 0xe1a
  02641  mov dx, 0xfd6
  02644  lcall 0x7d6, 0xf62
  02649  mov bx, 0x20
  0264c  lcall 0x7d6, 0x23be
  02651  xchg bx, dx
  02653  mov cx, bx
  02655  lcall 0x7d6, 0x245e
  0265a  lcall 0x7d6, 0x2237
  0265f  mov di, 0xffa
  02662  lcall 0x7d6, 0x10a3
  02667  mov si, di
  02669  lcall 0x7d6, 0x26aa
  0266e  ja 0x2673
  02670  jmp 0x269a
L2673:
  02673  mov bx, cx
  02675  lcall 0x7d6, 0x2386
  0267a  lcall 0x7d6, 0x2237
  0267f  lcall 0x7d6, 0x1752
  02684  lcall 0x7d6, 0x22ca
  02689  mov ax, bx
  0268b  mov bx, cx
  0268d  xchg dx, ax
  0268e  lcall 0x7d6, 0x2478  ; 'You pour the'
  02693  mov dx, cx
  02695  lcall 0x7d6, 0xf62
L269A:
  0269a  mov bx, 0xfd6
  0269d  mov ax, 0xfe2
  026a0  lcall 0x7d6, 0xfd2
  026a5  mov dx, 0
  026a8  jne 0x26ab
  026aa  dec dx
L26AB:
  026ab  mov si, 0xf32
  026ae  lcall 0x7d6, 0x227f
  026b3  mov si, bx
  026b5  shl si, 1
  026b7  shl si, 1
  026b9  add si, 0xd96
  026bd  mov di, 0xf1a
  026c0  lcall 0x7d6, 0x19ce
  026c5  mov bx, 0
  026c8  jne 0x26cb
  026ca  dec bx
L26CB:
  026cb  and bx, dx
  026cd  and bx, bx
  026cf  je 0x26d4
  026d1  jmp 0x2756
L26D4:
  026d4  mov di, 0x1040
  026d7  mov si, 0xf32
  026da  lcall 0x7d6, 0x1772
L26DF:
  026df  mov di, 0xf32
  026e2  lcall 0x7d6, 0x10a3
  026e7  mov si, di
  026e9  mov di, 0x1050
  026ec  lcall 0x7d6, 0x19ce
  026f1  ja 0x26f6
  026f3  jmp 0x2631
L26F6:
  026f6  mov di, 0xfb2
  026f9  mov si, 0x1098
  026fc  lcall 0x7d6, 0x10a6
  02701  mov bx, 0x166e  ; "I can't see"
  02704  mov dx, 0xed2
  02707  lcall 0x7d6, 0xf62
  0270c  mov bx, 0xfe2
  0270f  mov ax, 0x167e  ; 'a '
  02712  mov dx, bx
  02714  lcall 0x7d6, 0xf98
  02719  xchg bx, ax
  0271a  mov bx, 0x1684  ; ','
  0271d  lcall 0x7d6, 0xf98
  02722  mov cx, dx
  02724  mov dx, 0xed6
  02727  lcall 0x7d6, 0xf62
  0272c  mov bx, 0x168a  ; "and I don't"
  0272f  mov dx, 0xeda
  02732  lcall 0x7d6, 0xf62
  02737  mov bx, 0x169a  ; 'have a'
  0273a  mov dx, 0xede
  0273d  lcall 0x7d6, 0xf62
  02742  xchg cx, ax
  02743  mov bx, 0x1512  ; '!'
  02746  lcall 0x7d6, 0xf98
  0274b  mov dx, 0xee2
  0274e  lcall 0x7d6, 0xf62
  02753  jmp 0x1bd7
L2756:
  02756  mov di, 0x1050
  02759  mov si, 0xf32
  0275c  lcall 0x7d6, 0x19ce
  02761  mov bx, 0
  02764  jae 0x2767
  02766  dec bx
L2767:
  02767  mov dx, bx
  02769  lcall 0x7d6, 0x227f
  0276e  mov si, bx
  02770  shl si, 1
  02772  shl si, 1
  02774  add si, 0xeee
  02778  lcall 0x7d6, 0x26aa
  0277d  mov bx, 0
  02780  jbe 0x2783
  02782  dec bx
L2783:
  02783  and bx, dx
  02785  and bx, bx
  02787  jne 0x278c
  02789  jmp 0x27b8
L278C:
  0278c  mov di, 0xfb2
  0278f  mov si, 0x11d6
  02792  lcall 0x7d6, 0x10a6
  02797  mov bx, 0xfd6
  0279a  mov ax, 0x1492  ; 'The '
  0279d  lcall 0x7d6, 0xf98
  027a2  mov dx, 0xed2
  027a5  lcall 0x7d6, 0xf62
  027aa  mov bx, 0x16a4  ; 'looks Mean!'
  027ad  mov dx, 0xed6
  027b0  lcall 0x7d6, 0xf62
  027b5  jmp 0x1bd7
L27B8:
  027b8  mov di, 0x1050
  027bb  mov si, 0xf32
  027be  lcall 0x7d6, 0x19ce
  027c3  mov bx, 0
  027c6  jae 0x27c9
  027c8  dec bx
L27C9:
  027c9  mov dx, bx
  027cb  lcall 0x7d6, 0x227f
  027d0  mov si, bx
  027d2  shl si, 1
  027d4  shl si, 1
  027d6  add si, 0xeee
  027da  mov di, 0x1040
  027dd  lcall 0x7d6, 0x19ce
  027e2  mov bx, 0
  027e5  jae 0x27e8
  027e7  dec bx
L27E8:
  027e8  and bx, dx
  027ea  and bx, bx
  027ec  jne 0x27f1
  027ee  jmp 0x281d
L27F1:
  027f1  mov di, 0xfb2
  027f4  mov si, 0x11d6
  027f7  lcall 0x7d6, 0x10a6
  027fc  mov bx, 0xfd6
  027ff  mov ax, 0x1492  ; 'The '
  02802  lcall 0x7d6, 0xf98
  02807  mov dx, 0xed2
  0280a  lcall 0x7d6, 0xf62
  0280f  mov bx, 0x16b4  ; 'looks Dead!'
  02812  mov dx, 0xed6
  02815  lcall 0x7d6, 0xf62
  0281a  jmp 0x1bd7
L281D:
  0281d  mov di, 0xfb2
  02820  mov si, 0x10be
  02823  lcall 0x7d6, 0x10a6
  02828  mov bx, 0xfd6
  0282b  mov ax, 0x16c4  ; ' The '
  0282e  lcall 0x7d6, 0xf98
  02833  mov dx, 0xed2
  02836  lcall 0x7d6, 0xf62
  0283b  mov bx, 0x16ce  ; ' looks pretty'
  0283e  mov dx, 0xed6
  02841  lcall 0x7d6, 0xf62
  02846  mov bx, 0x16e0  ; ' but unhappy.'
  02849  mov dx, 0xeda
  0284c  lcall 0x7d6, 0xf62
  02851  jmp 0x1bd7
L2854:
  02854  mov si, 0xf32
  02857  lcall 0x7d6, 0x227f
  0285c  mov si, bx
  0285e  shl si, 1
  02860  shl si, 1
  02862  add si, 0xc26
  02866  lcall 0x7d6, 0x26aa
  0286b  jne 0x2870
  0286d  jmp 0x2894
L2870:
  02870  mov di, 0xfb2
  02873  mov si, 0x11d6
  02876  lcall 0x7d6, 0x10a6
  0287b  mov bx, 0x16f2  ; " You Don't"
  0287e  mov dx, 0xed2
  02881  lcall 0x7d6, 0xf62
  02886  mov bx, 0x1700  ; ' Have it!'
  02889  mov dx, 0xed6
  0288c  lcall 0x7d6, 0xf62
  02891  jmp 0x1bd7
L2894:
  02894  mov si, 0xf32
  02897  lcall 0x7d6, 0x227f
  0289c  lcall 0x7d6, 0x1cf1  db 16 ce 28 a9 2a f2 28 37 29 5b 29 7f 29 a3 29 bc 29 e0 29 3b 2a 5f 2a a9 2a cd 2a f1 2a f1 2a cd 2a cd 2a a9 2a cd 2a cd 2a a9 2a a9 2a
L28CE:
  028ce  mov di, 0xfb2
  028d1  mov si, 0x11d6
  028d4  lcall 0x7d6, 0x10a6
  028d9  mov bx, 0x170e  ; " It's lit"
  028dc  mov dx, 0xed2
  028df  lcall 0x7d6, 0xf62
  028e4  mov bx, 0x171c  ; ' Magically'
  028e7  mov dx, 0xed6
  028ea  lcall 0x7d6, 0xf62
  028ef  jmp 0x1bd7
L28F2:
  028f2  mov di, 0xfb2
  028f5  mov si, 0x1098
  028f8  lcall 0x7d6, 0x10a6
  028fd  mov bx, 0x172a  ; ' On the back'
  02900  mov dx, 0xed2
  02903  lcall 0x7d6, 0xf62
  02908  mov bx, 0x173a  ; ' it says:'
  0290b  mov dx, 0xed6
  0290e  lcall 0x7d6, 0xf62
  02913  mov bx, 0x1748  ; 'Protection from'
  02916  mov dx, 0xede
  02919  lcall 0x7d6, 0xf62
  0291e  mov bx, 0x175c  ; 'Traps.'
  02921  mov dx, 0xee2
  02924  lcall 0x7d6, 0xf62
  02929  mov bx, 0x106a  ; ''
  0292c  mov dx, 0xeda
  0292f  lcall 0x7d6, 0xf62
  02934  jmp 0x1bd7
L2937:
  02937  mov di, 0xfb2
  0293a  mov si, 0x11d6
  0293d  lcall 0x7d6, 0x10a6
  02942  mov bx, 0x1766  ; ' It is titled'
  02945  mov dx, 0xed2
  02948  lcall 0x7d6, 0xf62
  0294d  mov bx, 0x1778  ; "  `The Gate'"
  02950  mov dx, 0xed6
  02953  lcall 0x7d6, 0xf62
  02958  jmp 0x1bd7
L295B:
  0295b  mov di, 0xfb2
  0295e  mov si, 0x11d6
  02961  lcall 0x7d6, 0x10a6
  02966  mov bx, 0x1646  ; ' It looks'
  02969  mov dx, 0xed2
  0296c  lcall 0x7d6, 0xf62
  02971  mov bx, 0x1788  ; ' Magical!'
  02974  mov dx, 0xed6
  02977  lcall 0x7d6, 0xf62
  0297c  jmp 0x1bd7
L297F:
  0297f  mov di, 0xfb2
  02982  mov si, 0x11d6
  02985  lcall 0x7d6, 0x10a6
  0298a  mov bx, 0x1646  ; ' It looks'
  0298d  mov dx, 0xed2
  02990  lcall 0x7d6, 0xf62
  02995  mov bx, 0x1796  ; ' Sharp!'
  02998  mov dx, 0xed6
  0299b  lcall 0x7d6, 0xf62
  029a0  jmp 0x1bd7
L29A3:
  029a3  mov di, 0xfb2
  029a6  mov si, 0x1040
  029a9  lcall 0x7d6, 0x10a6
  029ae  mov bx, 0x17a2  ; ' It looks Old!'
  029b1  mov dx, 0xed2
  029b4  lcall 0x7d6, 0xf62
  029b9  jmp 0x1bd7
L29BC:
  029bc  mov di, 0xfb2
  029bf  mov si, 0x11d6
  029c2  lcall 0x7d6, 0x10a6
  029c7  mov bx, 0x17b4  ; " They're"
  029ca  mov dx, 0xed2
  029cd  lcall 0x7d6, 0xf62
  029d2  mov bx, 0x17c0  ; ' Bifocals'
  029d5  mov dx, 0xed6
  029d8  lcall 0x7d6, 0xf62
  029dd  jmp 0x1bd7
L29E0:
  029e0  mov di, 0xfb2
  029e3  mov si, 0x17ce
  029e6  lcall 0x7d6, 0x10a6
  029eb  mov bx, 0x17d2  ; ' You see a man'
  029ee  mov dx, 0xede
  029f1  lcall 0x7d6, 0xf62
  029f6  mov bx, 0x17e4  ; 'in a winding'
  029f9  mov dx, 0xee2
  029fc  lcall 0x7d6, 0xf62
  02a01  mov bx, 0x17f4  ; 'passage,waving'
  02a04  mov dx, 0xee6
  02a07  lcall 0x7d6, 0xf62
  02a0c  mov bx, 0x1806  ; 'a Wand.'
  02a0f  mov dx, 0xeea
  02a12  lcall 0x7d6, 0xf62
  02a17  mov bx, 0x1812  ; 'In the Cyrstal'
  02a1a  mov dx, 0xed2
  02a1d  lcall 0x7d6, 0xf62
  02a22  mov bx, 0x1824  ; 'Ball....'
  02a25  mov dx, 0xed6
  02a28  lcall 0x7d6, 0xf62
  02a2d  mov bx, 0x106a  ; ''
  02a30  mov dx, 0xeda
  02a33  lcall 0x7d6, 0xf62
  02a38  jmp 0x1bd7
L2A3B:
  02a3b  mov di, 0xfb2
  02a3e  mov si, 0x11d6
  02a41  lcall 0x7d6, 0x10a6
  02a46  mov bx, 0x1646  ; ' It looks'
  02a49  mov dx, 0xed2
  02a4c  lcall 0x7d6, 0xf62
  02a51  mov bx, 0x1830  ; ' Tough!'
  02a54  mov dx, 0xed6
  02a57  lcall 0x7d6, 0xf62
  02a5c  jmp 0x1bd7
L2A5F:
  02a5f  mov si, 0x1006
  02a62  lcall 0x7d6, 0x26aa
  02a67  je 0x2a6c
  02a69  jmp 0x2a85
L2A6C:
  02a6c  mov di, 0xfb2
  02a6f  mov si, 0x1040
  02a72  lcall 0x7d6, 0x10a6
  02a77  mov bx, 0x183c  ; " It's empty."
  02a7a  mov dx, 0xed2
  02a7d  lcall 0x7d6, 0xf62
  02a82  jmp 0x1bd7
L2A85:
  02a85  mov di, 0xfb2
  02a88  mov si, 0x11d6
  02a8b  lcall 0x7d6, 0x10a6
  02a90  mov bx, 0x184c  ; " It's filled"
  02a93  mov dx, 0xed2
  02a96  lcall 0x7d6, 0xf62
  02a9b  mov bx, 0x185c  ; ' with water.'
  02a9e  mov dx, 0xed6
  02aa1  lcall 0x7d6, 0xf62
  02aa6  jmp 0x1bd7
L2AA9:
  02aa9  mov di, 0xfb2
  02aac  mov si, 0x11d6
  02aaf  lcall 0x7d6, 0x10a6
  02ab4  mov bx, 0x186c  ; " It's made of"
  02ab7  mov dx, 0xed2
  02aba  lcall 0x7d6, 0xf62
  02abf  mov bx, 0x187e  ; ' Gold!'
  02ac2  mov dx, 0xed6
  02ac5  lcall 0x7d6, 0xf62
  02aca  jmp 0x1bd7
L2ACD:
  02acd  mov di, 0xfb2
  02ad0  mov si, 0x11d6
  02ad3  lcall 0x7d6, 0x10a6
  02ad8  mov bx, 0x1646  ; ' It looks'
  02adb  mov dx, 0xed2
  02ade  lcall 0x7d6, 0xf62
  02ae3  mov bx, 0x1888  ; ' Expensive!'
  02ae6  mov dx, 0xed6
  02ae9  lcall 0x7d6, 0xf62
  02aee  jmp 0x1bd7
L2AF1:
  02af1  mov di, 0xfb2
  02af4  mov si, 0x11d6
  02af7  lcall 0x7d6, 0x10a6
  02afc  mov bx, 0x1898  ; ' They look'
  02aff  mov dx, 0xed2
  02b02  lcall 0x7d6, 0xf62
  02b07  mov bx, 0x1888  ; ' Expensive!'
  02b0a  mov dx, 0xed6
  02b0d  lcall 0x7d6, 0xf62
  02b12  jmp 0x1bd7
L2B15:
  02b15  mov di, 0x1066
  02b18  mov si, 0xf1a
  02b1b  lcall 0x7d6, 0x19ce
  02b20  je 0x2b25
  02b22  jmp 0x2b49
L2B25:
  02b25  mov di, 0xfb2
  02b28  mov si, 0x11d6
  02b2b  lcall 0x7d6, 0x10a6
  02b30  mov bx, 0x186c  ; " It's made of"
  02b33  mov dx, 0xed2
  02b36  lcall 0x7d6, 0xf62
  02b3b  mov bx, 0x18a6  ; ' Stone.'
  02b3e  mov dx, 0xed6
  02b41  lcall 0x7d6, 0xf62
  02b46  jmp 0x1bd7
L2B49:
  02b49  mov di, 0x18b2
  02b4c  mov si, 0xf1a
  02b4f  lcall 0x7d6, 0x19ce
  02b54  je 0x2b59
  02b56  jmp 0x2b7d
L2B59:
  02b59  mov di, 0xfb2
  02b5c  mov si, 0x11d6
  02b5f  lcall 0x7d6, 0x10a6
  02b64  mov bx, 0x18b6  ; " It's covered"
  02b67  mov dx, 0xed2
  02b6a  lcall 0x7d6, 0xf62
  02b6f  mov bx, 0x18c8  ; ' with Blood!'
  02b72  mov dx, 0xed6
  02b75  lcall 0x7d6, 0xf62
  02b7a  jmp 0x1bd7
L2B7D:
  02b7d  mov di, 0xfb2
  02b80  mov si, 0x11d6
  02b83  lcall 0x7d6, 0x10a6
  02b88  mov bx, 0x18d8  ; " I don't see"
  02b8b  mov dx, 0xed2
  02b8e  lcall 0x7d6, 0xf62
  02b93  mov bx, 0x18e8  ; ' a Table.'
  02b96  mov dx, 0xed6
  02b99  lcall 0x7d6, 0xf62
  02b9e  jmp 0x1bd7
L2BA1:
  02ba1  mov di, 0x1050
  02ba4  mov si, 0xf1a
  02ba7  lcall 0x7d6, 0x19ce
  02bac  mov bx, 0
  02baf  jne 0x2bb2
  02bb1  dec bx
L2BB2:
  02bb2  mov di, 0x18f6
  02bb5  mov si, 0xc52
  02bb8  lcall 0x7d6, 0x19ce
  02bbd  mov dx, 0
  02bc0  jne 0x2bc3
  02bc2  dec dx
L2BC3:
  02bc3  and dx, bx
  02bc5  and dx, dx
  02bc7  jne 0x2bcc
  02bc9  jmp 0x2bfb
L2BCC:
  02bcc  mov di, 0xfb2
  02bcf  mov si, 0x10be
  02bd2  lcall 0x7d6, 0x10a6
  02bd7  mov bx, 0x18fa  ; ' There is a'
  02bda  mov dx, 0xed2
  02bdd  lcall 0x7d6, 0xf62
  02be2  mov bx, 0x190a  ; ' Wine Flask'
  02be5  mov dx, 0xed6
  02be8  lcall 0x7d6, 0xf62
  02bed  mov bx, 0x191a  ; ' on top.'
  02bf0  mov dx, 0xeda
  02bf3  lcall 0x7d6, 0xf62
  02bf8  jmp 0x1bd7
L2BFB:
  02bfb  mov di, 0x148e
  02bfe  mov si, 0xf1a
  02c01  lcall 0x7d6, 0x19ce
  02c06  mov bx, 0
  02c09  jne 0x2c0c
  02c0b  dec bx
L2C0C:
  02c0c  mov di, 0x1926
  02c0f  mov si, 0xc46
  02c12  lcall 0x7d6, 0x19ce
  02c17  mov dx, 0
  02c1a  jne 0x2c1d
  02c1c  dec dx
L2C1D:
  02c1d  and dx, bx
  02c1f  and dx, dx
  02c21  jne 0x2c26
  02c23  jmp 0x2c60
L2C26:
  02c26  mov di, 0xfb2
  02c29  mov si, 0x1090
  02c2c  lcall 0x7d6, 0x10a6
  02c31  mov bx, 0x18fa  ; ' There is a'
  02c34  mov dx, 0xed2
  02c37  lcall 0x7d6, 0xf62
  02c3c  mov bx, 0x192a  ; ' Pair of Eye'
  02c3f  mov dx, 0xed6
  02c42  lcall 0x7d6, 0xf62
  02c47  mov bx, 0x193a  ; ' Glasses on'
  02c4a  mov dx, 0xeda
  02c4d  lcall 0x7d6, 0xf62
  02c52  mov bx, 0x194a  ; ' Top.'
  02c55  mov dx, 0xede
  02c58  lcall 0x7d6, 0xf62
  02c5d  jmp 0x1bd7
L2C60:
  02c60  mov di, 0x1954
  02c63  mov si, 0xf1a
  02c66  lcall 0x7d6, 0x19ce
  02c6b  mov bx, 0
  02c6e  jne 0x2c71
  02c70  dec bx
L2C71:
  02c71  mov di, 0x1958
  02c74  mov si, 0xc42
  02c77  lcall 0x7d6, 0x19ce
  02c7c  mov dx, 0
  02c7f  jne 0x2c82
  02c81  dec dx
L2C82:
  02c82  and dx, bx
  02c84  and dx, dx
  02c86  jne 0x2c8b
  02c88  jmp 0x2caf
L2C8B:
  02c8b  mov di, 0xfb2
  02c8e  mov si, 0x11d6
  02c91  lcall 0x7d6, 0x10a6
  02c96  mov bx, 0x18fa  ; ' There is a'
  02c99  mov dx, 0xed2
  02c9c  lcall 0x7d6, 0xf62
  02ca1  mov bx, 0x195c  ; ' Key on top'
  02ca4  mov dx, 0xed6
  02ca7  lcall 0x7d6, 0xf62
  02cac  jmp 0x1bd7
L2CAF:
  02caf  mov di, 0x1050
  02cb2  mov si, 0xf1a
  02cb5  lcall 0x7d6, 0x19ce
  02cba  mov bx, 0
  02cbd  jne 0x2cc0
  02cbf  dec bx
L2CC0:
  02cc0  mov di, 0x148e
  02cc3  lcall 0x7d6, 0x19ce
  02cc8  mov dx, 0
  02ccb  jne 0x2cce
  02ccd  dec dx
L2CCE:
  02cce  or dx, bx
  02cd0  mov di, 0x1954
  02cd3  lcall 0x7d6, 0x19ce
  02cd8  mov bx, 0
  02cdb  jne 0x2cde
  02cdd  dec bx
L2CDE:
  02cde  or bx, dx
  02ce0  and bx, bx
  02ce2  jne 0x2ce7
  02ce4  jmp 0x2d0b
L2CE7:
  02ce7  mov di, 0xfb2
  02cea  mov si, 0x11d6
  02ced  lcall 0x7d6, 0x10a6
  02cf2  mov bx, 0x196c  ; " It's made"
  02cf5  mov dx, 0xed2
  02cf8  lcall 0x7d6, 0xf62
  02cfd  mov bx, 0x197a  ; ' of Wood.'
  02d00  mov dx, 0xed6
  02d03  lcall 0x7d6, 0xf62
  02d08  jmp 0x1bd7
L2D0B:
  02d0b  mov di, 0xfb2
  02d0e  mov si, 0x11d6
  02d11  lcall 0x7d6, 0x10a6
  02d16  mov bx, 0x18d8  ; " I don't see"
  02d19  mov dx, 0xed2
  02d1c  lcall 0x7d6, 0xf62
  02d21  mov bx, 0x1988  ; ' a desk!'
  02d24  mov dx, 0xed6
  02d27  lcall 0x7d6, 0xf62
  02d2c  jmp 0x1bd7
; ---- gap 0x2d2f-0x2d32 (3 bytes)
L2D32:
  02d32  mov di, 0xfb2
  02d35  mov si, 0x1040
  02d38  lcall 0x7d6, 0x10a6
  02d3d  mov bx, 0x154a  ; 'BEDS'
  02d40  mov ax, 0xfe2
  02d43  lcall 0x7d6, 0xfd2
  02d48  mov dx, 0
  02d4b  jne 0x2d4e
  02d4d  dec dx
L2D4E:
  02d4e  mov di, 0x1994
  02d51  mov si, 0xf1a
  02d54  lcall 0x7d6, 0x19ce
  02d59  mov bx, 0
  02d5c  jne 0x2d5f
  02d5e  dec bx
L2D5F:
  02d5f  and bx, dx
  02d61  and bx, bx
  02d63  jne 0x2d68
  02d65  jmp 0x2d76
L2D68:
  02d68  mov bx, 0x1998  ; " They're Red."
  02d6b  mov dx, 0xed2
  02d6e  lcall 0x7d6, 0xf62
  02d73  jmp 0x1bd7
L2D76:
  02d76  mov bx, 0x154a  ; 'BEDS'
  02d79  mov ax, 0xfe2
  02d7c  lcall 0x7d6, 0xfd2
  02d81  mov dx, 0
  02d84  jne 0x2d87
  02d86  dec dx
L2D87:
  02d87  mov di, 0x19aa
  02d8a  mov si, 0xf1a
  02d8d  lcall 0x7d6, 0x19ce
  02d92  mov bx, 0
  02d95  jne 0x2d98
  02d97  dec bx
L2D98:
  02d98  and bx, dx
  02d9a  and bx, bx
  02d9c  jne 0x2da1
  02d9e  jmp 0x2daf
L2DA1:
  02da1  mov bx, 0x19ae  ; " They're Blue."
  02da4  mov dx, 0xed2
  02da7  lcall 0x7d6, 0xf62
  02dac  jmp 0x1bd7
L2DAF:
  02daf  mov bx, 0x154a  ; 'BEDS'
  02db2  mov ax, 0xfe2
  02db5  lcall 0x7d6, 0xfd2
  02dba  mov dx, 0
  02dbd  jne 0x2dc0
  02dbf  dec dx
L2DC0:
  02dc0  mov di, 0x135a
  02dc3  mov si, 0xf1a
  02dc6  lcall 0x7d6, 0x19ce
  02dcb  mov bx, 0
  02dce  jne 0x2dd1
  02dd0  dec bx
L2DD1:
  02dd1  and bx, dx
  02dd3  and bx, bx
  02dd5  jne 0x2dda
  02dd7  jmp 0x2de8
L2DDA:
  02dda  mov bx, 0x19c0  ; " They're Old."
  02ddd  mov dx, 0xed2
  02de0  lcall 0x7d6, 0xf62
  02de5  jmp 0x1bd7
L2DE8:
  02de8  mov di, 0x1050
  02deb  mov si, 0xf1a
  02dee  lcall 0x7d6, 0x19ce
  02df3  mov bx, 0
  02df6  jne 0x2df9
  02df8  dec bx
L2DF9:
  02df9  mov di, 0x135a
  02dfc  lcall 0x7d6, 0x19ce
  02e01  mov dx, 0
  02e04  jne 0x2e07
  02e06  dec dx
L2E07:
  02e07  or dx, bx
  02e09  and dx, dx
  02e0b  jne 0x2e10
  02e0d  jmp 0x2e1e
L2E10:
  02e10  mov bx, 0x19d2  ; " It's Old."
  02e13  mov dx, 0xed2
  02e16  lcall 0x7d6, 0xf62
  02e1b  jmp 0x1bd7
L2E1E:
  02e1e  mov di, 0x1994
  02e21  mov si, 0xf1a
  02e24  lcall 0x7d6, 0x19ce
  02e29  je 0x2e2e
  02e2b  jmp 0x2e3c
L2E2E:
  02e2e  mov bx, 0x19e0  ; " It's Red."
  02e31  mov dx, 0xed2
  02e34  lcall 0x7d6, 0xf62
  02e39  jmp 0x1bd7
L2E3C:
  02e3c  mov di, 0x19aa
  02e3f  mov si, 0xf1a
  02e42  lcall 0x7d6, 0x19ce
  02e47  je 0x2e4c  ; '     ║                                                              ║'
  02e49  jmp 0x2e5a
L2E4C:
  02e4c  mov bx, 0x19ee  ; " It's Blue."
  02e4f  mov dx, 0xed2
  02e52  lcall 0x7d6, 0xf62
  02e57  jmp 0x1bd7
L2E5A:
  02e5a  mov di, 0x19fe
  02e5d  mov si, 0xf1a
  02e60  lcall 0x7d6, 0x19ce
  02e65  je 0x2e6a
  02e67  jmp 0x2e78
L2E6A:
  02e6a  mov bx, 0x1a02  ; " It's Purple."
  02e6d  mov dx, 0xed2
  02e70  lcall 0x7d6, 0xf62
  02e75  jmp 0x1bd7
L2E78:
  02e78  mov di, 0x148e
  02e7b  mov si, 0xf1a
  02e7e  lcall 0x7d6, 0x19ce
  02e83  je 0x2e88
  02e85  jmp 0x2e96  ; '     ║                      CASTLE ADVENTURE                        ║'
L2E88:
  02e88  mov bx, 0x1a14  ; " It's Yellow."
  02e8b  mov dx, 0xed2
  02e8e  lcall 0x7d6, 0xf62
  02e93  jmp 0x1bd7
L2E96:
  02e96  mov di, 0xfb2
  02e99  mov si, 0x11d6
  02e9c  lcall 0x7d6, 0x10a6
  02ea1  mov bx, 0x18d8  ; " I don't see"
  02ea4  mov dx, 0xed2
  02ea7  lcall 0x7d6, 0xf62
  02eac  mov bx, 0x154a  ; 'BEDS'
  02eaf  mov ax, 0xfe2
  02eb2  lcall 0x7d6, 0xfd2
  02eb7  je 0x2ebc
  02eb9  jmp 0x2eca
L2EBC:
  02ebc  mov bx, 0x1a26  ; ' any Beds.'
  02ebf  mov dx, 0xed6
  02ec2  lcall 0x7d6, 0xf62
  02ec7  jmp 0x2ed5
L2ECA:
  02eca  mov bx, 0x1a34  ; ' a Bed.'
  02ecd  mov dx, 0xed6
  02ed0  lcall 0x7d6, 0xf62
L2ED5:
  02ed5  jmp 0x1bd7
L2ED8:
  02ed8  mov di, 0x1a40
  02edb  mov si, 0xf1a
  02ede  lcall 0x7d6, 0x19ce
  02ee3  mov bx, 0
  02ee6  je 0x2ee9
  02ee8  dec bx
L2EE9:
  02ee9  mov di, 0x1a44
  02eec  mov si, 0xc36
  02eef  lcall 0x7d6, 0x19ce
  02ef4  mov dx, 0
  02ef7  je 0x2efa
  02ef9  dec dx
L2EFA:
  02efa  or dx, bx
  02efc  and dx, dx
  02efe  je 0x2f03
  02f00  jmp 0x2f55
L2F03:
  02f03  mov di, 0x1a44
  02f06  mov si, 0xc36
  02f09  lcall 0x7d6, 0x19ce
  02f0e  je 0x2f13
  02f10  jmp 0x2f55
L2F13:
  02f13  mov di, 0xfb2
  02f16  mov si, 0x11d6
  02f19  lcall 0x7d6, 0x10a6
  02f1e  mov bx, 0x1a48  ; "There's a book"
  02f21  mov dx, 0xed2
  02f24  lcall 0x7d6, 0xf62
  02f29  mov bx, 0x1552  ; 'SHELF'
  02f2c  mov ax, 0xfe2
  02f2f  lcall 0x7d6, 0xfd2
  02f34  je 0x2f39
  02f36  jmp 0x2f47
L2F39:
  02f39  mov bx, 0x1a5a  ; 'on it.'
  02f3c  mov dx, 0xed6
  02f3f  lcall 0x7d6, 0xf62
  02f44  jmp 0x1bd7
L2F47:
  02f47  mov bx, 0x1a64  ; 'on one.'
  02f4a  mov dx, 0xed6
  02f4d  lcall 0x7d6, 0xf62
  02f52  jmp 0x1bd7
L2F55:
  02f55  mov di, 0x1a40
  02f58  mov si, 0xf1a
  02f5b  lcall 0x7d6, 0x19ce
  02f60  mov bx, 0
  02f63  jne 0x2f66
  02f65  dec bx
L2F66:
  02f66  mov di, 0x10a0
  02f69  lcall 0x7d6, 0x19ce
  02f6e  mov dx, 0
  02f71  jne 0x2f74  ; '     ║  in modified form, that no fee or consideration  is  charged ║'
  02f73  dec dx
L2F74:
  02f74  or dx, bx
  02f76  mov di, 0x1a70
  02f79  lcall 0x7d6, 0x19ce
  02f7e  mov bx, 0
  02f81  jne 0x2f84
  02f83  dec bx
L2F84:
  02f84  or bx, dx
  02f86  and bx, bx
  02f88  jne 0x2f8d
  02f8a  jmp 0x2fb1
L2F8D:
  02f8d  mov di, 0xfb2
  02f90  mov si, 0x11d6
  02f93  lcall 0x7d6, 0x10a6
  02f98  mov bx, 0x1a74  ; " They're made"
  02f9b  mov dx, 0xed2
  02f9e  lcall 0x7d6, 0xf62
  02fa3  mov bx, 0x1a86  ; ' of wood.'
  02fa6  mov dx, 0xed6
  02fa9  lcall 0x7d6, 0xf62
  02fae  jmp 0x1bd7
L2FB1:
  02fb1  mov di, 0xfb2
  02fb4  mov si, 0x1040
  02fb7  lcall 0x7d6, 0x10a6
  02fbc  mov bx, 0x18d8  ; " I don't see"
  02fbf  mov dx, 0xed2
  02fc2  lcall 0x7d6, 0xf62
  02fc7  mov bx, 0x1552  ; 'SHELF'
  02fca  mov ax, 0xfe2
  02fcd  lcall 0x7d6, 0xfd2
  02fd2  je 0x2fd7
  02fd4  jmp 0x2fe5
L2FD7:
  02fd7  mov bx, 0x1a94  ; ' one.'
  02fda  mov dx, 0xed6
  02fdd  lcall 0x7d6, 0xf62
  02fe2  jmp 0x2ff0
L2FE5:
  02fe5  mov bx, 0x1a9e  ; ' any.'
  02fe8  mov dx, 0xed6
  02feb  lcall 0x7d6, 0xf62
L2FF0:
  02ff0  jmp 0x1bd7
L2FF3:
  02ff3  mov si, 0xf8a
  02ff6  lcall 0x7d6, 0x227f
  02ffb  xchg bx, ax
  02ffc  mov bx, 0x54
  02fff  imul bx
  03001  add ax, 0x8c2
  03004  xchg bx, ax
  03005  mov dx, 0x11b2  ; 'U'
  03008  mov cx, bx
  0300a  lcall 0x7d6, 0x245e
  0300f  lcall 0x7d6, 0x2237
  03014  mov di, 0xffa
  03017  lcall 0x7d6, 0x10a3
  0301c  mov bx, cx
  0301e  mov dx, 0x11b8  ; 'D'
  03021  lcall 0x7d6, 0x245e
  03026  lcall 0x7d6, 0x2237
  0302b  mov di, 0x100a
  0302e  lcall 0x7d6, 0x10a3
  03033  mov si, 0xffa
  03036  lcall 0x7d6, 0x26aa
  0303b  mov bx, 0
  0303e  jbe 0x3041
  03040  dec bx
L3041:
  03041  mov si, 0x100a
  03044  lcall 0x7d6, 0x26aa
  03049  mov dx, 0
  0304c  jne 0x304f
  0304e  dec dx
L304F:
  0304f  and dx, bx
  03051  and dx, dx
  03053  jne 0x3058
  03055  jmp 0x307c
L3058:
  03058  mov di, 0xfb2
  0305b  mov si, 0x11d6
  0305e  lcall 0x7d6, 0x10a6
  03063  mov bx, 0x1aa8  ; ' The Staircase'
  03066  mov dx, 0xed2
  03069  lcall 0x7d6, 0xf62
  0306e  mov bx, 0x1aba  ; ' leads up.'
  03071  mov dx, 0xed6
  03074  lcall 0x7d6, 0xf62
  03079  jmp 0x1bd7
L307C:
  0307c  mov si, 0x100a
  0307f  lcall 0x7d6, 0x26aa
  03084  mov bx, 0
  03087  jbe 0x308a
  03089  dec bx
L308A:
  0308a  mov si, 0xffa
  0308d  lcall 0x7d6, 0x26aa
  03092  mov dx, 0
  03095  jne 0x3098
  03097  dec dx
L3098:
  03098  and dx, bx
  0309a  and dx, dx
  0309c  jne 0x30a1
  0309e  jmp 0x30c5
L30A1:
  030a1  mov di, 0xfb2
  030a4  mov si, 0x11d6
  030a7  lcall 0x7d6, 0x10a6
  030ac  mov bx, 0x1aa8  ; ' The Staircase'
  030af  mov dx, 0xed2
  030b2  lcall 0x7d6, 0xf62
  030b7  mov bx, 0x1ac8  ; ' leads down.'
  030ba  mov dx, 0xed6
  030bd  lcall 0x7d6, 0xf62
  030c2  jmp 0x1bd7
L30C5:
  030c5  mov si, 0xffa
  030c8  lcall 0x7d6, 0x26aa
  030cd  mov bx, 0
  030d0  jbe 0x30d3
  030d2  dec bx
L30D3:
  030d3  mov si, 0x100a
  030d6  lcall 0x7d6, 0x26aa
  030db  mov dx, 0
  030de  jbe 0x30e1
  030e0  dec dx
L30E1:
  030e1  and dx, bx
  030e3  and dx, dx
  030e5  jne 0x30ea
  030e7  jmp 0x3119
L30EA:
  030ea  mov di, 0xfb2
  030ed  mov si, 0x10be
  030f0  lcall 0x7d6, 0x10a6
  030f5  mov bx, 0x1aa8  ; ' The Staircase'
  030f8  mov dx, 0xed2
  030fb  lcall 0x7d6, 0xf62
  03100  mov bx, 0x1ad8  ; ' leads both'
  03103  mov dx, 0xed6
  03106  lcall 0x7d6, 0xf62
  0310b  mov bx, 0x1ae8  ; ' up & Down.'
  0310e  mov dx, 0xeda
  03111  lcall 0x7d6, 0xf62
  03116  jmp 0x1bd7
L3119:
  03119  mov di, 0xfb2
  0311c  mov si, 0x11d6
  0311f  lcall 0x7d6, 0x10a6
  03124  mov bx, 0x18d8  ; " I don't see"
  03127  mov dx, 0xed2
  0312a  lcall 0x7d6, 0xf62
  0312f  mov bx, 0x1610  ; 'STAIRS'
  03132  mov ax, 0xfe2
  03135  lcall 0x7d6, 0xfd2
  0313a  je 0x313f
  0313c  jmp 0x314d
L313F:
  0313f  mov bx, 0x1af8  ; ' any stairs!'
  03142  mov dx, 0xed6
  03145  lcall 0x7d6, 0xf62
  0314a  jmp 0x3158
L314D:
  0314d  mov bx, 0x1b08  ; ' a staircase!'
  03150  mov dx, 0xed6
  03153  lcall 0x7d6, 0xf62
L3158:
  03158  jmp 0x1bd7
L315B:
  0315b  mov di, 0x114a
  0315e  mov si, 0xf1a
  03161  lcall 0x7d6, 0x19ce
  03166  jne 0x316b
  03168  jmp 0x318f
L316B:
  0316b  mov di, 0xfb2
  0316e  mov si, 0x11d6
  03171  lcall 0x7d6, 0x10a6
  03176  mov bx, 0x18d8  ; " I don't see"
  03179  mov dx, 0xed2
  0317c  lcall 0x7d6, 0xf62
  03181  mov bx, 0x1b1a  ; ' A throne!'
  03184  mov dx, 0xed6
  03187  lcall 0x7d6, 0xf62
  0318c  jmp 0x1bd7
L318F:
  0318f  mov di, 0xfb2
  03192  mov si, 0x11d6
  03195  lcall 0x7d6, 0x10a6
  0319a  mov bx, 0x1b28  ; ' The throne is'
  0319d  mov dx, 0xed2
  031a0  lcall 0x7d6, 0xf62
  031a5  mov bx, 0x1b3a  ; ' made of stone.'
  031a8  mov dx, 0xed6
  031ab  lcall 0x7d6, 0xf62
  031b0  jmp 0x1bd7
L31B3:
  031b3  mov di, 0x1074
  031b6  mov si, 0xf1a
  031b9  lcall 0x7d6, 0x19ce
  031be  jne 0x31c3
  031c0  jmp 0x31e7
L31C3:
  031c3  mov di, 0xfb2
  031c6  mov si, 0x11d6
  031c9  lcall 0x7d6, 0x10a6
  031ce  mov bx, 0x18d8  ; " I don't see"
  031d1  mov dx, 0xed2
  031d4  lcall 0x7d6, 0xf62
  031d9  mov bx, 0x1b4e  ; ' A fountain!'
  031dc  mov dx, 0xed6
  031df  lcall 0x7d6, 0xf62
  031e4  jmp 0x1bd7
L31E7:
  031e7  mov di, 0xfb2
  031ea  mov si, 0x1098
  031ed  lcall 0x7d6, 0x10a6
  031f2  mov bx, 0x1b5e  ; 'The fountain'
  031f5  mov dx, 0xed2
  031f8  lcall 0x7d6, 0xf62
  031fd  mov bx, 0x1b6e  ; 'is filled'
  03200  mov dx, 0xed6
  03203  lcall 0x7d6, 0xf62
  03208  mov bx, 0x1b7c  ; 'with water.But'
  0320b  mov dx, 0xeda
  0320e  lcall 0x7d6, 0xf62
  03213  mov bx, 0x1b8e  ; "you can't see"
  03216  mov dx, 0xede
  03219  lcall 0x7d6, 0xf62
  0321e  mov bx, 0x1ba0  ; 'In it.'
  03221  mov dx, 0xee2
  03224  lcall 0x7d6, 0xf62
  03229  jmp 0x1bd7
L322C:
  0322c  mov di, 0x1094
  0322f  mov si, 0xf1a
  03232  lcall 0x7d6, 0x19ce
  03237  jne 0x323c
  03239  jmp 0x3260
L323C:
  0323c  mov di, 0xfb2
  0323f  mov si, 0x11d6
  03242  lcall 0x7d6, 0x10a6
  03247  mov bx, 0x18d8  ; " I don't see"
  0324a  mov dx, 0xed2
  0324d  lcall 0x7d6, 0xf62
  03252  mov bx, 0x1baa  ; ' A Statue!'
  03255  mov dx, 0xed6
  03258  lcall 0x7d6, 0xf62
  0325d  jmp 0x1bd7
L3260:
  03260  mov di, 0x1bb8
  03263  mov si, 0xc32
  03266  lcall 0x7d6, 0x19ce
  0326b  je 0x3270
  0326d  jmp 0x329f
L3270:
  03270  mov di, 0xfb2
  03273  mov si, 0x10be
  03276  lcall 0x7d6, 0x10a6
  0327b  mov bx, 0x1bbc  ; ' The statue is'
  0327e  mov dx, 0xed2
  03281  lcall 0x7d6, 0xf62
  03286  mov bx, 0x1bce  ; ' wearing a'
  03289  mov dx, 0xed6
  0328c  lcall 0x7d6, 0xf62
  03291  mov bx, 0x1bdc  ; ' Necklace'
  03294  mov dx, 0xeda
  03297  lcall 0x7d6, 0xf62
  0329c  jmp 0x1bd7
L329F:
  0329f  mov di, 0xfb2
  032a2  mov si, 0x10be
  032a5  lcall 0x7d6, 0x10a6
  032aa  mov bx, 0x1bea  ; ' The Statue'
  032ad  mov dx, 0xed2
  032b0  lcall 0x7d6, 0xf62
  032b5  mov bx, 0x1bfa  ; ' looks like'
  032b8  mov dx, 0xed6
  032bb  lcall 0x7d6, 0xf62
  032c0  mov bx, 0x1c0a  ; ' The King!'
  032c3  mov dx, 0xeda
  032c6  lcall 0x7d6, 0xf62
  032cb  jmp 0x1bd7
L32CE:
  032ce  mov di, 0x135a
  032d1  mov si, 0xf1a
  032d4  lcall 0x7d6, 0x19ce
  032d9  jne 0x32de
  032db  jmp 0x3302
L32DE:
  032de  mov di, 0xfb2
  032e1  mov si, 0x11d6
  032e4  lcall 0x7d6, 0x10a6
  032e9  mov bx, 0x18d8  ; " I don't see"
  032ec  mov dx, 0xed2
  032ef  lcall 0x7d6, 0xf62
  032f4  mov bx, 0x1c18  ; ' A Mirror!'
  032f7  mov dx, 0xed6
  032fa  lcall 0x7d6, 0xf62
  032ff  jmp 0x1bd7
L3302:
  03302  mov di, 0xfb2
  03305  mov si, 0x11d6
  03308  lcall 0x7d6, 0x10a6
  0330d  mov bx, 0x1646  ; ' It looks'
  03310  mov dx, 0xed2
  03313  lcall 0x7d6, 0xf62
  03318  mov bx, 0x1788  ; ' Magical!'
  0331b  mov dx, 0xed6
  0331e  lcall 0x7d6, 0xf62
  03323  jmp 0x1bd7
L3326:
  03326  mov di, 0x1126
  03329  mov si, 0xf1a
  0332c  lcall 0x7d6, 0x19ce
  03331  jne 0x3336
  03333  jmp 0x3378
L3336:
  03336  mov di, 0xfb2
  03339  mov si, 0x11d6
  0333c  lcall 0x7d6, 0x10a6
  03341  mov bx, 0x18d8  ; " I don't see"
  03344  mov dx, 0xed2
  03347  lcall 0x7d6, 0xf62
  0334c  mov bx, 0x1592  ; 'BARRELS'
  0334f  mov ax, 0xfe2
  03352  lcall 0x7d6, 0xfd2
  03357  je 0x335c
  03359  jmp 0x336a
L335C:
  0335c  mov bx, 0x1c26  ; ' any Barrels!'
  0335f  mov dx, 0xed6
  03362  lcall 0x7d6, 0xf62
  03367  jmp 0x3375
L336A:
  0336a  mov bx, 0x1c38  ; ' a Barrel!'
  0336d  mov dx, 0xed6
  03370  lcall 0x7d6, 0xf62
L3375:
  03375  jmp 0x1bd7
L3378:
  03378  mov di, 0xfb2
  0337b  mov si, 0x11d6
  0337e  lcall 0x7d6, 0x10a6
  03383  mov bx, 0x1c46  ; ' Old!'
  03386  mov dx, 0xed6
  03389  lcall 0x7d6, 0xf62
  0338e  mov bx, 0x1592  ; 'BARRELS'
  03391  mov ax, 0xfe2
  03394  lcall 0x7d6, 0xfd2
  03399  je 0x339e
  0339b  jmp 0x33ac
L339E:
  0339e  mov bx, 0x1898  ; ' They look'
  033a1  mov dx, 0xed2
  033a4  lcall 0x7d6, 0xf62
  033a9  jmp 0x33b7
L33AC:
  033ac  mov bx, 0x1646  ; ' It looks'
  033af  mov dx, 0xed2
  033b2  lcall 0x7d6, 0xf62
L33B7:
  033b7  jmp 0x1bd7
L33BA:
  033ba  mov di, 0x18b2
  033bd  mov si, 0xf1a
  033c0  lcall 0x7d6, 0x19ce
  033c5  jne 0x33ca
  033c7  jmp 0x340c
L33CA:
  033ca  mov di, 0xfb2
  033cd  mov si, 0x11d6
  033d0  lcall 0x7d6, 0x10a6
  033d5  mov bx, 0x18d8  ; " I don't see"
  033d8  mov dx, 0xed2
  033db  lcall 0x7d6, 0xf62
  033e0  mov bx, 0x15a8  ; 'CHAINS'
  033e3  mov ax, 0xfe2
  033e6  lcall 0x7d6, 0xfd2
  033eb  je 0x33f0
  033ed  jmp 0x33fe
L33F0:
  033f0  mov bx, 0x1c50  ; ' any Chains!'
  033f3  mov dx, 0xed6
  033f6  lcall 0x7d6, 0xf62
  033fb  jmp 0x3409
L33FE:
  033fe  mov bx, 0x1c60  ; ' a Chain!'
  03401  mov dx, 0xed6
  03404  lcall 0x7d6, 0xf62
L3409:
  03409  jmp 0x1bd7
L340C:
  0340c  mov di, 0xfb2
  0340f  mov si, 0x11d6
  03412  lcall 0x7d6, 0x10a6
  03417  mov bx, 0x1788  ; ' Magical!'
  0341a  mov dx, 0xed6
  0341d  lcall 0x7d6, 0xf62
  03422  mov bx, 0x15a8  ; 'CHAINS'
  03425  mov ax, 0xfe2
  03428  lcall 0x7d6, 0xfd2
  0342d  je 0x3432
  0342f  jmp 0x3440
L3432:
  03432  mov bx, 0x1898  ; ' They look'
  03435  mov dx, 0xed2
  03438  lcall 0x7d6, 0xf62
  0343d  jmp 0x344b
L3440:
  03440  mov bx, 0x1646  ; ' It looks'
  03443  mov dx, 0xed2
  03446  lcall 0x7d6, 0xf62
L344B:
  0344b  jmp 0x1bd7
L344E:
  0344e  mov di, 0x1c6e
  03451  mov si, 0xf1a
  03454  lcall 0x7d6, 0x19ce
  03459  je 0x345e
  0345b  jmp 0x348d
L345E:
  0345e  mov di, 0xfb2
  03461  mov si, 0x10be
  03464  lcall 0x7d6, 0x10a6
  03469  mov bx, 0x1c72  ; 'The Wall Says:'
  0346c  mov dx, 0xed2
  0346f  lcall 0x7d6, 0xf62
  03474  mov bx, 0x1c84  ; 'Kevin Bales'
  03477  mov dx, 0xed6
  0347a  lcall 0x7d6, 0xf62
  0347f  mov bx, 0x1c94  ; 'was Here!'
  03482  mov dx, 0xeda
  03485  lcall 0x7d6, 0xf62
  0348a  jmp 0x1bd7
L348D:
  0348d  mov di, 0x111a
  03490  mov si, 0xf1a
  03493  lcall 0x7d6, 0x19ce
  03498  je 0x349d
  0349a  jmp 0x34c1
L349D:
  0349d  mov di, 0xfb2
  034a0  mov si, 0x11d6
  034a3  lcall 0x7d6, 0x10a6
  034a8  mov bx, 0x1ca2  ; 'The walls are'
  034ab  mov dx, 0xed2
  034ae  lcall 0x7d6, 0xf62
  034b3  mov bx, 0x1cb4  ; 'many Colors!'
  034b6  mov dx, 0xed6
  034b9  lcall 0x7d6, 0xf62
  034be  jmp 0x1bd7
L34C1:
  034c1  mov di, 0x1040
  034c4  mov si, 0xf1a
  034c7  lcall 0x7d6, 0x19ce
  034cc  je 0x34d1
  034ce  jmp 0x34f9
L34D1:
  034d1  mov bx, 0x15bc  ; 'WALL'
  034d4  mov ax, 0xfe2
  034d7  lcall 0x7d6, 0xfd2
  034dc  mov dx, 0
  034df  jne 0x34e2
  034e1  dec dx
L34E2:
  034e2  mov bx, 0x15b2  ; 'WALLS'
  034e5  lcall 0x7d6, 0xfd2
  034ea  mov cx, 0
  034ed  jne 0x34f0
  034ef  dec cx
L34F0:
  034f0  or cx, dx
  034f2  and cx, cx
  034f4  je 0x34f9
  034f6  jmp 0x5f75
L34F9:
  034f9  mov bx, 0x15b2  ; 'WALLS'
  034fc  mov ax, 0xfe2
  034ff  lcall 0x7d6, 0xfd2
  03504  je 0x3509
  03506  jmp 0x3512
L3509:
  03509  xchg dx, ax
  0350a  mov bx, 0x15bc  ; 'WALL'
  0350d  lcall 0x7d6, 0xf62
L3512:
  03512  mov bx, 0x15ee  ; 'ARCHWAYS'
  03515  mov ax, 0xfe2
  03518  lcall 0x7d6, 0xfd2
  0351d  je 0x3522
  0351f  jmp 0x352b
L3522:
  03522  xchg dx, ax
  03523  mov bx, 0x15e2  ; 'ARCHWAY'
  03526  lcall 0x7d6, 0xf62
L352B:
  0352b  mov di, 0xfb2
  0352e  mov si, 0x10be
  03531  lcall 0x7d6, 0x10a6
  03536  mov bx, 0xfe2
  03539  mov ax, 0x1492  ; 'The '
  0353c  lcall 0x7d6, 0xf98
  03541  xchg bx, ax
  03542  mov bx, 0x11a0  ; 'S'
  03545  lcall 0x7d6, 0xf98
  0354a  mov dx, 0xed2
  0354d  lcall 0x7d6, 0xf62
  03552  mov bx, 0x1cc4  ; 'are made of'
  03555  mov dx, 0xed6
  03558  lcall 0x7d6, 0xf62
  0355d  mov bx, 0x1cd4  ; 'Gray Stone.'
  03560  mov dx, 0xeda
  03563  lcall 0x7d6, 0xf62
  03568  jmp 0x1bd7
L356B:
  0356b  mov di, 0x1ce4
  0356e  mov si, 0xf1a
  03571  lcall 0x7d6, 0x19ce
  03576  jne 0x357b
  03578  jmp 0x359f
L357B:
  0357b  mov di, 0xfb2
  0357e  mov si, 0x11d6
  03581  lcall 0x7d6, 0x10a6
  03586  mov bx, 0x1ce8  ; " I Don't see"
  03589  mov dx, 0xed2
  0358c  lcall 0x7d6, 0xf62
  03591  mov bx, 0x1cf8  ; ' A Garden!'
  03594  mov dx, 0xed6
  03597  lcall 0x7d6, 0xf62
  0359c  jmp 0x1bd7
L359F:
  0359f  mov di, 0x1d06
  035a2  mov si, 0xc72
  035a5  lcall 0x7d6, 0x19ce
  035aa  jne 0x35af
  035ac  jmp 0x35de
L35AF:
  035af  mov di, 0xfb2
  035b2  mov si, 0x10be
  035b5  lcall 0x7d6, 0x10a6
  035ba  mov bx, 0x1d0a  ; 'The Garden'
  035bd  mov dx, 0xed2
  035c0  lcall 0x7d6, 0xf62
  035c5  mov bx, 0x1d18  ; 'Has A Fountain'
  035c8  mov dx, 0xed6
  035cb  lcall 0x7d6, 0xf62
  035d0  mov bx, 0x1d2a  ; 'in the middle.'
  035d3  mov dx, 0xeda
  035d6  lcall 0x7d6, 0xf62
  035db  jmp 0x1bd7
L35DE:
  035de  mov di, 0xfb2
  035e1  mov si, 0x1090
  035e4  lcall 0x7d6, 0x10a6
  035e9  mov bx, 0x18fa  ; ' There is a'
  035ec  mov dx, 0xed2
  035ef  lcall 0x7d6, 0xf62
  035f4  mov bx, 0x1d3c  ; ' BIG Gem in '
  035f7  mov dx, 0xed6
  035fa  lcall 0x7d6, 0xf62
  035ff  mov bx, 0x1d4c  ; ' the Garden'
  03602  mov dx, 0xeda
  03605  lcall 0x7d6, 0xf62
  0360a  mov bx, 0x1d5c  ; ' Fountain!'
  0360d  mov dx, 0xede
  03610  lcall 0x7d6, 0xf62
  03615  jmp 0x1bd7
L3618:
  03618  mov di, 0x1ce4
  0361b  mov si, 0xf1a
  0361e  lcall 0x7d6, 0x19ce
  03623  jne 0x3628
  03625  jmp 0x364c
L3628:
  03628  mov di, 0xfb2
  0362b  mov si, 0x11d6
  0362e  lcall 0x7d6, 0x10a6
  03633  mov bx, 0x1d6a  ; "I don't see"
  03636  mov dx, 0xed2
  03639  lcall 0x7d6, 0xf62
  0363e  mov bx, 0x1d7a  ; 'a Balcony!'
  03641  mov dx, 0xed6
  03644  lcall 0x7d6, 0xf62
  03649  jmp 0x1bd7
L364C:
  0364c  mov di, 0xfb2
  0364f  mov si, 0x11d6
  03652  lcall 0x7d6, 0x10a6
  03657  mov bx, 0x1d88  ; 'The balcony is'
  0365a  mov dx, 0xed2
  0365d  lcall 0x7d6, 0xf62
  03662  mov bx, 0x1d9a  ; 'made of stone.'
  03665  mov dx, 0xed6
  03668  lcall 0x7d6, 0xf62
  0366d  jmp 0x1bd7
L3670:
  03670  mov si, 0x1040
  03673  lcall 0x7d6, 0x10bd
  03678  jmp 0x3726
L367B:
  0367b  mov si, 0xf32
  0367e  lcall 0x7d6, 0x227f
  03683  shl bx, 1
  03685  shl bx, 1
  03687  add bx, 0xc82
  0368b  mov dx, 0xfd6
  0368e  lcall 0x7d6, 0xf62
  03693  mov bx, 0x20
  03696  lcall 0x7d6, 0x23be
  0369b  xchg bx, dx
  0369d  mov cx, bx
  0369f  lcall 0x7d6, 0x245e
  036a4  lcall 0x7d6, 0x2237
  036a9  mov di, 0xfb2
  036ac  lcall 0x7d6, 0x10a3
  036b1  mov si, di
  036b3  lcall 0x7d6, 0x26aa
  036b8  ja 0x36bd
  036ba  jmp 0x36e4
L36BD:
  036bd  mov bx, cx
  036bf  lcall 0x7d6, 0x2386
  036c4  lcall 0x7d6, 0x2237
  036c9  lcall 0x7d6, 0x1752
  036ce  lcall 0x7d6, 0x22ca
  036d3  mov ax, bx
  036d5  mov bx, cx
  036d7  xchg dx, ax
  036d8  lcall 0x7d6, 0x2478  ; 'You pour the'
  036dd  mov dx, cx
  036df  lcall 0x7d6, 0xf62
L36E4:
  036e4  mov bx, 0xfd6
  036e7  mov ax, 0xfe2
  036ea  lcall 0x7d6, 0xfd2
  036ef  mov dx, 0
  036f2  jne 0x36f5
  036f4  dec dx
L36F5:
  036f5  mov si, 0xf32
  036f8  lcall 0x7d6, 0x227f
  036fd  mov si, bx
  036ff  shl si, 1
  03701  shl si, 1
  03703  add si, 0xc26
  03707  lcall 0x7d6, 0x26aa
  0370c  mov bx, 0
  0370f  jne 0x3712
  03711  dec bx
L3712:
  03712  and bx, dx
  03714  and bx, bx
  03716  je 0x371b
  03718  jmp 0x3769
L371B:
  0371b  mov di, 0x1040
  0371e  mov si, 0xf32
  03721  lcall 0x7d6, 0x1772
L3726:
  03726  mov di, 0xf32
  03729  lcall 0x7d6, 0x10a3
  0372e  mov si, di
  03730  mov di, 0x104c
  03733  lcall 0x7d6, 0x19ce
  03738  ja 0x373d
  0373a  jmp 0x367b
L373D:
  0373d  mov di, 0xfb2
  03740  mov si, 0x11d6
  03743  lcall 0x7d6, 0x10a6
  03748  mov bx, 0x1dac  ; "You don't have"
  0374b  mov dx, 0xed2
  0374e  lcall 0x7d6, 0xf62
  03753  mov bx, 0xfe2
  03756  mov ax, 0x167e  ; 'a '
  03759  lcall 0x7d6, 0xf98
  0375e  mov dx, 0xed6
  03761  lcall 0x7d6, 0xf62
  03766  jmp 0x1bd7
L3769:
  03769  mov di, 0xfc2
  0376c  mov si, 0xf22
  0376f  lcall 0x7d6, 0x1772
  03774  lcall 0x7d6, 0x22ca
  03779  mov di, 0xfbe
  0377c  mov si, 0xf1e
  0377f  lcall 0x7d6, 0x1772
  03784  mov dx, bx
  03786  lcall 0x7d6, 0x22ca
  0378b  mov cx, 0x7fff
  0378e  lcall 0x7d6, 0xb3b
  03793  lcall 0x7d6, 0x2237
  03798  mov di, 0xffa
  0379b  lcall 0x7d6, 0x10a3
  037a0  mov si, di
  037a2  mov di, 0x10ca
  037a5  lcall 0x7d6, 0x19ce
  037aa  je 0x37af
  037ac  jmp 0x38b1
L37AF:
  037af  mov di, 0xfbe
  037b2  mov si, 0xf1e
  037b5  lcall 0x7d6, 0x1772
  037ba  mov di, 0x1040
  037bd  lcall 0x7d6, 0x19c3
  037c2  mov bx, 0
  037c5  jae 0x37c8
  037c7  dec bx
L37C8:
  037c8  mov dx, di
  037ca  mov di, 0xfc2
  037cd  mov si, 0xf22
  037d0  lcall 0x7d6, 0x1772
  037d5  mov di, dx
  037d7  lcall 0x7d6, 0x19c3
  037dc  mov cx, 0
  037df  jae 0x37e2
  037e1  dec cx
L37E2:
  037e2  or cx, bx
  037e4  and cx, cx
  037e6  je 0x37eb
  037e8  jmp 0x38b1
L37EB:
  037eb  mov di, 0x1062
  037ee  mov si, 0xfea
  037f1  lcall 0x7d6, 0x1772
  037f6  mov di, si
  037f8  lcall 0x7d6, 0x10a3
  037fd  mov si, 0xf32
  03800  lcall 0x7d6, 0x227f
  03805  mov di, bx
  03807  shl di, 1
  03809  shl di, 1
  0380b  mov bx, di
  0380d  add di, 0xc26
  03811  mov si, 0xf1a
  03814  lcall 0x7d6, 0x10a6
  03819  mov dx, bx
  0381b  add bx, 0xcde
  0381f  mov di, bx
  03821  mov di, 0xfbe
  03824  mov si, 0xf1e
  03827  lcall 0x7d6, 0x1772
  0382c  mov di, bx
  0382e  lcall 0x7d6, 0x10a3
  03833  mov bx, dx
  03835  add dx, 0xd3a
  03839  mov di, dx
  0383b  mov di, 0xfc2
  0383e  mov si, 0xf22
  03841  lcall 0x7d6, 0x1772
  03846  mov di, dx
  03848  lcall 0x7d6, 0x10a3
  0384d  mov dx, bx
  0384f  add bx, 0xcde
  03853  mov si, bx
  03855  lcall 0x7d6, 0x227f
  0385a  lcall 0x7d6, 0xffd
  0385f  mov bx, dx
  03861  add dx, 0xd3a
  03865  mov si, dx
  03867  mov cx, bx
  03869  lcall 0x7d6, 0x227f
  0386e  lcall 0x7d6, 0x1017
  03873  lcall 0x7d6, 0x3021
  03878  add cx, 0xe46
  0387c  mov si, cx
  0387e  lcall 0x7d6, 0x227f
  03883  lcall 0x7d6, 0x23be
  03888  lcall 0x7d6, 0x2d79
  0388d  mov bx, 0x96
  03890  mov dx, 0x1040
  03893  lcall 0x7d6, 0x635
  03898  mov di, 0xfb2
  0389b  mov si, 0x1040
  0389e  lcall 0x7d6, 0x10a6
  038a3  mov bx, 0x1dbe  ; ' Done.'
  038a6  mov dx, 0xed2
  038a9  lcall 0x7d6, 0xf62
  038ae  jmp 0x1bd7
L38B1:
  038b1  mov di, 0xfb2
  038b4  mov si, 0x11d6
  038b7  lcall 0x7d6, 0x10a6
  038bc  mov bx, 0x1dc8  ; ' Something is'
  038bf  mov dx, 0xed2
  038c2  lcall 0x7d6, 0xf62
  038c7  mov bx, 0x1dda  ; ' in the way!'
  038ca  mov dx, 0xed6
  038cd  lcall 0x7d6, 0xf62
  038d2  jmp 0x1bd7
L38D5:
  038d5  mov bx, 0x1dea  ; 'BLOOD'
  038d8  mov ax, 0xfe2
  038db  lcall 0x7d6, 0xfd2
  038e0  je 0x38e5
  038e2  jmp 0x38fe
L38E5:
  038e5  mov di, 0xfb2
  038e8  mov si, 0x1040
  038eb  lcall 0x7d6, 0x10a6
  038f0  mov bx, 0x1df4  ; 'Yuc!!'
  038f3  mov dx, 0xed2
  038f6  lcall 0x7d6, 0xf62
  038fb  jmp 0x1bd7
L38FE:
  038fe  mov si, 0x1040
  03901  lcall 0x7d6, 0x10bd
  03906  jmp 0x398d
L3909:
  03909  mov si, 0xf32
  0390c  lcall 0x7d6, 0x227f
  03911  shl bx, 1
  03913  shl bx, 1
  03915  add bx, 0xc82
  03919  mov dx, 0xfd6
  0391c  lcall 0x7d6, 0xf62
  03921  mov bx, 0x20
  03924  lcall 0x7d6, 0x23be
  03929  xchg bx, dx
  0392b  mov cx, bx
  0392d  lcall 0x7d6, 0x245e
  03932  lcall 0x7d6, 0x2237
  03937  mov di, 0xfb2
  0393a  lcall 0x7d6, 0x10a3
  0393f  mov si, di
  03941  lcall 0x7d6, 0x26aa
  03946  ja 0x394b
  03948  jmp 0x3972
L394B:
  0394b  mov bx, cx
  0394d  lcall 0x7d6, 0x2386
  03952  lcall 0x7d6, 0x2237
  03957  lcall 0x7d6, 0x1752
  0395c  lcall 0x7d6, 0x22ca
  03961  mov ax, bx
  03963  mov bx, cx
  03965  xchg dx, ax
  03966  lcall 0x7d6, 0x2478  ; 'You pour the'
  0396b  mov dx, cx
  0396d  lcall 0x7d6, 0xf62
L3972:
  03972  mov bx, 0xfd6
  03975  mov ax, 0xfe2
  03978  lcall 0x7d6, 0xfd2
  0397d  jne 0x3982
  0397f  jmp 0x3f61
L3982:
  03982  mov di, 0x1040
  03985  mov si, 0xf32
  03988  lcall 0x7d6, 0x1772
L398D:
  0398d  mov di, 0xf32
  03990  lcall 0x7d6, 0x10a3
  03995  mov si, di
  03997  mov di, 0x104c
  0399a  lcall 0x7d6, 0x19ce
  0399f  ja 0x39a4
  039a1  jmp 0x3909
L39A4:
  039a4  mov bx, 0x1530  ; 'TABLE'
  039a7  mov ax, 0xfe2
  039aa  lcall 0x7d6, 0xfd2
  039af  mov dx, 0
  039b2  jne 0x39b5
  039b4  dec dx
L39B5:
  039b5  mov bx, 0x153a  ; 'DESK'
  039b8  lcall 0x7d6, 0xfd2
  039bd  mov cx, 0
  039c0  jne 0x39c3
  039c2  dec cx
L39C3:
  039c3  or cx, dx
  039c5  mov bx, 0x1542  ; 'BED'
  039c8  lcall 0x7d6, 0xfd2
  039cd  mov dx, 0
  039d0  jne 0x39d3
  039d2  dec dx
L39D3:
  039d3  or dx, cx
  039d5  mov bx, 0x1552  ; 'SHELF'
  039d8  lcall 0x7d6, 0xfd2
  039dd  mov cx, 0
  039e0  jne 0x39e3
  039e2  dec cx
L39E3:
  039e3  or cx, dx
  039e5  mov bx, 0x1568  ; 'THRONE'
  039e8  lcall 0x7d6, 0xfd2
  039ed  mov dx, 0
  039f0  jne 0x39f3
  039f2  dec dx
L39F3:
  039f3  or dx, cx
  039f5  mov bx, 0x1572  ; 'FOUNTAIN'
  039f8  lcall 0x7d6, 0xfd2
  039fd  mov cx, 0
  03a00  jne 0x3a03
  03a02  dec cx
L3A03:
  03a03  or cx, dx
  03a05  mov bx, 0x157e  ; 'STATUE'
  03a08  lcall 0x7d6, 0xfd2
  03a0d  mov dx, 0
  03a10  jne 0x3a13
  03a12  dec dx
L3A13:
  03a13  or dx, cx
  03a15  mov bx, 0x1588  ; 'BARREL'
  03a18  lcall 0x7d6, 0xfd2
  03a1d  mov cx, 0
  03a20  jne 0x3a23
  03a22  dec cx
L3A23:
  03a23  or cx, dx
  03a25  mov bx, 0x135e  ; 'MIRROR'
  03a28  lcall 0x7d6, 0xfd2
  03a2d  mov dx, 0
  03a30  jne 0x3a33
  03a32  dec dx
L3A33:
  03a33  or dx, cx
  03a35  mov bx, 0x154a  ; 'BEDS'
  03a38  lcall 0x7d6, 0xfd2
  03a3d  mov cx, 0
  03a40  jne 0x3a43
  03a42  dec cx
L3A43:
  03a43  or cx, dx
  03a45  mov bx, 0x155c  ; 'SHELVES'
  03a48  lcall 0x7d6, 0xfd2
  03a4d  mov dx, 0
  03a50  jne 0x3a53
  03a52  dec dx
L3A53:
  03a53  or dx, cx
  03a55  mov bx, 0x1592  ; 'BARRELS'
  03a58  lcall 0x7d6, 0xfd2
  03a5d  mov cx, 0
  03a60  jne 0x3a63
  03a62  dec cx
L3A63:
  03a63  or cx, dx
  03a65  and cx, cx
  03a67  je 0x3a6c
  03a69  jmp 0x3c13
L3A6C:
  03a6c  mov bx, 0x159e  ; 'CHAIN'
  03a6f  mov ax, 0xfe2
  03a72  lcall 0x7d6, 0xfd2
  03a77  mov dx, 0
  03a7a  jne 0x3a7d
  03a7c  dec dx
L3A7D:
  03a7d  mov bx, 0x15a8  ; 'CHAINS'
  03a80  lcall 0x7d6, 0xfd2
  03a85  mov cx, 0
  03a88  jne 0x3a8b
  03a8a  dec cx
L3A8B:
  03a8b  or cx, dx
  03a8d  and cx, cx
  03a8f  jne 0x3a94
  03a91  jmp 0x3ad3
L3A94:
  03a94  mov di, 0x18b2
  03a97  mov si, 0xf1a
  03a9a  lcall 0x7d6, 0x19ce
  03a9f  je 0x3aa4
  03aa1  jmp 0x3ad3
L3AA4:
  03aa4  mov di, 0xfb2
  03aa7  mov si, 0x10be
  03aaa  lcall 0x7d6, 0x10a6
  03aaf  mov bx, 0x17b4  ; " They're"
  03ab2  mov dx, 0xed2
  03ab5  lcall 0x7d6, 0xf62
  03aba  mov bx, 0x1dfe  ; ' Connected to'
  03abd  mov dx, 0xed6
  03ac0  lcall 0x7d6, 0xf62
  03ac5  mov bx, 0x1e10  ; ' the wall.'
  03ac8  mov dx, 0xeda
  03acb  lcall 0x7d6, 0xf62
  03ad0  jmp 0x1bd7
L3AD3:
  03ad3  mov bx, 0x1278  ; 'WINE'
  03ad6  mov ax, 0xfe2
  03ad9  lcall 0x7d6, 0xfd2
  03ade  mov dx, 0
  03ae1  jne 0x3ae4
  03ae3  dec dx
L3AE4:
  03ae4  mov bx, 0x1280  ; 'WATER'
  03ae7  lcall 0x7d6, 0xfd2
  03aec  mov cx, 0
  03aef  jne 0x3af2
  03af1  dec cx
L3AF2:
  03af2  or cx, dx
  03af4  and cx, cx
  03af6  je 0x3afb
  03af8  jmp 0x41c5
L3AFB:
  03afb  mov si, 0x1040
  03afe  lcall 0x7d6, 0x10bd
  03b03  jmp 0x3be3
L3B06:
  03b06  mov si, 0xf32
  03b09  lcall 0x7d6, 0x227f
  03b0e  shl bx, 1
  03b10  shl bx, 1
  03b12  add bx, 0xe1a
  03b16  mov dx, 0xfd6
  03b19  lcall 0x7d6, 0xf62
  03b1e  mov bx, 0x20
  03b21  lcall 0x7d6, 0x23be
  03b26  xchg bx, dx
  03b28  mov cx, bx
  03b2a  lcall 0x7d6, 0x245e
  03b2f  lcall 0x7d6, 0x2237
  03b34  mov di, 0xffa
  03b37  lcall 0x7d6, 0x10a3
  03b3c  mov si, di
  03b3e  lcall 0x7d6, 0x26aa
  03b43  ja 0x3b48
  03b45  jmp 0x3b6f
L3B48:
  03b48  mov bx, cx
  03b4a  lcall 0x7d6, 0x2386
  03b4f  lcall 0x7d6, 0x2237
  03b54  lcall 0x7d6, 0x1752
  03b59  lcall 0x7d6, 0x22ca
  03b5e  mov ax, bx
  03b60  mov bx, cx
  03b62  xchg dx, ax
  03b63  lcall 0x7d6, 0x2478  ; 'You pour the'
  03b68  mov dx, cx
  03b6a  lcall 0x7d6, 0xf62
L3B6F:
  03b6f  mov bx, 0xfe2
  03b72  mov ax, 0xfd6
  03b75  lcall 0x7d6, 0xfd2
  03b7a  mov dx, 0
  03b7d  jne 0x3b80
  03b7f  dec dx
L3B80:
  03b80  mov si, 0xf32
  03b83  lcall 0x7d6, 0x227f
  03b88  mov si, bx
  03b8a  shl si, 1
  03b8c  shl si, 1
  03b8e  add si, 0xd96
  03b92  mov di, 0xf1a
  03b95  lcall 0x7d6, 0x19ce
  03b9a  mov bx, 0
  03b9d  jne 0x3ba0
  03b9f  dec bx
L3BA0:
  03ba0  and bx, dx
  03ba2  and bx, bx
  03ba4  jne 0x3ba9
  03ba6  jmp 0x3bd8
L3BA9:
  03ba9  mov di, 0xfb2
  03bac  mov si, 0x10be
  03baf  lcall 0x7d6, 0x10a6
  03bb4  mov bx, 0x1e1e  ; "I don't think"
  03bb7  mov dx, 0xed2
  03bba  lcall 0x7d6, 0xf62
  03bbf  mov bx, 0x1e30  ; 'that would be'
  03bc2  mov dx, 0xed6
  03bc5  lcall 0x7d6, 0xf62
  03bca  mov bx, 0x1e42  ; 'very safe!'
  03bcd  mov dx, 0xeda
  03bd0  lcall 0x7d6, 0xf62
  03bd5  jmp 0x1bd7
L3BD8:
  03bd8  mov di, 0x1040
  03bdb  mov si, 0xf32
  03bde  lcall 0x7d6, 0x1772
L3BE3:
  03be3  mov di, 0xf32
  03be6  lcall 0x7d6, 0x10a3
  03beb  mov si, di
  03bed  mov di, 0x1050
  03bf0  lcall 0x7d6, 0x19ce
  03bf5  ja 0x3bfa
  03bf7  jmp 0x3b06
L3BFA:
  03bfa  mov di, 0xfb2
  03bfd  mov si, 0x1040
  03c00  lcall 0x7d6, 0x10a6
  03c05  mov bx, 0x1e50  ; 'Impossible!!'
  03c08  mov dx, 0xed2
  03c0b  lcall 0x7d6, 0xf62
  03c10  jmp 0x1bd7
L3C13:
  03c13  mov di, 0xfb2
  03c16  mov si, 0x11d6
  03c19  lcall 0x7d6, 0x10a6
  03c1e  mov bx, 0xfe2
  03c21  mov dx, 1
  03c24  mov cx, bx
  03c26  lcall 0x7d6, 0x2478  ; 'You pour the'
  03c2b  xchg bx, ax
  03c2c  mov bx, 0x11a0  ; 'S'
  03c2f  lcall 0x7d6, 0xfd2
  03c34  je 0x3c39
  03c36  jmp 0x3c46
L3C39:
  03c39  mov bx, cx
  03c3b  mov dx, 0xed2
  03c3e  lcall 0x7d6, 0xf62
  03c43  jmp 0x3c59
L3C46:
  03c46  mov bx, 0x11a0  ; 'S'
  03c49  mov ax, 0xfe2
  03c4c  lcall 0x7d6, 0xf98
  03c51  mov dx, 0xed2
  03c54  lcall 0x7d6, 0xf62
L3C59:
  03c59  mov bx, 0x1e60  ; 'are too heavy!'
  03c5c  mov dx, 0xed6
  03c5f  lcall 0x7d6, 0xf62
  03c64  mov bx, 0x1530  ; 'TABLE'
  03c67  mov ax, 0xfe2
  03c6a  lcall 0x7d6, 0xfd2
  03c6f  je 0x3c74
  03c71  jmp 0x3c9c
L3C74:
  03c74  mov di, 0x1066
  03c77  mov si, 0xf1a
  03c7a  lcall 0x7d6, 0x19ce
  03c7f  mov bx, 0
  03c82  jne 0x3c85
  03c84  dec bx
L3C85:
  03c85  mov di, 0x18b2
  03c88  lcall 0x7d6, 0x19ce
  03c8d  mov dx, 0
  03c90  jne 0x3c93
  03c92  dec dx
L3C93:
  03c93  or dx, bx
  03c95  and dx, dx
  03c97  je 0x3c9c
  03c99  jmp 0x1bd7
L3C9C:
  03c9c  mov bx, 0x153a  ; 'DESK'
  03c9f  mov ax, 0xfe2
  03ca2  lcall 0x7d6, 0xfd2
  03ca7  je 0x3cac
  03ca9  jmp 0x3ce4
L3CAC:
  03cac  mov di, 0x1050
  03caf  mov si, 0xf1a
  03cb2  lcall 0x7d6, 0x19ce
  03cb7  mov bx, 0
  03cba  jne 0x3cbd
  03cbc  dec bx
L3CBD:
  03cbd  mov di, 0x148e
  03cc0  lcall 0x7d6, 0x19ce
  03cc5  mov dx, 0
  03cc8  jne 0x3ccb
  03cca  dec dx
L3CCB:
  03ccb  or dx, bx
  03ccd  mov di, 0x1954
  03cd0  lcall 0x7d6, 0x19ce
  03cd5  mov bx, 0
  03cd8  jne 0x3cdb
  03cda  dec bx
L3CDB:
  03cdb  or bx, dx
  03cdd  and bx, bx
  03cdf  je 0x3ce4
  03ce1  jmp 0x1bd7
L3CE4:
  03ce4  mov bx, 0x1542  ; 'BED'
  03ce7  mov ax, 0xfe2
  03cea  lcall 0x7d6, 0xfd2
  03cef  mov dx, 0
  03cf2  jne 0x3cf5
  03cf4  dec dx
L3CF5:
  03cf5  mov bx, 0x154a  ; 'BEDS'
  03cf8  lcall 0x7d6, 0xfd2
  03cfd  mov cx, 0
  03d00  jne 0x3d03
  03d02  dec cx
L3D03:
  03d03  or cx, dx
  03d05  and cx, cx
  03d07  jne 0x3d0c
  03d09  jmp 0x3d74
L3D0C:
  03d0c  mov di, 0x1050
  03d0f  mov si, 0xf1a
  03d12  lcall 0x7d6, 0x19ce
  03d17  mov bx, 0
  03d1a  jne 0x3d1d
  03d1c  dec bx
L3D1D:
  03d1d  mov di, 0x1994
  03d20  lcall 0x7d6, 0x19ce
  03d25  mov dx, 0
  03d28  jne 0x3d2b
  03d2a  dec dx
L3D2B:
  03d2b  or dx, bx
  03d2d  mov di, 0x19aa
  03d30  lcall 0x7d6, 0x19ce
  03d35  mov bx, 0
  03d38  jne 0x3d3b
  03d3a  dec bx
L3D3B:
  03d3b  or bx, dx
  03d3d  mov di, 0x19fe
  03d40  lcall 0x7d6, 0x19ce
  03d45  mov dx, 0
  03d48  jne 0x3d4b
  03d4a  dec dx
L3D4B:
  03d4b  or dx, bx
  03d4d  mov di, 0x148e
  03d50  lcall 0x7d6, 0x19ce
  03d55  mov bx, 0
  03d58  jne 0x3d5b
  03d5a  dec bx
L3D5B:
  03d5b  or bx, dx
  03d5d  mov di, 0x135a
  03d60  lcall 0x7d6, 0x19ce
  03d65  mov dx, 0
  03d68  jne 0x3d6b
  03d6a  dec dx
L3D6B:
  03d6b  or dx, bx
  03d6d  and dx, dx
  03d6f  je 0x3d74
  03d71  jmp 0x1bd7
L3D74:
  03d74  mov bx, 0x1552  ; 'SHELF'
  03d77  mov ax, 0xfe2
  03d7a  lcall 0x7d6, 0xfd2
  03d7f  mov dx, 0
  03d82  jne 0x3d85
  03d84  dec dx
L3D85:
  03d85  mov bx, 0x155c  ; 'SHELVES'
  03d88  lcall 0x7d6, 0xfd2
  03d8d  mov cx, 0
  03d90  jne 0x3d93
  03d92  dec cx
L3D93:
  03d93  or cx, dx
  03d95  and cx, cx
  03d97  jne 0x3d9c
  03d99  jmp 0x3dd4
L3D9C:
  03d9c  mov di, 0x10a0
  03d9f  mov si, 0xf1a
  03da2  lcall 0x7d6, 0x19ce
  03da7  mov bx, 0
  03daa  jne 0x3dad
  03dac  dec bx
L3DAD:
  03dad  mov di, 0x1a40
  03db0  lcall 0x7d6, 0x19ce
  03db5  mov dx, 0
  03db8  jne 0x3dbb
  03dba  dec dx
L3DBB:
  03dbb  or dx, bx
  03dbd  mov di, 0x1a70
  03dc0  lcall 0x7d6, 0x19ce
  03dc5  mov bx, 0
  03dc8  jne 0x3dcb
  03dca  dec bx
L3DCB:
  03dcb  or bx, dx
  03dcd  and bx, bx
  03dcf  je 0x3dd4
  03dd1  jmp 0x1bd7
L3DD4:
  03dd4  mov bx, 0x1568  ; 'THRONE'
  03dd7  mov ax, 0xfe2
  03dda  lcall 0x7d6, 0xfd2
  03ddf  mov dx, 0
  03de2  jne 0x3de5
  03de4  dec dx
L3DE5:
  03de5  mov di, 0x114a
  03de8  mov si, 0xf1a
  03deb  lcall 0x7d6, 0x19ce
  03df0  mov bx, 0
  03df3  jne 0x3df6
  03df5  dec bx
L3DF6:
  03df6  and bx, dx
  03df8  and bx, bx
  03dfa  je 0x3dff
  03dfc  jmp 0x1bd7
L3DFF:
  03dff  mov bx, 0x1572  ; 'FOUNTAIN'
  03e02  mov ax, 0xfe2
  03e05  lcall 0x7d6, 0xfd2
  03e0a  mov dx, 0
  03e0d  jne 0x3e10
  03e0f  dec dx
L3E10:
  03e10  mov di, 0x1074
  03e13  mov si, 0xf1a
  03e16  lcall 0x7d6, 0x19ce
  03e1b  mov bx, 0
  03e1e  jne 0x3e21
  03e20  dec bx
L3E21:
  03e21  and bx, dx
  03e23  and bx, bx
  03e25  je 0x3e2a
  03e27  jmp 0x1bd7
L3E2A:
  03e2a  mov bx, 0x157e  ; 'STATUE'
  03e2d  mov ax, 0xfe2
  03e30  lcall 0x7d6, 0xfd2
  03e35  mov dx, 0
  03e38  jne 0x3e3b
  03e3a  dec dx
L3E3B:
  03e3b  mov di, 0x1094
  03e3e  mov si, 0xf1a
  03e41  lcall 0x7d6, 0x19ce
  03e46  mov bx, 0
  03e49  jne 0x3e4c
  03e4b  dec bx
L3E4C:
  03e4c  and bx, dx
  03e4e  and bx, bx
  03e50  je 0x3e55
  03e52  jmp 0x1bd7
L3E55:
  03e55  mov bx, 0x1588  ; 'BARREL'
  03e58  mov ax, 0xfe2
  03e5b  lcall 0x7d6, 0xfd2
  03e60  mov dx, 0
  03e63  jne 0x3e66
  03e65  dec dx
L3E66:
  03e66  mov bx, 0x1592  ; 'BARRELS'
  03e69  lcall 0x7d6, 0xfd2
  03e6e  mov cx, 0
  03e71  jne 0x3e74
  03e73  dec cx
L3E74:
  03e74  or cx, dx
  03e76  and cx, cx
  03e78  jne 0x3e7d
  03e7a  jmp 0x3e8d
L3E7D:
  03e7d  mov di, 0x1126
  03e80  mov si, 0xf1a
  03e83  lcall 0x7d6, 0x19ce
  03e88  jne 0x3e8d
  03e8a  jmp 0x1bd7
L3E8D:
  03e8d  mov bx, 0x159e  ; 'CHAIN'
  03e90  mov ax, 0xfe2
  03e93  lcall 0x7d6, 0xfd2
  03e98  mov dx, 0
  03e9b  jne 0x3e9e
  03e9d  dec dx
L3E9E:
  03e9e  mov bx, 0x15a8  ; 'CHAINS'
  03ea1  lcall 0x7d6, 0xfd2
  03ea6  mov cx, 0
  03ea9  jne 0x3eac
  03eab  dec cx
L3EAC:
  03eac  or cx, dx
  03eae  and cx, cx
  03eb0  jne 0x3eb5
  03eb2  jmp 0x3ec5
L3EB5:
  03eb5  mov di, 0x18b2
  03eb8  mov si, 0xf1a
  03ebb  lcall 0x7d6, 0x19ce
  03ec0  jne 0x3ec5
  03ec2  jmp 0x1bd7
L3EC5:
  03ec5  mov bx, 0x135e  ; 'MIRROR'
  03ec8  mov ax, 0xfe2
  03ecb  lcall 0x7d6, 0xfd2
  03ed0  mov dx, 0
  03ed3  jne 0x3ed6
  03ed5  dec dx
L3ED6:
  03ed6  mov di, 0x135a
  03ed9  mov si, 0xf1a
  03edc  lcall 0x7d6, 0x19ce
  03ee1  mov bx, 0
  03ee4  jne 0x3ee7
  03ee6  dec bx
L3EE7:
  03ee7  and bx, dx
  03ee9  and bx, bx
  03eeb  je 0x3ef0
  03eed  jmp 0x1bd7
L3EF0:
  03ef0  mov di, 0xfb2
  03ef3  mov si, 0x1090
  03ef6  lcall 0x7d6, 0x10a6
  03efb  mov bx, 0x168a  ; "and I don't"
  03efe  mov dx, 0xeda
  03f01  lcall 0x7d6, 0xf62
  03f06  mov bx, 0x1e72  ; 'see any!'
  03f09  mov dx, 0xede
  03f0c  lcall 0x7d6, 0xf62
  03f11  jmp 0x1bd7
; ---- gap 0x3f14-0x3f61 (77 bytes)
L3F61:
  03f61  mov si, 0xf32
  03f64  lcall 0x7d6, 0x227f
  03f69  mov si, bx
  03f6b  shl si, 1
  03f6d  shl si, 1
  03f6f  add si, 0xc26
  03f73  mov di, 0xf1a
  03f76  lcall 0x7d6, 0x19ce
  03f7b  je 0x3f80
  03f7d  jmp 0x3fa4
L3F80:
  03f80  mov di, 0xfb2
  03f83  mov si, 0x11d6
  03f86  lcall 0x7d6, 0x10a6
  03f8b  mov bx, 0x1e7e  ; ' Get it'
  03f8e  mov dx, 0xed2
  03f91  lcall 0x7d6, 0xf62
  03f96  mov bx, 0x1e8a  ; ' Yourself!'
  03f99  mov dx, 0xed6
  03f9c  lcall 0x7d6, 0xf62
  03fa1  jmp 0x1bd7
L3FA4:
  03fa4  mov si, 0xf32
  03fa7  lcall 0x7d6, 0x227f
  03fac  mov si, bx
  03fae  shl si, 1
  03fb0  shl si, 1
  03fb2  add si, 0xc26
  03fb6  lcall 0x7d6, 0x26aa
  03fbb  je 0x3fc0
  03fbd  jmp 0x3fe4
L3FC0:
  03fc0  mov di, 0xfb2
  03fc3  mov si, 0x11d6
  03fc6  lcall 0x7d6, 0x10a6
  03fcb  mov bx, 0x1e98  ; ' You already'
  03fce  mov dx, 0xed2
  03fd1  lcall 0x7d6, 0xf62
  03fd6  mov bx, 0x1ea8  ; ' have it!'
  03fd9  mov dx, 0xed6
  03fdc  lcall 0x7d6, 0xf62
  03fe1  jmp 0x1bd7
L3FE4:
  03fe4  mov si, 0xf32
  03fe7  lcall 0x7d6, 0x227f
  03fec  mov si, bx
  03fee  shl si, 1
  03ff0  shl si, 1
  03ff2  add si, 0xc26
  03ff6  mov di, 0x1048
  03ff9  mov bx, si
  03ffb  mov si, 0xf1a
  03ffe  lcall 0x7d6, 0x1772
  04003  mov si, bx
  04005  lcall 0x7d6, 0x19cb
  0400a  jne 0x400f
  0400c  jmp 0x403b
L400F:
  0400f  mov di, 0xfb2
  04012  mov si, 0x11d6
  04015  lcall 0x7d6, 0x10a6
  0401a  mov bx, 0x18d8  ; " I don't see"
  0401d  mov dx, 0xed2
  04020  lcall 0x7d6, 0xf62
  04025  mov bx, 0xfe2
  04028  mov ax, 0x1eb6  ; ' a '
  0402b  lcall 0x7d6, 0xf98
  04030  mov dx, 0xed6
  04033  lcall 0x7d6, 0xf62
  04038  jmp 0x1bd7
L403B:
  0403b  mov si, 0x1062
  0403e  lcall 0x7d6, 0x10bd
  04043  jmp 0x4129
L4046:
  04046  mov si, 0x1062
  04049  lcall 0x7d6, 0x10bd
  0404e  jmp 0x4107
L4051:
  04051  mov di, 0xf92
  04054  mov si, 0xf1e
  04057  lcall 0x7d6, 0x1772
  0405c  mov di, 0x107e
  0405f  lcall 0x7d6, 0x19c3
  04064  mov bx, 0
  04067  jbe 0x406a
  04069  dec bx
L406A:
  0406a  mov di, 0x100e
  0406d  mov si, 0xf22
  04070  lcall 0x7d6, 0x1772
  04075  mov di, 0x1074
  04078  lcall 0x7d6, 0x19c3
  0407d  mov dx, 0
  04080  jbe 0x4083
  04082  dec dx
L4083:
  04083  or dx, bx
  04085  and dx, dx
  04087  je 0x408c
  04089  jmp 0x40fc
L408C:
  0408c  mov di, 0x100e
  0408f  mov si, 0xf22
  04092  lcall 0x7d6, 0x1772
  04097  lcall 0x7d6, 0x22ca
  0409c  mov di, 0xf92
  0409f  mov si, 0xf1e
  040a2  lcall 0x7d6, 0x1772
  040a7  mov dx, bx
  040a9  lcall 0x7d6, 0x22ca
  040ae  mov cx, 0x7fff
  040b1  lcall 0x7d6, 0xb3b
  040b6  lcall 0x7d6, 0x2237
  040bb  mov di, 0xffa
  040be  lcall 0x7d6, 0x10a3
  040c3  mov si, 0xf32
  040c6  lcall 0x7d6, 0x227f
  040cb  mov si, bx
  040cd  shl si, 1
  040cf  shl si, 1
  040d1  mov bx, si
  040d3  add si, 0xcde
  040d7  lcall 0x7d6, 0x19ce
  040dc  mov dx, 0
  040df  jne 0x40e2
  040e1  dec dx
L40E2:
  040e2  add bx, 0xd3a
  040e6  mov si, bx
  040e8  lcall 0x7d6, 0x19ce
  040ed  mov cx, 0
  040f0  jne 0x40f3
  040f2  dec cx
L40F3:
  040f3  or cx, dx
  040f5  and cx, cx
  040f7  je 0x40fc
  040f9  jmp 0x4164
L40FC:
  040fc  mov di, 0x1040
  040ff  mov si, 0x100e
  04102  lcall 0x7d6, 0x1772
L4107:
  04107  mov di, 0x100e
  0410a  lcall 0x7d6, 0x10a3
  0410f  mov si, di
  04111  mov di, 0x1040
  04114  lcall 0x7d6, 0x19ce
  04119  ja 0x411e
  0411b  jmp 0x4051
L411E:
  0411e  mov di, 0x1040
  04121  mov si, 0xf92
  04124  lcall 0x7d6, 0x1772
L4129:
  04129  mov di, 0xf92
  0412c  lcall 0x7d6, 0x10a3
  04131  mov si, di
  04133  mov di, 0x1040
  04136  lcall 0x7d6, 0x19ce
  0413b  ja 0x4140
  0413d  jmp 0x4046
L4140:
  04140  mov di, 0xfb2
  04143  mov si, 0x11d6
  04146  lcall 0x7d6, 0x10a6
  0414b  mov bx, 0x1ebe  ; " I can't"
  0414e  mov dx, 0xed2
  04151  lcall 0x7d6, 0xf62
  04156  mov bx, 0x1eca  ; ' reach it!'
  04159  mov dx, 0xed6
  0415c  lcall 0x7d6, 0xf62
  04161  jmp 0x1bd7
L4164:
  04164  mov di, 0x1468
  04167  mov si, 0xfea
  0416a  lcall 0x7d6, 0x19ce
  0416f  jne 0x4174
  04171  jmp 0x1b42
L4174:
  04174  mov di, 0x1040
  04177  mov si, 0xfea
  0417a  lcall 0x7d6, 0x1772
  0417f  mov bx, di
  04181  mov di, si
  04183  lcall 0x7d6, 0x10a3
  04188  mov dx, bx
  0418a  mov si, 0xf32
  0418d  lcall 0x7d6, 0x227f
  04192  mov di, bx
  04194  shl di, 1
  04196  shl di, 1
  04198  add di, 0xc26
  0419c  mov si, 0x1088
  0419f  lcall 0x7d6, 0x10a6
  041a4  mov bx, 0x1f4
  041a7  lcall 0x7d6, 0x635
  041ac  mov di, 0xfb2
  041af  mov si, 0x1040
  041b2  lcall 0x7d6, 0x10a6
  041b7  mov bx, 0x1ed8  ; 'Done.'
  041ba  mov dx, 0xed2
  041bd  lcall 0x7d6, 0xf62
  041c2  jmp 0x1bd7
L41C5:
  041c5  mov bx, 0x1278  ; 'WINE'
  041c8  mov ax, 0xfe2
  041cb  lcall 0x7d6, 0xfd2
  041d0  je 0x41d5
  041d2  jmp 0x420c
L41D5:
  041d5  mov di, 0x1126
  041d8  mov si, 0xf1a
  041db  lcall 0x7d6, 0x19ce
  041e0  je 0x41e5
  041e2  jmp 0x4209
L41E5:
  041e5  mov di, 0xfb2
  041e8  mov si, 0x11d6
  041eb  lcall 0x7d6, 0x10a6
  041f0  mov bx, 0x1ee2  ; ' The Barrels'
  041f3  mov dx, 0xed2
  041f6  lcall 0x7d6, 0xf62
  041fb  mov bx, 0x1ef2  ; ' are empty.'
  041fe  mov dx, 0xed6
  04201  lcall 0x7d6, 0xf62
  04206  jmp 0x1bd7
L4209:
  04209  jmp 0x3b6f
L420C:
  0420c  mov di, 0x1074
  0420f  mov si, 0xf1a
  04212  lcall 0x7d6, 0x19ce
  04217  je 0x421c
  04219  jmp 0x3b6f
L421C:
  0421c  mov si, 0xc52
  0421f  lcall 0x7d6, 0x26aa
  04224  jne 0x4229
  04226  jmp 0x424d
L4229:
  04229  mov di, 0xfb2
  0422c  mov si, 0x11d6
  0422f  lcall 0x7d6, 0x10a6
  04234  mov bx, 0x1dac  ; "You don't have"
  04237  mov dx, 0xed2
  0423a  lcall 0x7d6, 0xf62
  0423f  mov bx, 0x1f02  ; 'a Container!'
  04242  mov dx, 0xed6
  04245  lcall 0x7d6, 0xf62
  0424a  jmp 0x1bd7
L424D:
  0424d  mov di, 0x1040
  04250  mov si, 0x1006
  04253  lcall 0x7d6, 0x19ce
  04258  je 0x425d
  0425a  jmp 0x4281
L425D:
  0425d  mov di, 0xfb2
  04260  mov si, 0x11d6
  04263  lcall 0x7d6, 0x10a6
  04268  mov bx, 0x1f12  ; 'The flask is'
  0426b  mov dx, 0xed2
  0426e  lcall 0x7d6, 0xf62
  04273  mov bx, 0x1f22  ; 'full!'
  04276  mov dx, 0xed6
  04279  lcall 0x7d6, 0xf62
  0427e  jmp 0x1bd7
L4281:
  04281  mov si, 0x1062
  04284  lcall 0x7d6, 0x10bd
  04289  jmp 0x43aa
L428C:
  0428c  mov si, 0x1062
  0428f  lcall 0x7d6, 0x10bd
  04294  jmp 0x4388
L4297:
  04297  mov di, 0xf32
  0429a  mov si, 0xf1e
  0429d  lcall 0x7d6, 0x1772
  042a2  mov di, 0x1040
  042a5  mov bx, si
  042a7  lcall 0x7d6, 0x19c3
  042ac  mov dx, 0
  042af  jae 0x42b2
  042b1  dec dx
L42B2:
  042b2  mov cx, di
  042b4  mov di, 0xf92
  042b7  mov si, 0xf22
  042ba  lcall 0x7d6, 0x1772
  042bf  mov di, cx
  042c1  mov ax, si
  042c3  lcall 0x7d6, 0x19c3
  042c8  mov word ptr [bp - 2], bx
  042cb  mov bx, 0
  042ce  jae 0x42d1
  042d0  dec bx
L42D1:
  042d1  or bx, dx
  042d3  mov di, 0x1074
  042d6  mov si, word ptr [bp - 2]
  042d9  lcall 0x7d6, 0x19ce
  042de  mov dx, 0
  042e1  jne 0x42e4
  042e3  dec dx
L42E4:
  042e4  or dx, bx
  042e6  xchg si, ax
  042e7  mov di, 0x107e
  042ea  lcall 0x7d6, 0x19ce
  042ef  mov bx, 0
  042f2  jne 0x42f5
  042f4  dec bx
L42F5:
  042f5  or bx, dx
  042f7  and bx, bx
  042f9  jne 0x42fe
  042fb  jmp 0x42fe
L42FE:
  042fe  mov di, 0xf92
  04301  mov si, 0xf22
  04304  lcall 0x7d6, 0x1772
  04309  lcall 0x7d6, 0x22ca
  0430e  mov di, 0xf32
  04311  mov si, 0xf1e
  04314  lcall 0x7d6, 0x1772
  04319  mov dx, bx
  0431b  lcall 0x7d6, 0x22ca
  04320  mov cx, 0x7fff
  04323  lcall 0x7d6, 0xb3b
  04328  lcall 0x7d6, 0x2237
  0432d  mov di, 0xffa
  04330  lcall 0x7d6, 0x10a3
  04335  mov si, di
  04337  mov di, 0x1f2c
  0433a  lcall 0x7d6, 0x19ce
  0433f  mov bx, 0
  04342  jne 0x4345
  04344  dec bx
L4345:
  04345  mov di, 0x1f30
  04348  lcall 0x7d6, 0x19ce
  0434d  mov dx, 0
  04350  jne 0x4353
  04352  dec dx
L4353:
  04353  or dx, bx
  04355  and dx, dx
  04357  jne 0x435c
  04359  jmp 0x437d
L435C:
  0435c  mov di, 0x1006
  0435f  mov si, 0x1040
  04362  lcall 0x7d6, 0x10a6
  04367  mov di, 0xfb2
  0436a  lcall 0x7d6, 0x10a6
  0436f  mov bx, 0x1ed8  ; 'Done.'
  04372  mov dx, 0xed2
  04375  lcall 0x7d6, 0xf62
  0437a  jmp 0x1bd7
L437D:
  0437d  mov di, 0x1040
  04380  mov si, 0xf92
  04383  lcall 0x7d6, 0x1772
L4388:
  04388  mov di, 0xf92
  0438b  lcall 0x7d6, 0x10a3
  04390  mov si, di
  04392  mov di, 0x1040
  04395  lcall 0x7d6, 0x19ce
  0439a  ja 0x439f
  0439c  jmp 0x4297
L439F:
  0439f  mov di, 0x1040
  043a2  mov si, 0xf32
  043a5  lcall 0x7d6, 0x1772
L43AA:
  043aa  mov di, 0xf32
  043ad  lcall 0x7d6, 0x10a3
  043b2  mov si, di
  043b4  mov di, 0x1040
  043b7  lcall 0x7d6, 0x19ce
  043bc  ja 0x43c1
  043be  jmp 0x428c
L43C1:
  043c1  mov di, 0xfb2
  043c4  mov si, 0x11d6
  043c7  lcall 0x7d6, 0x10a6
  043cc  mov bx, 0x1ebe  ; " I can't"
  043cf  mov dx, 0xed2
  043d2  lcall 0x7d6, 0xf62
  043d7  mov bx, 0x1eca  ; ' reach it!'
  043da  mov dx, 0xed6
  043dd  lcall 0x7d6, 0xf62
  043e2  jmp 0x1bd7
L43E5:
  043e5  mov di, 0xfb2
  043e8  mov si, 0x1040
  043eb  lcall 0x7d6, 0x10a6
  043f0  mov bx, 0x1f34  ; '- Inventory -'
  043f3  mov dx, 0xed2
  043f6  lcall 0x7d6, 0xf62
  043fb  mov si, 0x1040
  043fe  lcall 0x7d6, 0x10bd
  04403  jmp 0x4497
L4406:
  04406  mov si, 0xf32
  04409  lcall 0x7d6, 0x227f
  0440e  mov si, bx
  04410  shl si, 1
  04412  shl si, 1
  04414  mov bx, si
  04416  add si, 0xc26
  0441a  lcall 0x7d6, 0x26aa
  0441f  je 0x4424
  04421  jmp 0x447c
L4424:
  04424  mov di, 0x1040
  04427  mov si, 0xfb2
  0442a  lcall 0x7d6, 0x1772
  0442f  mov di, si
  04431  lcall 0x7d6, 0x10a3
  04436  mov dx, bx
  04438  mov si, di
  0443a  lcall 0x7d6, 0x227f
  0443f  shl bx, 1
  04441  shl bx, 1
  04443  add bx, 0xece
  04447  mov cx, dx
  04449  add dx, 0xe46
  0444d  mov si, dx
  0444f  mov ax, bx
  04451  lcall 0x7d6, 0x227f
  04456  lcall 0x7d6, 0x23be
  0445b  xchg bx, ax
  0445c  mov dx, bx
  0445e  mov bx, 0x10a4  ; ' '
  04461  lcall 0x7d6, 0xf98
  04466  add cx, 0xc82
  0446a  mov word ptr [bp - 2], bx
  0446d  mov bx, cx
  0446f  mov ax, word ptr [bp - 2]
  04472  lcall 0x7d6, 0xf98
  04477  lcall 0x7d6, 0xf62
L447C:
  0447c  mov di, 0x17ce
  0447f  mov si, 0xfb2
  04482  lcall 0x7d6, 0x19ce
  04487  jne 0x448c
  04489  jmp 0x44ae
L448C:
  0448c  mov di, 0x1040
  0448f  mov si, 0xf32
  04492  lcall 0x7d6, 0x1772
L4497:
  04497  mov di, 0xf32
  0449a  lcall 0x7d6, 0x10a3
  0449f  mov si, di
  044a1  mov di, 0x104c
  044a4  lcall 0x7d6, 0x19ce
  044a9  ja 0x44ae
  044ab  jmp 0x4406
L44AE:
  044ae  mov di, 0x1040
  044b1  mov si, 0xfb2
  044b4  lcall 0x7d6, 0x19ce
  044b9  je 0x44be
  044bb  jmp 0x44de
L44BE:
  044be  mov di, si
  044c0  mov si, 0x10be
  044c3  lcall 0x7d6, 0x10a6
  044c8  mov bx, 0x106a  ; ''
  044cb  mov dx, 0xed6
  044ce  lcall 0x7d6, 0xf62
  044d3  mov bx, 0x1f46  ; '   Nothing.'
  044d6  mov dx, 0xeda
  044d9  lcall 0x7d6, 0xf62
L44DE:
  044de  mov bx, 0x106a  ; ''
  044e1  mov dx, 0xf96
  044e4  lcall 0x7d6, 0xf62
  044e9  jmp 0x1bd7
L44EC:
  044ec  mov si, 0x1040
  044ef  lcall 0x7d6, 0x10bd
  044f4  jmp 0x457b
L44F7:
  044f7  mov si, 0xf32
  044fa  lcall 0x7d6, 0x227f
  044ff  shl bx, 1
  04501  shl bx, 1
  04503  add bx, 0xc82
  04507  mov dx, 0xfd6
  0450a  lcall 0x7d6, 0xf62
  0450f  mov bx, 0x20
  04512  lcall 0x7d6, 0x23be
  04517  xchg bx, dx
  04519  mov cx, bx
  0451b  lcall 0x7d6, 0x245e
  04520  lcall 0x7d6, 0x2237
  04525  mov di, 0xfb2
  04528  lcall 0x7d6, 0x10a3
  0452d  mov si, di
  0452f  lcall 0x7d6, 0x26aa
  04534  ja 0x4539
  04536  jmp 0x4560
L4539:
  04539  mov bx, cx
  0453b  lcall 0x7d6, 0x2386
  04540  lcall 0x7d6, 0x2237
  04545  lcall 0x7d6, 0x1752
  0454a  lcall 0x7d6, 0x22ca
  0454f  mov ax, bx
  04551  mov bx, cx
  04553  xchg dx, ax
  04554  lcall 0x7d6, 0x2478  ; 'You pour the'
  04559  mov dx, cx
  0455b  lcall 0x7d6, 0xf62
L4560:
  04560  mov bx, 0xfd6
  04563  mov ax, 0xfe2
  04566  lcall 0x7d6, 0xfd2
  0456b  jne 0x4570
  0456d  jmp 0x45c7
L4570:
  04570  mov di, 0x1040
  04573  mov si, 0xf32
  04576  lcall 0x7d6, 0x1772
L457B:
  0457b  mov di, 0xf32
  0457e  lcall 0x7d6, 0x10a3
  04583  mov si, di
  04585  mov di, 0x104c
  04588  lcall 0x7d6, 0x19ce
  0458d  ja 0x4592
  0458f  jmp 0x44f7
L4592:
  04592  mov di, 0xfb2
  04595  mov si, 0x11d6
  04598  lcall 0x7d6, 0x10a6
  0459d  mov bx, 0x1dac  ; "You don't have"
  045a0  mov dx, 0xed2
  045a3  lcall 0x7d6, 0xf62
  045a8  mov bx, 0xfe2
  045ab  mov ax, 0x167e  ; 'a '
  045ae  lcall 0x7d6, 0xf98
  045b3  xchg bx, ax
  045b4  mov bx, 0x1512  ; '!'
  045b7  lcall 0x7d6, 0xf98
  045bc  mov dx, 0xed6
  045bf  lcall 0x7d6, 0xf62
  045c4  jmp 0x1bd7
L45C7:
  045c7  mov si, 0xf32
  045ca  lcall 0x7d6, 0x227f
  045cf  mov si, bx
  045d1  shl si, 1
  045d3  shl si, 1
  045d5  add si, 0xc26
  045d9  lcall 0x7d6, 0x26aa
  045de  jne 0x45e3
  045e0  jmp 0x4607
L45E3:
  045e3  mov di, 0xfb2
  045e6  mov si, 0x11d6
  045e9  lcall 0x7d6, 0x10a6
  045ee  mov bx, 0x1f56  ; " You don't"
  045f1  mov dx, 0xed2
  045f4  lcall 0x7d6, 0xf62
  045f9  mov bx, 0x1ea8  ; ' have it!'
  045fc  mov dx, 0xed6
  045ff  lcall 0x7d6, 0xf62
  04604  jmp 0x1bd7
L4607:
  04607  mov di, 0x10be
  0460a  mov si, 0xf32
  0460d  lcall 0x7d6, 0x19ce
  04612  mov bx, 0
  04615  jne 0x4618
  04617  dec bx
L4618:
  04618  mov di, 0x1050
  0461b  lcall 0x7d6, 0x19ce
  04620  mov dx, 0
  04623  jne 0x4626
  04625  dec dx
L4626:
  04626  or dx, bx
  04628  and dx, dx
  0462a  jne 0x462f
  0462c  jmp 0x4653
L462F:
  0462f  mov di, 0xfb2
  04632  mov si, 0x11d6
  04635  lcall 0x7d6, 0x10a6
  0463a  mov bx, 0x1f64  ; 'Ok.'
  0463d  mov dx, 0xed2
  04640  lcall 0x7d6, 0xf62
  04645  mov bx, 0x1f6c  ; "I'm wearing it."
  04648  mov dx, 0xed6
  0464b  lcall 0x7d6, 0xf62
  04650  jmp 0x1bd7
L4653:
  04653  mov di, 0x104c
  04656  mov si, 0xf32
  04659  lcall 0x7d6, 0x19ce
  0465e  je 0x4663
  04660  jmp 0x4687
L4663:
  04663  mov di, 0xfb2
  04666  mov si, 0x11d6
  04669  lcall 0x7d6, 0x10a6
  0466e  mov bx, 0x1f80  ; ' The crown is'
  04671  mov dx, 0xed2
  04674  lcall 0x7d6, 0xf62
  04679  mov bx, 0x1f92  ; ' too Heavy!'
  0467c  mov dx, 0xed6
  0467f  lcall 0x7d6, 0xf62
  04684  jmp 0x1bd7
L4687:
  04687  mov di, 0x13dc
  0468a  mov si, 0xf32
  0468d  lcall 0x7d6, 0x19ce
  04692  je 0x4697
  04694  jmp 0x46c6
L4697:
  04697  mov di, 0xfb2
  0469a  mov si, 0x10be
  0469d  lcall 0x7d6, 0x10a6
  046a2  mov bx, 0x1fa2  ; ' Ok.'
  046a5  mov dx, 0xed2
  046a8  lcall 0x7d6, 0xf62
  046ad  mov bx, 0x1faa  ; " I'm wearing"
  046b0  mov dx, 0xed6
  046b3  lcall 0x7d6, 0xf62
  046b8  mov bx, 0x1fba  ; ' them.'
  046bb  mov dx, 0xeda
  046be  lcall 0x7d6, 0xf62
  046c3  jmp 0x1bd7
L46C6:
  046c6  mov di, 0xfb2
  046c9  mov si, 0x11d6
  046cc  lcall 0x7d6, 0x10a6
  046d1  mov bx, 0x1fc4  ; 'That could be'
  046d4  mov dx, 0xed2
  046d7  lcall 0x7d6, 0xf62
  046dc  mov bx, 0x1fd6  ; 'Difficult!'
  046df  mov dx, 0xed6
  046e2  lcall 0x7d6, 0xf62
  046e7  jmp 0x1bd7
L46EA:
  046ea  mov si, 0x1040
  046ed  lcall 0x7d6, 0x10bd
  046f2  jmp 0x4779
L46F5:
  046f5  mov si, 0xf32
  046f8  lcall 0x7d6, 0x227f
  046fd  shl bx, 1
  046ff  shl bx, 1
  04701  add bx, 0xc82
  04705  mov dx, 0xfd6
  04708  lcall 0x7d6, 0xf62
  0470d  mov bx, 0x20
  04710  lcall 0x7d6, 0x23be
  04715  xchg bx, dx
  04717  mov cx, bx
  04719  lcall 0x7d6, 0x245e
  0471e  lcall 0x7d6, 0x2237
  04723  mov di, 0xfb2
  04726  lcall 0x7d6, 0x10a3
  0472b  mov si, di
  0472d  lcall 0x7d6, 0x26aa
  04732  ja 0x4737
  04734  jmp 0x475e
L4737:
  04737  mov bx, cx
  04739  lcall 0x7d6, 0x2386
  0473e  lcall 0x7d6, 0x2237
  04743  lcall 0x7d6, 0x1752
  04748  lcall 0x7d6, 0x22ca
  0474d  mov ax, bx
  0474f  mov bx, cx
  04751  xchg dx, ax
  04752  lcall 0x7d6, 0x2478  ; 'You pour the'
  04757  mov dx, cx
  04759  lcall 0x7d6, 0xf62
L475E:
  0475e  mov bx, 0xfd6
  04761  mov ax, 0xfe2
  04764  lcall 0x7d6, 0xfd2
  04769  jne 0x476e
  0476b  jmp 0x47c5
L476E:
  0476e  mov di, 0x1040
  04771  mov si, 0xf32
  04774  lcall 0x7d6, 0x1772
L4779:
  04779  mov di, 0xf32
  0477c  lcall 0x7d6, 0x10a3
  04781  mov si, di
  04783  mov di, 0x104c
  04786  lcall 0x7d6, 0x19ce
  0478b  ja 0x4790
  0478d  jmp 0x46f5
L4790:
  04790  mov di, 0xfb2
  04793  mov si, 0x11d6
  04796  lcall 0x7d6, 0x10a6
  0479b  mov bx, 0x1dac  ; "You don't have"
  0479e  mov dx, 0xed2
  047a1  lcall 0x7d6, 0xf62
  047a6  mov bx, 0xfe2
  047a9  mov ax, 0x167e  ; 'a '
  047ac  lcall 0x7d6, 0xf98
  047b1  xchg bx, ax
  047b2  mov bx, 0x1512  ; '!'
  047b5  lcall 0x7d6, 0xf98
  047ba  mov dx, 0xed6
  047bd  lcall 0x7d6, 0xf62
  047c2  jmp 0x1bd7
L47C5:
  047c5  mov si, 0xf32
  047c8  lcall 0x7d6, 0x227f
  047cd  mov si, bx
  047cf  shl si, 1
  047d1  shl si, 1
  047d3  add si, 0xc26
  047d7  lcall 0x7d6, 0x26aa
  047dc  jne 0x47e1
  047de  jmp 0x4805
L47E1:
  047e1  mov di, 0xfb2
  047e4  mov si, 0x11d6
  047e7  lcall 0x7d6, 0x10a6
  047ec  mov bx, 0x1f56  ; " You don't"
  047ef  mov dx, 0xed2
  047f2  lcall 0x7d6, 0xf62
  047f7  mov bx, 0x1ea8  ; ' have it!'
  047fa  mov dx, 0xed6
  047fd  lcall 0x7d6, 0xf62
  04802  jmp 0x1bd7
L4805:
  04805  mov di, 0x11d6
  04808  mov si, 0xf32
  0480b  lcall 0x7d6, 0x19ce
  04810  jne 0x4815
  04812  jmp 0x484c
L4815:
  04815  mov di, 0xfb2
  04818  mov si, 0x10be
  0481b  lcall 0x7d6, 0x10a6
  04820  mov bx, 0xfe2
  04823  mov ax, 0x1492  ; 'The '
  04826  lcall 0x7d6, 0xf98
  0482b  mov dx, 0xed2
  0482e  lcall 0x7d6, 0xf62
  04833  mov bx, 0x1fe4  ; 'makes Horrible'
  04836  mov dx, 0xed6
  04839  lcall 0x7d6, 0xf62
  0483e  mov bx, 0x1ff6  ; 'music!!'
  04841  mov dx, 0xeda
  04844  lcall 0x7d6, 0xf62
  04849  jmp 0x1bd7
L484C:
  0484c  mov bx, 0x2002  ; 'MB O3 L24 C D E F# G# A# O4 C O3 A# G# F# E D C6'
  0484f  lcall 0x7d6, 0x2a83
  04854  mov di, 0xfb2
  04857  mov si, 0x10be
  0485a  lcall 0x7d6, 0x10a6
  0485f  mov bx, 0x2036  ; 'The Harp makes'
  04862  mov dx, 0xed2
  04865  lcall 0x7d6, 0xf62
  0486a  mov bx, 0x2048  ; 'Beautiful'
  0486d  mov dx, 0xed6
  04870  lcall 0x7d6, 0xf62
  04875  mov bx, 0x2056  ; 'Music!'
  04878  mov dx, 0xeda
  0487b  lcall 0x7d6, 0xf62
  04880  mov di, 0xf1a
  04883  mov si, 0xdbe
  04886  lcall 0x7d6, 0x19ce
  0488b  je 0x4890
  0488d  jmp 0x1bd7
L4890:
  04890  mov si, 0xdea
  04893  lcall 0x7d6, 0x227f
  04898  lcall 0x7d6, 0xffd
  0489d  mov si, 0xe16
  048a0  lcall 0x7d6, 0x227f
  048a5  lcall 0x7d6, 0x1017
  048aa  lcall 0x7d6, 0x3021
  048af  mov bx, 0x20
  048b2  lcall 0x7d6, 0x23be
  048b7  lcall 0x7d6, 0x2d79
  048bc  mov di, 0xdbe
  048bf  mov si, 0x10ba
  048c2  lcall 0x7d6, 0x10a6
  048c7  mov di, 0xfb2
  048ca  mov si, 0x1468
  048cd  lcall 0x7d6, 0x10a6
  048d2  mov bx, 0x2060  ; 'The fairy'
  048d5  mov dx, 0xede
  048d8  lcall 0x7d6, 0xf62
  048dd  mov bx, 0x206e  ; 'likes the music'
  048e0  mov dx, 0xee2
  048e3  lcall 0x7d6, 0xf62
  048e8  mov bx, 0x2082  ; 'and leaves!'
  048eb  mov dx, 0xee6
  048ee  lcall 0x7d6, 0xf62
  048f3  jmp 0x1bd7
L48F6:
  048f6  mov si, 0x1040
  048f9  lcall 0x7d6, 0x10bd
  048fe  jmp 0x4985
L4901:
  04901  mov si, 0xf32
  04904  lcall 0x7d6, 0x227f
  04909  shl bx, 1
  0490b  shl bx, 1
  0490d  add bx, 0xc82
  04911  mov dx, 0xfd6
  04914  lcall 0x7d6, 0xf62
  04919  mov bx, 0x20
  0491c  lcall 0x7d6, 0x23be
  04921  xchg bx, dx
  04923  mov cx, bx
  04925  lcall 0x7d6, 0x245e
  0492a  lcall 0x7d6, 0x2237
  0492f  mov di, 0xfb2
  04932  lcall 0x7d6, 0x10a3
  04937  mov si, di
  04939  lcall 0x7d6, 0x26aa
  0493e  ja 0x4943
  04940  jmp 0x496a
L4943:
  04943  mov bx, cx
  04945  lcall 0x7d6, 0x2386
  0494a  lcall 0x7d6, 0x2237
  0494f  lcall 0x7d6, 0x1752
  04954  lcall 0x7d6, 0x22ca
  04959  mov ax, bx
  0495b  mov bx, cx
  0495d  xchg dx, ax
  0495e  lcall 0x7d6, 0x2478  ; 'You pour the'
  04963  mov dx, cx
  04965  lcall 0x7d6, 0xf62
L496A:
  0496a  mov bx, 0xfd6
  0496d  mov ax, 0xfe2
  04970  lcall 0x7d6, 0xfd2
  04975  jne 0x497a
  04977  jmp 0x49d1
L497A:
  0497a  mov di, 0x1040
  0497d  mov si, 0xf32
  04980  lcall 0x7d6, 0x1772
L4985:
  04985  mov di, 0xf32
  04988  lcall 0x7d6, 0x10a3
  0498d  mov si, di
  0498f  mov di, 0x104c
  04992  lcall 0x7d6, 0x19ce
  04997  ja 0x499c
  04999  jmp 0x4901
L499C:
  0499c  mov di, 0xfb2
  0499f  mov si, 0x11d6
  049a2  lcall 0x7d6, 0x10a6
  049a7  mov bx, 0x1dac  ; "You don't have"
  049aa  mov dx, 0xed2
  049ad  lcall 0x7d6, 0xf62
  049b2  mov bx, 0xfe2
  049b5  mov ax, 0x167e  ; 'a '
  049b8  lcall 0x7d6, 0xf98
  049bd  xchg bx, ax
  049be  mov bx, 0x1512  ; '!'
  049c1  lcall 0x7d6, 0xf98
  049c6  mov dx, 0xed6
  049c9  lcall 0x7d6, 0xf62
  049ce  jmp 0x1bd7
L49D1:
  049d1  mov si, 0xf32
  049d4  lcall 0x7d6, 0x227f
  049d9  mov si, bx
  049db  shl si, 1
  049dd  shl si, 1
  049df  add si, 0xc26
  049e3  lcall 0x7d6, 0x26aa
  049e8  jne 0x499c
  049ea  mov di, 0x1098
  049ed  mov si, 0xf32
  049f0  lcall 0x7d6, 0x19ce
  049f5  jne 0x49fa
  049f7  jmp 0x4add
L49FA:
  049fa  mov di, 0x10b6
  049fd  mov si, 0xf32
  04a00  lcall 0x7d6, 0x19ce
  04a05  mov bx, 0
  04a08  jne 0x4a0b
  04a0a  dec bx
L4A0B:
  04a0b  mov di, 0x2092
  04a0e  mov si, 0xf1a
  04a11  lcall 0x7d6, 0x19ce
  04a16  mov dx, 0
  04a19  jne 0x4a1c
  04a1b  dec dx
L4A1C:
  04a1c  and dx, bx
  04a1e  and dx, dx
  04a20  jne 0x4a25
  04a22  jmp 0x4a96
L4A25:
  04a25  mov di, 0xfb2
  04a28  mov si, 0x1090
  04a2b  lcall 0x7d6, 0x10a6
  04a30  mov bx, 0x2096  ; 'The vampire'
  04a33  mov dx, 0xed2
  04a36  lcall 0x7d6, 0xf62
  04a3b  mov bx, 0x20a6  ; 'sees the holy'
  04a3e  mov dx, 0xed6
  04a41  lcall 0x7d6, 0xf62
  04a46  mov bx, 0x20b8  ; 'cross and'
  04a49  mov dx, 0xeda
  04a4c  lcall 0x7d6, 0xf62
  04a51  mov bx, 0x20c6  ; 'disappears!'
  04a54  mov dx, 0xede
  04a57  lcall 0x7d6, 0xf62
  04a5c  mov si, 0xde6
  04a5f  lcall 0x7d6, 0x227f
  04a64  lcall 0x7d6, 0xffd
  04a69  mov si, 0xe12
  04a6c  lcall 0x7d6, 0x227f
  04a71  lcall 0x7d6, 0x1017
  04a76  lcall 0x7d6, 0x3021
  04a7b  mov bx, 0x20
  04a7e  lcall 0x7d6, 0x23be
  04a83  lcall 0x7d6, 0x2d79
  04a88  mov di, 0xdba
  04a8b  mov si, 0x1088
  04a8e  lcall 0x7d6, 0x10a6
  04a93  jmp 0x1bd7
L4A96:
  04a96  mov di, 0x10c6
  04a99  mov si, 0xf32
  04a9c  lcall 0x7d6, 0x19ce
  04aa1  jne 0x4aa6
  04aa3  jmp 0x4c94
L4AA6:
  04aa6  mov di, 0xfb2
  04aa9  mov si, 0x10be
  04aac  lcall 0x7d6, 0x10a6
  04ab1  mov bx, 0x20d6  ; 'You look awful'
  04ab4  mov dx, 0xed2
  04ab7  lcall 0x7d6, 0xf62
  04abc  mov bx, 0x20e8  ; 'Silly waving'
  04abf  mov dx, 0xed6
  04ac2  lcall 0x7d6, 0xf62
  04ac7  mov bx, 0xfe2
  04aca  mov ax, 0x20f8  ; 'that '
  04acd  lcall 0x7d6, 0xf98
  04ad2  mov dx, 0xeda
  04ad5  lcall 0x7d6, 0xf62
  04ada  jmp 0x1bd7
L4ADD:
  04add  mov di, 0xfb2
  04ae0  mov si, 0x1098
  04ae3  lcall 0x7d6, 0x10a6
  04ae8  mov bx, 0x2102  ; 'As you wave the'
  04aeb  mov dx, 0xed2
  04aee  lcall 0x7d6, 0xf62
  04af3  mov bx, 0x2116  ; '....'
  04af6  mov ax, 0xfe2
  04af9  lcall 0x7d6, 0xf98
  04afe  mov dx, 0xed6
  04b01  lcall 0x7d6, 0xf62
  04b06  mov bx, 0x106a  ; ''
  04b09  mov dx, 0xeda
  04b0c  lcall 0x7d6, 0xf62
  04b11  mov bx, 0x211e  ; '  Nothing'
  04b14  mov dx, 0xede
  04b17  lcall 0x7d6, 0xf62
  04b1c  mov bx, 0x212c  ; '  Happens!'
  04b1f  mov dx, 0xee2
  04b22  lcall 0x7d6, 0xf62
  04b27  mov di, 0x1200
  04b2a  mov si, 0xf1a
  04b2d  lcall 0x7d6, 0x19ce
  04b32  mov bx, 0
  04b35  je 0x4b38
  04b37  dec bx
L4B38:
  04b38  mov di, 0x135a
  04b3b  lcall 0x7d6, 0x19ce
  04b40  mov dx, 0
  04b43  je 0x4b46
  04b45  dec dx
L4B46:
  04b46  and dx, bx
  04b48  and dx, dx
  04b4a  je 0x4b4f
  04b4c  jmp 0x1bd7
L4B4F:
  04b4f  mov di, 0x1200
  04b52  mov si, 0xf1a
  04b55  lcall 0x7d6, 0x19ce
  04b5a  jne 0x4b5f
  04b5c  jmp 0x4c5e
L4B5F:
  04b5f  mov si, 0x17ce
  04b62  lcall 0x7d6, 0x10bd
  04b67  jmp 0x4b98
L4B6A:
  04b6a  mov si, 0xf32
  04b6d  mov dx, si
  04b6f  lcall 0x7d6, 0x227f
  04b74  lcall 0x7d6, 0xffd
  04b79  mov bx, 0x13
  04b7c  lcall 0x7d6, 0x1017
  04b81  lcall 0x7d6, 0x3021
  04b86  mov bx, 0x10a4  ; ' '
  04b89  lcall 0x7d6, 0x2d79
  04b8e  mov si, dx
  04b90  mov di, 0x1040
  04b93  lcall 0x7d6, 0x1772
L4B98:
  04b98  mov di, 0xf32
  04b9b  lcall 0x7d6, 0x10a3
  04ba0  mov si, di
  04ba2  mov di, 0x10b6
  04ba5  lcall 0x7d6, 0x19ce
  04baa  jbe 0x4b6a
  04bac  mov bx, 8
  04baf  lcall 0x7d6, 0xffd
  04bb4  mov bx, 0x14
  04bb7  lcall 0x7d6, 0x1017
  04bbc  lcall 0x7d6, 0x3021
  04bc1  mov dx, bx
  04bc3  mov bx, 0x213a  ; '▓▓▓▓▓'
  04bc6  lcall 0x7d6, 0x2d8d
  04bcb  mov cx, bx
  04bcd  mov bx, 0xb
  04bd0  lcall 0x7d6, 0xffd
  04bd5  mov bx, dx
  04bd7  lcall 0x7d6, 0x1017
  04bdc  lcall 0x7d6, 0x3021
  04be1  mov bx, cx
  04be3  lcall 0x7d6, 0x2d8d
  04be8  mov bx, 9
  04beb  lcall 0x7d6, 0xffd
  04bf0  mov bx, 0x14
  04bf3  lcall 0x7d6, 0x1017
  04bf8  lcall 0x7d6, 0x3021
  04bfd  mov dx, bx
  04bff  mov bx, 0x10a4  ; ' '
  04c02  lcall 0x7d6, 0x2d79
  04c07  mov cx, bx
  04c09  mov bx, 0xa
  04c0c  lcall 0x7d6, 0xffd
  04c11  mov bx, dx
  04c13  lcall 0x7d6, 0x1017
  04c18  lcall 0x7d6, 0x3021
  04c1d  mov bx, cx
  04c1f  lcall 0x7d6, 0x2d79
L4C24:
  04c24  mov di, 0xfb2
  04c27  mov si, 0x17ce
  04c2a  lcall 0x7d6, 0x10a6
  04c2f  mov bx, 0x2144  ; '  There is a'
  04c32  mov dx, 0xede
  04c35  lcall 0x7d6, 0xf62
  04c3a  mov bx, 0x2154  ; '*Puff* of smoke'
  04c3d  mov dx, 0xee2
  04c40  lcall 0x7d6, 0xf62
  04c45  mov bx, 0x2168  ; 'Revealing a'
  04c48  mov dx, 0xee6
  04c4b  lcall 0x7d6, 0xf62
  04c50  mov bx, 0x2178  ; 'Secret passage!'
  04c53  mov dx, 0xeea
  04c56  lcall 0x7d6, 0xf62
  04c5b  jmp 0x1bd7
L4C5E:
  04c5e  mov bx, 0x12
  04c61  mov dx, 0xc
  04c64  mov cx, 0x7fff
  04c67  lcall 0x7d6, 0xb3b
  04c6c  cmp bx, 0x20
  04c6f  jne 0x4c74
  04c71  jmp 0x1bd7
L4C74:
  04c74  mov bx, 0x12
  04c77  lcall 0x7d6, 0xffd
  04c7c  mov bx, 0xb
  04c7f  lcall 0x7d6, 0x1017
  04c84  lcall 0x7d6, 0x3021
  04c89  mov bx, 0x111e  ; '▌  ▐'
  04c8c  lcall 0x7d6, 0x2d79
  04c91  jmp 0x4c24
L4C94:
  04c94  mov di, 0x1040
  04c97  mov si, 0xf1a
  04c9a  lcall 0x7d6, 0x19ce
  04c9f  jne 0x4ca4
  04ca1  jmp 0x4cf1
L4CA4:
  04ca4  mov di, 0xfb2
  04ca7  mov si, 0x1098
  04caa  lcall 0x7d6, 0x10a6
  04caf  mov bx, 0x2102  ; 'As you wave the'
  04cb2  mov dx, 0xed2
  04cb5  lcall 0x7d6, 0xf62
  04cba  mov bx, 0x2116  ; '....'
  04cbd  mov ax, 0xfe2
  04cc0  lcall 0x7d6, 0xf98
  04cc5  mov dx, 0xed6
  04cc8  lcall 0x7d6, 0xf62
  04ccd  mov bx, 0x106a  ; ''
  04cd0  mov dx, 0xeda
  04cd3  lcall 0x7d6, 0xf62
  04cd8  mov bx, 0x211e  ; '  Nothing'
  04cdb  mov dx, 0xede
  04cde  lcall 0x7d6, 0xf62
  04ce3  mov bx, 0x212c  ; '  Happens!'
  04ce6  mov dx, 0xee2
  04ce9  lcall 0x7d6, 0xf62
  04cee  jmp 0x1bd7
L4CF1:
  04cf1  mov bx, 0x12
  04cf4  lcall 0x7d6, 0xffd
  04cf9  mov bx, 0xb
  04cfc  lcall 0x7d6, 0x1017
  04d01  lcall 0x7d6, 0x3021
  04d06  mov bx, 0x218c  ; '    '
  04d09  lcall 0x7d6, 0x2d79
  04d0e  mov di, 0xfb2
  04d11  mov si, 0x1098
  04d14  lcall 0x7d6, 0x10a6
  04d19  mov bx, 0x2102  ; 'As you wave the'
  04d1c  mov dx, 0xed2
  04d1f  lcall 0x7d6, 0xf62
  04d24  mov bx, 0x2194  ; 'scepter...'
  04d27  mov dx, 0xed6
  04d2a  lcall 0x7d6, 0xf62
  04d2f  mov bx, 0x106a  ; ''
  04d32  mov dx, 0xeda
  04d35  lcall 0x7d6, 0xf62
  04d3a  mov bx, 0x21a2  ; 'The Gate opens'
  04d3d  mov dx, 0xede
  04d40  lcall 0x7d6, 0xf62
  04d45  mov bx, 0x21b4  ; 'by itself!'
  04d48  mov dx, 0xee2
  04d4b  lcall 0x7d6, 0xf62
  04d50  jmp 0x1bd7
L4D53:
  04d53  mov si, 0x1040
  04d56  lcall 0x7d6, 0x10bd
  04d5b  jmp 0x4de2
L4D5E:
  04d5e  mov si, 0xf32
  04d61  lcall 0x7d6, 0x227f
  04d66  shl bx, 1
  04d68  shl bx, 1
  04d6a  add bx, 0xc82
  04d6e  mov dx, 0xfd6
  04d71  lcall 0x7d6, 0xf62
  04d76  mov bx, 0x20
  04d79  lcall 0x7d6, 0x23be
  04d7e  xchg bx, dx
  04d80  mov cx, bx
  04d82  lcall 0x7d6, 0x245e
  04d87  lcall 0x7d6, 0x2237
  04d8c  mov di, 0xfb2
  04d8f  lcall 0x7d6, 0x10a3
  04d94  mov si, di
  04d96  lcall 0x7d6, 0x26aa
  04d9b  ja 0x4da0
  04d9d  jmp 0x4dc7
L4DA0:
  04da0  mov bx, cx
  04da2  lcall 0x7d6, 0x2386
  04da7  lcall 0x7d6, 0x2237
  04dac  lcall 0x7d6, 0x1752
  04db1  lcall 0x7d6, 0x22ca
  04db6  mov ax, bx
  04db8  mov bx, cx
  04dba  xchg dx, ax
  04dbb  lcall 0x7d6, 0x2478  ; 'You pour the'
  04dc0  mov dx, cx
  04dc2  lcall 0x7d6, 0xf62
L4DC7:
  04dc7  mov bx, 0xfd6
  04dca  mov ax, 0xfe2
  04dcd  lcall 0x7d6, 0xfd2
  04dd2  jne 0x4dd7
  04dd4  jmp 0x4e2e
L4DD7:
  04dd7  mov di, 0x1040
  04dda  mov si, 0xf32
  04ddd  lcall 0x7d6, 0x1772
L4DE2:
  04de2  mov di, 0xf32
  04de5  lcall 0x7d6, 0x10a3
  04dea  mov si, di
  04dec  mov di, 0x104c
  04def  lcall 0x7d6, 0x19ce
  04df4  ja 0x4df9
  04df6  jmp 0x4d5e
L4DF9:
  04df9  mov di, 0xfb2
  04dfc  mov si, 0x11d6
  04dff  lcall 0x7d6, 0x10a6
  04e04  mov bx, 0x1dac  ; "You don't have"
  04e07  mov dx, 0xed2
  04e0a  lcall 0x7d6, 0xf62
  04e0f  mov bx, 0xfe2
  04e12  mov ax, 0x167e  ; 'a '
  04e15  lcall 0x7d6, 0xf98
  04e1a  xchg bx, ax
  04e1b  mov bx, 0x1512  ; '!'
  04e1e  lcall 0x7d6, 0xf98
  04e23  mov dx, 0xed6
  04e26  lcall 0x7d6, 0xf62
  04e2b  jmp 0x1bd7
L4E2E:
  04e2e  mov si, 0xf32
  04e31  lcall 0x7d6, 0x227f
  04e36  mov si, bx
  04e38  shl si, 1
  04e3a  shl si, 1
  04e3c  add si, 0xc26
  04e40  lcall 0x7d6, 0x26aa
  04e45  je 0x4e4a
  04e47  jmp 0x499c
L4E4A:
  04e4a  mov di, 0x1040
  04e4d  mov si, 0xf32
  04e50  lcall 0x7d6, 0x19ce
  04e55  je 0x4e5a
  04e57  jmp 0x4e89
L4E5A:
  04e5a  mov di, 0xfb2
  04e5d  mov si, 0x10be
  04e60  lcall 0x7d6, 0x10a6
  04e65  mov bx, 0x21c2  ; " There's no"
  04e68  mov dx, 0xed2
  04e6b  lcall 0x7d6, 0xf62
  04e70  mov bx, 0x21d2  ; ' Genii in this'
  04e73  mov dx, 0xed6
  04e76  lcall 0x7d6, 0xf62
  04e7b  mov bx, 0x21e4  ; ' Lamp!'
  04e7e  mov dx, 0xeda
  04e81  lcall 0x7d6, 0xf62
  04e86  jmp 0x1bd7
L4E89:
  04e89  mov di, 0xfb2
  04e8c  mov si, 0x11d6
  04e8f  lcall 0x7d6, 0x10a6
  04e94  mov bx, 0xfe2
  04e97  mov ax, 0x1492  ; 'The '
  04e9a  lcall 0x7d6, 0xf98
  04e9f  mov dx, 0xed2
  04ea2  lcall 0x7d6, 0xf62
  04ea7  mov bx, 0x21ee  ; 'is cleaner now.'
  04eaa  mov dx, 0xed6
  04ead  lcall 0x7d6, 0xf62
  04eb2  jmp 0x1bd7
L4EB5:
  04eb5  mov di, 0xfb2
  04eb8  mov si, 0x1040
  04ebb  lcall 0x7d6, 0x10a6
  04ec0  mov bx, 0x22
  04ec3  mov dx, bx
  04ec5  lcall 0x7d6, 0x23be
  04eca  xchg bx, ax
  04ecb  mov bx, 0xfe2
  04ece  lcall 0x7d6, 0xf98
  04ed3  mov cx, bx
  04ed5  mov bx, dx
  04ed7  lcall 0x7d6, 0x23be
  04edc  xchg cx, ax
  04edd  lcall 0x7d6, 0xf98
  04ee2  mov dx, 0xed2
  04ee5  lcall 0x7d6, 0xf62
L4EEA:
  04eea  mov si, 0x1040
  04eed  lcall 0x7d6, 0x10bd
  04ef2  jmp 0x4f1f
L4EF5:
  04ef5  mov si, 0xf32
  04ef8  lcall 0x7d6, 0x227f
  04efd  mov si, bx
  04eff  shl si, 1
  04f01  shl si, 1
  04f03  add si, 0xd96
  04f07  mov di, 0xf1a
  04f0a  lcall 0x7d6, 0x19ce
  04f0f  jne 0x4f14
  04f11  jmp 0x4f36
L4F14:
  04f14  mov di, 0x1040
  04f17  mov si, 0xf32
  04f1a  lcall 0x7d6, 0x1772
L4F1F:
  04f1f  mov di, 0xf32
  04f22  lcall 0x7d6, 0x10a3
  04f27  mov si, di
  04f29  mov di, 0x1050
  04f2c  lcall 0x7d6, 0x19ce
  04f31  jbe 0x4ef5
  04f33  jmp 0x1bd7
L4F36:
  04f36  mov si, 0xf32
  04f39  lcall 0x7d6, 0x227f
  04f3e  shl bx, 1
  04f40  shl bx, 1
  04f42  add bx, 0xe1a
  04f46  mov dx, 0xfd6
  04f49  lcall 0x7d6, 0xf62
  04f4e  mov bx, 0x20
  04f51  lcall 0x7d6, 0x23be
  04f56  xchg bx, dx
  04f58  mov cx, bx
  04f5a  lcall 0x7d6, 0x245e
  04f5f  lcall 0x7d6, 0x2237
  04f64  mov di, 0xffa
  04f67  lcall 0x7d6, 0x10a3
  04f6c  mov si, di
  04f6e  lcall 0x7d6, 0x26aa
  04f73  ja 0x4f78
  04f75  jmp 0x4f9f
L4F78:
  04f78  mov bx, cx
  04f7a  lcall 0x7d6, 0x2386
  04f7f  lcall 0x7d6, 0x2237
  04f84  lcall 0x7d6, 0x1752
  04f89  lcall 0x7d6, 0x22ca
  04f8e  mov ax, bx
  04f90  mov bx, cx
  04f92  xchg dx, ax
  04f93  lcall 0x7d6, 0x2478  ; 'You pour the'
  04f98  mov dx, cx
  04f9a  lcall 0x7d6, 0xf62
L4F9F:
  04f9f  mov bx, 0x106a  ; ''
  04fa2  mov dx, 0xed6
  04fa5  lcall 0x7d6, 0xf62
  04faa  mov bx, 0xfd6
  04fad  mov ax, 0x1492  ; 'The '
  04fb0  lcall 0x7d6, 0xf98
  04fb5  mov dx, 0xeda
  04fb8  lcall 0x7d6, 0xf62
  04fbd  mov bx, 0x2202  ; 'looks at you'
  04fc0  mov dx, 0xede
  04fc3  lcall 0x7d6, 0xf62
  04fc8  mov bx, 0x2212  ; 'Funny!'
  04fcb  mov dx, 0xee2
  04fce  lcall 0x7d6, 0xf62
  04fd3  mov di, 0xfb2
  04fd6  mov si, 0x1098
  04fd9  lcall 0x7d6, 0x10a6
  04fde  jmp 0x1bd7
L4FE1:
  04fe1  mov si, 0xc42
  04fe4  lcall 0x7d6, 0x26aa
  04fe9  jne 0x4fee
  04feb  jmp 0x5012
L4FEE:
  04fee  mov di, 0xfb2
  04ff1  mov si, 0x11d6
  04ff4  lcall 0x7d6, 0x10a6
  04ff9  mov bx, 0x1f56  ; " You don't"
  04ffc  mov dx, 0xed2
  04fff  lcall 0x7d6, 0xf62
  05004  mov bx, 0x221c  ; ' have a Key!'
  05007  mov dx, 0xed6
  0500a  lcall 0x7d6, 0xf62
  0500f  jmp 0x1bd7
L5012:
  05012  mov bx, 0x1666  ; 'DOOR'
  05015  mov ax, 0xfe2
  05018  lcall 0x7d6, 0xfd2
  0501d  jne 0x5022
  0501f  jmp 0x50d7
L5022:
  05022  mov bx, 0x163e  ; 'GATE'
  05025  mov ax, 0xfe2
  05028  lcall 0x7d6, 0xfd2
  0502d  jne 0x5032
  0502f  jmp 0x504b
L5032:
  05032  mov di, 0xfb2
  05035  mov si, 0x1040
  05038  lcall 0x7d6, 0x10a6
  0503d  mov bx, 0x1e50  ; 'Impossible!!'
  05040  mov dx, 0xed2
  05043  lcall 0x7d6, 0xf62
  05048  jmp 0x1bd7
L504B:
  0504b  mov di, 0x1040
  0504e  mov si, 0xf1a
  05051  lcall 0x7d6, 0x19ce
  05056  jne 0x505b
  05058  jmp 0x507f
L505B:
  0505b  mov di, 0xfb2
  0505e  mov si, 0x11d6
  05061  lcall 0x7d6, 0x10a6
  05066  mov bx, 0x18d8  ; " I don't see"
  05069  mov dx, 0xed2
  0506c  lcall 0x7d6, 0xf62
  05071  mov bx, 0x222c  ; ' a Gate!'
  05074  mov dx, 0xed6
  05077  lcall 0x7d6, 0xf62
  0507c  jmp 0x1bd7
L507F:
  0507f  mov di, 0xfb2
  05082  mov si, 0x10be
  05085  lcall 0x7d6, 0x10a6
  0508a  mov bx, 0x2238  ; ' The Gate'
  0508d  mov dx, 0xed2
  05090  lcall 0x7d6, 0xf62
  05095  mov bx, 0x12cc  ; 'UNLOCK'
  05098  mov ax, 0xfde
  0509b  lcall 0x7d6, 0xfd2
  050a0  je 0x50a5
  050a2  jmp 0x50be
L50A5:
  050a5  mov bx, 0x2246  ; ' is locked'
  050a8  mov dx, 0xed6
  050ab  lcall 0x7d6, 0xf62
  050b0  mov bx, 0x2254  ; ' Magically.'
  050b3  mov dx, 0xeda
  050b6  lcall 0x7d6, 0xf62
  050bb  jmp 0x1bd7
L50BE:
  050be  mov bx, 0x2264  ; ' is already'
  050c1  mov dx, 0xed6
  050c4  lcall 0x7d6, 0xf62
  050c9  mov bx, 0x2274  ; ' locked!'
  050cc  mov dx, 0xeda
  050cf  lcall 0x7d6, 0xf62
  050d4  jmp 0x1bd7
L50D7:
  050d7  mov di, 0x1126
  050da  mov si, 0xf1a
  050dd  lcall 0x7d6, 0x19ce
  050e2  mov bx, 0
  050e5  je 0x50e8
  050e7  dec bx
L50E8:
  050e8  mov di, 0x112a
  050eb  lcall 0x7d6, 0x19ce
  050f0  mov dx, 0
  050f3  je 0x50f6
  050f5  dec dx
L50F6:
  050f6  and dx, bx
  050f8  and dx, dx
  050fa  jne 0x50ff
  050fc  jmp 0x5123
L50FF:
  050ff  mov di, 0xfb2
  05102  mov si, 0x11d6
  05105  lcall 0x7d6, 0x10a6
  0510a  mov bx, 0x1d6a  ; "I don't see"
  0510d  mov dx, 0xed2
  05110  lcall 0x7d6, 0xf62
  05115  mov bx, 0x2280  ; 'a door!'
  05118  mov dx, 0xed6
  0511b  lcall 0x7d6, 0xf62
  05120  jmp 0x1bd7
L5123:
  05123  mov bx, 0x12e0  ; 'LOCK'
  05126  mov ax, 0xfde
  05129  lcall 0x7d6, 0xfd2
  0512e  jne 0x5133
  05130  jmp 0x521f
L5133:
  05133  mov si, 0x1062
  05136  lcall 0x7d6, 0x10bd
  0513b  jmp 0x51e4
L513E:
  0513e  mov si, 0x1062
  05141  lcall 0x7d6, 0x10bd
  05146  jmp 0x51c2
L5149:
  05149  mov di, 0xf32
  0514c  mov si, 0xf1e
  0514f  lcall 0x7d6, 0x1772
  05154  mov di, 0x1040
  05157  lcall 0x7d6, 0x19c3
  0515c  mov bx, 0
  0515f  jae 0x5162
  05161  dec bx
L5162:
  05162  mov dx, di
  05164  mov di, 0xf92
  05167  mov si, 0xf22
  0516a  lcall 0x7d6, 0x1772
  0516f  mov di, dx
  05171  lcall 0x7d6, 0x19c3
  05176  mov cx, 0
  05179  jae 0x517c
  0517b  dec cx
L517C:
  0517c  or cx, bx
  0517e  and cx, cx
  05180  je 0x5185
  05182  jmp 0x51b7
L5185:
  05185  mov di, 0xf92
  05188  mov si, 0xf22
  0518b  lcall 0x7d6, 0x1772
  05190  lcall 0x7d6, 0x22ca
  05195  mov di, 0xf32
  05198  mov si, 0xf1e
  0519b  lcall 0x7d6, 0x1772
  051a0  mov dx, bx
  051a2  lcall 0x7d6, 0x22ca
  051a7  mov cx, 0x7fff
  051aa  lcall 0x7d6, 0xb3b
  051af  cmp bx, 8
  051b2  jne 0x51b7
  051b4  jmp 0x521f
L51B7:
  051b7  mov di, 0x1040
  051ba  mov si, 0xf92
  051bd  lcall 0x7d6, 0x1772
L51C2:
  051c2  mov di, 0xf92
  051c5  lcall 0x7d6, 0x10a3
  051ca  mov si, di
  051cc  mov di, 0x1040
  051cf  lcall 0x7d6, 0x19ce
  051d4  ja 0x51d9
  051d6  jmp 0x5149
L51D9:
  051d9  mov di, 0x1040
  051dc  mov si, 0xf32
  051df  lcall 0x7d6, 0x1772
L51E4:
  051e4  mov di, 0xf32
  051e7  lcall 0x7d6, 0x10a3
  051ec  mov si, di
  051ee  mov di, 0x1040
  051f1  lcall 0x7d6, 0x19ce
  051f6  ja 0x51fb
  051f8  jmp 0x513e
L51FB:
  051fb  mov di, 0xfb2
  051fe  mov si, 0x11d6
  05201  lcall 0x7d6, 0x10a6
  05206  mov bx, 0x1ebe  ; " I can't"
  05209  mov dx, 0xed2
  0520c  lcall 0x7d6, 0xf62
  05211  mov bx, 0x1eca  ; ' reach it!'
  05214  mov dx, 0xed6
  05217  lcall 0x7d6, 0xf62
  0521c  jmp 0x1bd7
L521F:
  0521f  mov di, 0x112a
  05222  mov si, 0xf1a
  05225  lcall 0x7d6, 0x19ce
  0522a  jne 0x522f
  0522c  jmp 0x5375
L522F:
  0522f  mov bx, 0x12e0  ; 'LOCK'
  05232  mov ax, 0xfde
  05235  lcall 0x7d6, 0xfd2
  0523a  je 0x523f
  0523c  jmp 0x529a
L523F:
  0523f  mov bx, 0xf
  05242  lcall 0x7d6, 0xffd
  05247  mov bx, 9
  0524a  lcall 0x7d6, 0x1017
  0524f  lcall 0x7d6, 0x3021
  05254  mov bx, 8
  05257  mov dx, bx
  05259  lcall 0x7d6, 0x23be
  0525e  lcall 0x7d6, 0x2d79
  05263  mov bx, dx
  05265  lcall 0x7d6, 0x23be
  0526a  lcall 0x7d6, 0x2d79
  0526f  mov di, 0xf26
  05272  mov si, 0x1040
  05275  lcall 0x7d6, 0x10a6
  0527a  mov di, 0xfb2
  0527d  lcall 0x7d6, 0x10a6
  05282  mov bx, 0x1ed8  ; 'Done.'
  05285  mov dx, 0xed2
  05288  lcall 0x7d6, 0xf62
  0528d  mov dx, si
  0528f  mov bx, 0x32
  05292  lcall 0x7d6, 0x635
  05297  jmp 0x1bd7
L529A:
  0529a  mov si, 0xf1e
  0529d  mov dx, si
  0529f  lcall 0x7d6, 0x227f
  052a4  lcall 0x7d6, 0xffd
  052a9  mov si, 0xf22
  052ac  lcall 0x7d6, 0x227f
  052b1  lcall 0x7d6, 0x1017
  052b6  lcall 0x7d6, 0x3021
  052bb  mov si, 0xfae
  052be  lcall 0x7d6, 0x227f
  052c3  lcall 0x7d6, 0x23be
  052c8  lcall 0x7d6, 0x2d79
  052cd  mov si, dx
  052cf  mov di, 0x1044
  052d2  lcall 0x7d6, 0x19ce
  052d7  ja 0x52dc
  052d9  jmp 0x52e9
L52DC:
  052dc  mov di, dx
  052de  mov si, 0x228c
  052e1  lcall 0x7d6, 0x10a6
  052e6  jmp 0x52f4
L52E9:
  052e9  mov di, 0xf1e
  052ec  mov si, 0x114a
  052ef  lcall 0x7d6, 0x10a6
L52F4:
  052f4  mov di, 0xf22
  052f7  mov si, 0x1066
  052fa  lcall 0x7d6, 0x10a6
  052ff  mov si, 0xf1e
  05302  lcall 0x7d6, 0x227f
  05307  lcall 0x7d6, 0xffd
  0530c  mov si, di
  0530e  lcall 0x7d6, 0x227f
  05313  lcall 0x7d6, 0x1017
  05318  lcall 0x7d6, 0x3021
  0531d  mov bx, 5
  05320  lcall 0x7d6, 0x23be
  05325  lcall 0x7d6, 0x2d79
  0532a  mov bx, 0xf
  0532d  lcall 0x7d6, 0xffd
  05332  mov bx, 9
  05335  lcall 0x7d6, 0x1017
  0533a  lcall 0x7d6, 0x3021
  0533f  mov bx, 0x2290  ; '  '
  05342  lcall 0x7d6, 0x2d79
  05347  mov di, 0xf26
  0534a  mov si, 0x2296
  0534d  lcall 0x7d6, 0x10a6
  05352  mov bx, 0x32
  05355  mov dx, 0x1040
  05358  lcall 0x7d6, 0x635
  0535d  mov si, dx
  0535f  mov di, 0xfb2
  05362  lcall 0x7d6, 0x10a6
  05367  mov bx, 0x1ed8  ; 'Done.'
  0536a  mov dx, 0xed2
  0536d  lcall 0x7d6, 0xf62
  05372  jmp 0x1bd7
L5375:
  05375  mov bx, 0x12e0  ; 'LOCK'
  05378  mov ax, 0xfde
  0537b  lcall 0x7d6, 0xfd2
  05380  je 0x5385
  05382  jmp 0x53f6
L5385:
  05385  mov bx, 9
  05388  lcall 0x7d6, 0xffd
  0538d  mov bx, 0xe
  05390  lcall 0x7d6, 0x1017
  05395  lcall 0x7d6, 0x3021
  0539a  mov dx, bx
  0539c  mov bx, 8
  0539f  mov cx, bx
  053a1  lcall 0x7d6, 0x23be
  053a6  lcall 0x7d6, 0x2d8d
  053ab  mov bx, 0xa
  053ae  lcall 0x7d6, 0xffd
  053b3  mov bx, dx
  053b5  lcall 0x7d6, 0x1017
  053ba  lcall 0x7d6, 0x3021
  053bf  mov bx, cx
  053c1  lcall 0x7d6, 0x23be
  053c6  lcall 0x7d6, 0x2d79
  053cb  mov di, 0xf2a
  053ce  mov si, 0x1040
  053d1  lcall 0x7d6, 0x10a6
  053d6  mov di, 0xfb2
  053d9  lcall 0x7d6, 0x10a6
  053de  mov bx, 0x1ed8  ; 'Done.'
  053e1  mov dx, 0xed2
  053e4  lcall 0x7d6, 0xf62
  053e9  mov dx, si
  053eb  mov bx, 0x32
  053ee  lcall 0x7d6, 0x635
  053f3  jmp 0x1bd7
L53F6:
  053f6  mov si, 0xf1e
  053f9  lcall 0x7d6, 0x227f
  053fe  lcall 0x7d6, 0xffd
  05403  mov si, 0xf22
  05406  mov dx, si
  05408  lcall 0x7d6, 0x227f
  0540d  lcall 0x7d6, 0x1017
  05412  lcall 0x7d6, 0x3021
  05417  mov si, 0xfae
  0541a  lcall 0x7d6, 0x227f
  0541f  lcall 0x7d6, 0x23be
  05424  lcall 0x7d6, 0x2d79
  05429  mov si, dx
  0542b  mov di, 0x114a
  0542e  lcall 0x7d6, 0x19ce
  05433  jb 0x5438
  05435  jmp 0x5445
L5438:
  05438  mov di, dx
  0543a  mov si, 0x1146
  0543d  lcall 0x7d6, 0x10a6
  05442  jmp 0x5450
L5445:
  05445  mov di, 0xf22
  05448  mov si, 0x1044
  0544b  lcall 0x7d6, 0x10a6
L5450:
  05450  mov di, 0xf1e
  05453  mov si, 0x1066
  05456  lcall 0x7d6, 0x10a6
  0545b  mov si, di
  0545d  lcall 0x7d6, 0x227f
  05462  lcall 0x7d6, 0xffd
  05467  mov si, 0xf22
  0546a  lcall 0x7d6, 0x227f
  0546f  lcall 0x7d6, 0x1017
  05474  lcall 0x7d6, 0x3021
  05479  mov bx, 5
  0547c  lcall 0x7d6, 0x23be
  05481  lcall 0x7d6, 0x2d79
  05486  mov bx, 9
  05489  lcall 0x7d6, 0xffd
  0548e  mov bx, 0xe
  05491  lcall 0x7d6, 0x1017
  05496  lcall 0x7d6, 0x3021
  0549b  mov dx, bx
  0549d  mov bx, 0x10a4  ; ' '
  054a0  lcall 0x7d6, 0x2d79
  054a5  mov cx, bx
  054a7  mov bx, 0xa
  054aa  lcall 0x7d6, 0xffd
  054af  mov bx, dx
  054b1  lcall 0x7d6, 0x1017
  054b6  lcall 0x7d6, 0x3021
  054bb  mov bx, cx
  054bd  lcall 0x7d6, 0x2d79
  054c2  mov di, 0xf2a
  054c5  mov si, 0x2296
  054c8  lcall 0x7d6, 0x10a6
  054cd  mov bx, 0x32
  054d0  mov dx, 0x1040
  054d3  lcall 0x7d6, 0x635
  054d8  mov si, dx
  054da  mov di, 0xfb2
  054dd  lcall 0x7d6, 0x10a6
  054e2  mov bx, 0x1ed8  ; 'Done.'
  054e5  mov dx, 0xed2
  054e8  lcall 0x7d6, 0xf62
  054ed  jmp 0x1bd7
; ---- gap 0x54f0-0x5509 (25 bytes)
L5509:
  05509  mov bx, 0x229a  ; 'BOOK'
  0550c  mov ax, 0xfe2
  0550f  lcall 0x7d6, 0xfd2
  05514  jne 0x5519
  05516  jmp 0x553d
L5519:
  05519  mov di, 0xfb2
  0551c  mov si, 0x11d6
  0551f  lcall 0x7d6, 0x10a6
  05524  mov bx, 0x22a2  ; " You can't"
  05527  mov dx, 0xed2
  0552a  lcall 0x7d6, 0xf62
  0552f  mov bx, 0x22b0  ; ' read That!'
  05532  mov dx, 0xed6
  05535  lcall 0x7d6, 0xf62
  0553a  jmp 0x1bd7
L553D:
  0553d  mov si, 0xc36
  05540  lcall 0x7d6, 0x26aa
  05545  jne 0x554a
  05547  jmp 0x556e
L554A:
  0554a  mov di, 0xfb2
  0554d  mov si, 0x11d6
  05550  lcall 0x7d6, 0x10a6
  05555  mov bx, 0x1f56  ; " You don't"
  05558  mov dx, 0xed2
  0555b  lcall 0x7d6, 0xf62
  05560  mov bx, 0x22c0  ; ' have a book!'
  05563  mov dx, 0xed6
  05566  lcall 0x7d6, 0xf62
  0556b  jmp 0x1bd7
L556E:
  0556e  mov si, 0xc46
  05571  lcall 0x7d6, 0x26aa
  05576  jne 0x557b
  05578  jmp 0x55b5
L557B:
  0557b  mov di, 0xfb2
  0557e  mov si, 0x1090
  05581  lcall 0x7d6, 0x10a6
  05586  mov bx, 0x22d2  ; " You can't see"
  05589  mov dx, 0xed2
  0558c  lcall 0x7d6, 0xf62
  05591  mov bx, 0x22e4  ; ' well enough.'
  05594  mov dx, 0xed6
  05597  lcall 0x7d6, 0xf62
  0559c  mov bx, 0x22f6  ; " It's all"
  0559f  mov dx, 0xeda
  055a2  lcall 0x7d6, 0xf62
  055a7  mov bx, 0x2304  ; ' Blurry.'
  055aa  mov dx, 0xede
  055ad  lcall 0x7d6, 0xf62
  055b2  jmp 0x1bd7
L55B5:
  055b5  mov di, 0xfb2
  055b8  mov si, 0x10be
  055bb  lcall 0x7d6, 0x10a6
  055c0  mov bx, 0x2310  ; 'The book reads:'
  055c3  mov dx, 0xed2
  055c6  lcall 0x7d6, 0xf62
  055cb  mov bx, 0x106a  ; ''
  055ce  mov dx, 0xed6
  055d1  lcall 0x7d6, 0xf62
  055d6  mov bx, 0x2324  ; '  Wave Scepter'
  055d9  mov dx, 0xeda
  055dc  lcall 0x7d6, 0xf62
  055e1  jmp 0x1bd7
L55E4:
  055e4  mov bx, 0x2336  ; 'DOWN'
  055e7  mov ax, 0xfe2
  055ea  lcall 0x7d6, 0xfd2
  055ef  je 0x55f4
  055f1  jmp 0x565b
L55F4:
  055f4  mov di, 0x1ce4
  055f7  mov si, 0xf1a
  055fa  lcall 0x7d6, 0x19ce
  055ff  mov bx, 0
  05602  jne 0x5605
  05604  dec bx
L5605:
  05605  mov di, 0x233e
  05608  lcall 0x7d6, 0x19ce
  0560d  mov dx, 0
  05610  jne 0x5613
  05612  dec dx
L5613:
  05613  or dx, bx
  05615  mov di, 0x1192
  05618  lcall 0x7d6, 0x19ce
  0561d  mov bx, 0
  05620  jne 0x5623
  05622  dec bx
L5623:
  05623  or bx, dx
  05625  and bx, bx
  05627  jne 0x562c
  05629  jmp 0x565b
L562C:
  0562c  mov di, 0xfb2
  0562f  mov si, 0x10be
  05632  lcall 0x7d6, 0x10a6
  05637  mov bx, 0x2342  ; " I don't think"
  0563a  mov dx, 0xed2
  0563d  lcall 0x7d6, 0xf62
  05642  mov bx, 0x2354  ; " it's safe to"
  05645  mov dx, 0xed6
  05648  lcall 0x7d6, 0xf62
  0564d  mov bx, 0x2366  ; ' Jump here!'
  05650  mov dx, 0xeda
  05653  lcall 0x7d6, 0xf62
  05658  jmp 0x1bd7
L565B:
  0565b  mov di, 0xfb2
  0565e  mov si, 0x10be
  05661  lcall 0x7d6, 0x10a6
  05666  mov bx, 0x2376  ; 'I Jumped.'
  05669  mov dx, 0xed2
  0566c  lcall 0x7d6, 0xf62
  05671  mov bx, 0x106a  ; ''
  05674  mov dx, 0xed6
  05677  lcall 0x7d6, 0xf62
  0567c  mov bx, 0x2384  ; 'This is boring.'
  0567f  mov dx, 0xeda
  05682  lcall 0x7d6, 0xf62
  05687  jmp 0x1bd7
L568A:
  0568a  mov bx, 0xd
  0568d  lcall 0x7d6, 0xffd
  05692  mov bx, 0xb
  05695  lcall 0x7d6, 0x1017
  0569a  lcall 0x7d6, 0x3021
  0569f  mov dx, bx
  056a1  mov bx, 0x2398  ; '▓'
  056a4  lcall 0x7d6, 0x2d79
  056a9  mov cx, bx
  056ab  mov bx, 0xe
  056ae  lcall 0x7d6, 0xffd
  056b3  mov bx, dx
  056b5  lcall 0x7d6, 0x1017
  056ba  lcall 0x7d6, 0x3021
  056bf  mov bx, cx
  056c1  lcall 0x7d6, 0x2d79
  056c6  mov bx, 0xd
  056c9  lcall 0x7d6, 0xffd
  056ce  mov bx, 0x11
  056d1  lcall 0x7d6, 0x1017
  056d6  lcall 0x7d6, 0x3021
  056db  mov dx, bx
  056dd  mov bx, 0x2398  ; '▓'
  056e0  lcall 0x7d6, 0x2d79
  056e5  mov cx, bx
  056e7  mov bx, 0xe
  056ea  lcall 0x7d6, 0xffd
  056ef  mov bx, dx
  056f1  lcall 0x7d6, 0x1017
  056f6  lcall 0x7d6, 0x3021
  056fb  mov bx, cx
  056fd  lcall 0x7d6, 0x2d79
  05702  mov si, 0x10b6
  05705  lcall 0x7d6, 0x10bd
  0570a  jmp 0x5783
L570D:
  0570d  mov si, 0x1040
  05710  lcall 0x7d6, 0x10bd
  05715  jmp 0x5723
L5718:
  05718  mov di, 0x1040
  0571b  mov si, 0xf92
  0571e  lcall 0x7d6, 0x1772
L5723:
  05723  mov di, 0xf92
  05726  lcall 0x7d6, 0x10a3
  0572b  mov si, di
  0572d  mov di, 0x113a
  05730  lcall 0x7d6, 0x19ce
  05735  jbe 0x5718
  05737  mov bx, 0xd
  0573a  lcall 0x7d6, 0xffd
  0573f  mov si, 0xf32
  05742  lcall 0x7d6, 0x227f
  05747  lcall 0x7d6, 0x1017
  0574c  lcall 0x7d6, 0x3021
  05751  mov dx, bx
  05753  mov bx, 0x239e  ; '░'
  05756  lcall 0x7d6, 0x2d79
  0575b  mov cx, bx
  0575d  mov bx, 0xe
  05760  lcall 0x7d6, 0xffd
  05765  mov bx, dx
  05767  lcall 0x7d6, 0x1017
  0576c  lcall 0x7d6, 0x3021
  05771  mov bx, cx
  05773  lcall 0x7d6, 0x2d79
  05778  mov di, 0x1040
  0577b  mov si, 0xf32
  0577e  lcall 0x7d6, 0x1772
L5783:
  05783  mov di, 0xf32
  05786  lcall 0x7d6, 0x10a3
  0578b  mov si, di
  0578d  mov di, 0x228c
  05790  lcall 0x7d6, 0x19ce
  05795  ja 0x579a
  05797  jmp 0x570d
L579A:
  0579a  mov di, 0xfb2
  0579d  mov si, 0x1098
  057a0  lcall 0x7d6, 0x10a6
  057a5  mov bx, 0x23a4  ; 'You have sprung'
  057a8  mov dx, 0xed2
  057ab  lcall 0x7d6, 0xf62
  057b0  mov bx, 0x23b8  ; 'a Trap!! The'
  057b3  mov dx, 0xed6
  057b6  lcall 0x7d6, 0xf62
  057bb  mov bx, 0x23c8  ; 'room has filled'
  057be  mov dx, 0xeda
  057c1  lcall 0x7d6, 0xf62
  057c6  mov bx, 0x23dc  ; 'with water and'
  057c9  mov dx, 0xede
  057cc  lcall 0x7d6, 0xf62
  057d1  mov bx, 0x23ee  ; 'you drowned!'
  057d4  mov dx, 0xee2
  057d7  lcall 0x7d6, 0xf62
  057dc  jmp 0x63b0
L57DF:
  057df  mov bx, 9
  057e2  lcall 0x7d6, 0xffd
  057e7  mov dx, bx
  057e9  mov bx, 0xc
  057ec  lcall 0x7d6, 0x1017
  057f1  lcall 0x7d6, 0x3021
  057f6  mov bx, 0x2398  ; '▓'
  057f9  lcall 0x7d6, 0x2d79
  057fe  mov cx, bx
  05800  mov bx, dx
  05802  lcall 0x7d6, 0xffd
  05807  mov bx, 0x18
  0580a  lcall 0x7d6, 0x1017
  0580f  lcall 0x7d6, 0x3021
  05814  mov bx, cx
  05816  lcall 0x7d6, 0x2d79
  0581b  mov bx, 0xa
  0581e  lcall 0x7d6, 0xffd
  05823  mov dx, bx
  05825  mov bx, 0xc
  05828  lcall 0x7d6, 0x1017
  0582d  lcall 0x7d6, 0x3021
  05832  mov bx, 0x2398  ; '▓'
  05835  lcall 0x7d6, 0x2d79
  0583a  mov cx, bx
  0583c  mov bx, dx
  0583e  lcall 0x7d6, 0xffd
  05843  mov bx, 0x18
  05846  lcall 0x7d6, 0x1017
  0584b  lcall 0x7d6, 0x3021
  05850  mov bx, cx
  05852  lcall 0x7d6, 0x2d79
  05857  mov si, 0x1146
  0585a  lcall 0x7d6, 0x10bd
  0585f  jmp 0x58d8
L5862:
  05862  mov si, 0x1040
  05865  lcall 0x7d6, 0x10bd
  0586a  jmp 0x5878
L586D:
  0586d  mov di, 0x1040
  05870  mov si, 0xf92
  05873  lcall 0x7d6, 0x1772
L5878:
  05878  mov di, 0xf92
  0587b  lcall 0x7d6, 0x10a3
  05880  mov si, di
  05882  mov di, 0x113a
  05885  lcall 0x7d6, 0x19ce
  0588a  jbe 0x586d
  0588c  mov bx, 9
  0588f  lcall 0x7d6, 0xffd
  05894  mov si, 0xf32
  05897  lcall 0x7d6, 0x227f
  0589c  lcall 0x7d6, 0x1017
  058a1  lcall 0x7d6, 0x3021
  058a6  mov dx, bx
  058a8  mov bx, 0x239e  ; '░'
  058ab  lcall 0x7d6, 0x2d79
  058b0  mov cx, bx
  058b2  mov bx, 0xa
  058b5  lcall 0x7d6, 0xffd
  058ba  mov bx, dx
  058bc  lcall 0x7d6, 0x1017
  058c1  lcall 0x7d6, 0x3021
  058c6  mov bx, cx
  058c8  lcall 0x7d6, 0x2d79
  058cd  mov di, 0x1040
  058d0  mov si, 0xf32
  058d3  lcall 0x7d6, 0x1772
L58D8:
  058d8  mov di, 0xf32
  058db  lcall 0x7d6, 0x10a3
  058e0  mov si, di
  058e2  mov di, 0x23fe
  058e5  lcall 0x7d6, 0x19ce
  058ea  ja 0x58ef
  058ec  jmp 0x5862
L58EF:
  058ef  jmp 0x579a
L58F2:
  058f2  mov bx, 0x1280  ; 'WATER'
  058f5  mov ax, 0xfe2
  058f8  lcall 0x7d6, 0xfd2
  058fd  jne 0x5902
  058ff  jmp 0x5935
L5902:
  05902  mov di, 0xfb2
  05905  mov si, 0x11d6
  05908  lcall 0x7d6, 0x10a6
  0590d  mov bx, 0x1dac  ; "You don't have"
  05910  mov dx, 0xed2
  05913  lcall 0x7d6, 0xf62
  05918  xchg bx, ax
  05919  mov ax, 0x2402  ; 'any '
  0591c  lcall 0x7d6, 0xf98
  05921  xchg bx, ax
  05922  mov bx, 0x1512  ; '!'
  05925  lcall 0x7d6, 0xf98
  0592a  mov dx, 0xed6
  0592d  lcall 0x7d6, 0xf62
  05932  jmp 0x1bd7
L5935:
  05935  mov si, 0x1006
  05938  lcall 0x7d6, 0x26aa
  0593d  mov bx, 0
  05940  jne 0x5943
  05942  dec bx
L5943:
  05943  mov si, 0xc52
  05946  lcall 0x7d6, 0x26aa
  0594b  mov dx, 0
  0594e  je 0x5951
  05950  dec dx
L5951:
  05951  or dx, bx
  05953  and dx, dx
  05955  jne 0x595a
  05957  jmp 0x598f
L595A:
  0595a  mov di, 0xfb2
  0595d  mov si, 0x11d6
  05960  lcall 0x7d6, 0x10a6
  05965  mov bx, 0x1dac  ; "You don't have"
  05968  mov dx, 0xed2
  0596b  lcall 0x7d6, 0xf62
  05970  mov bx, 0xfe2
  05973  mov ax, 0x2402  ; 'any '
  05976  lcall 0x7d6, 0xf98
  0597b  xchg bx, ax
  0597c  mov bx, 0x1512  ; '!'
  0597f  lcall 0x7d6, 0xf98
  05984  mov dx, 0xed6
  05987  lcall 0x7d6, 0xf62
  0598c  jmp 0x1bd7
L598F:
  0598f  mov si, 0x1012
  05992  lcall 0x7d6, 0x26aa
  05997  je 0x599c
  05999  jmp 0x59eb
L599C:
  0599c  mov di, si
  0599e  mov si, 0x1040
  059a1  lcall 0x7d6, 0x10a6
  059a6  mov di, 0xf2e
  059a9  mov si, 0x1048
  059ac  lcall 0x7d6, 0x10a6
  059b1  mov di, 0x1006
  059b4  mov si, 0x113e
  059b7  lcall 0x7d6, 0x10a6
  059bc  mov di, 0xfb2
  059bf  mov si, 0x10be
  059c2  lcall 0x7d6, 0x10a6
  059c7  mov bx, 0x240a  ; 'That was good!'
  059ca  mov dx, 0xed2
  059cd  lcall 0x7d6, 0xf62
  059d2  mov bx, 0x241c  ; 'I feel much'
  059d5  mov dx, 0xed6
  059d8  lcall 0x7d6, 0xf62
  059dd  mov bx, 0x242c  ; 'better now!'
  059e0  mov dx, 0xeda
  059e3  lcall 0x7d6, 0xf62
  059e8  jmp 0x1bd7
L59EB:
  059eb  mov di, 0xfb2
  059ee  mov si, 0x1040
  059f1  lcall 0x7d6, 0x10a6
  059f6  mov bx, 0x243c  ; 'That was good.'
  059f9  mov dx, 0xed2
  059fc  lcall 0x7d6, 0xf62
  05a01  jmp 0x1bd7
L5A04:
  05a04  mov bx, 0x1280  ; 'WATER'
  05a07  mov ax, 0xfe2
  05a0a  lcall 0x7d6, 0xfd2
  05a0f  jne 0x5a14
  05a11  jmp 0x5a38
L5A14:
  05a14  mov di, 0xfb2
  05a17  mov si, 0x11d6
  05a1a  lcall 0x7d6, 0x10a6
  05a1f  mov bx, 0x1f56  ; " You don't"
  05a22  mov dx, 0xed2
  05a25  lcall 0x7d6, 0xf62
  05a2a  mov bx, 0x244e  ; ' have any.'
  05a2d  mov dx, 0xed6
  05a30  lcall 0x7d6, 0xf62
  05a35  jmp 0x1bd7
L5A38:
  05a38  mov si, 0x1006
  05a3b  lcall 0x7d6, 0x26aa
  05a40  mov bx, 0
  05a43  jne 0x5a46
  05a45  dec bx
L5A46:
  05a46  mov si, 0xc52
  05a49  lcall 0x7d6, 0x26aa
  05a4e  mov dx, 0
  05a51  je 0x5a54
  05a53  dec dx
L5A54:
  05a54  or dx, bx
  05a56  and dx, dx
  05a58  jne 0x5a5d
  05a5a  jmp 0x5a81
L5A5D:
  05a5d  mov di, 0xfb2
  05a60  mov si, 0x11d6
  05a63  lcall 0x7d6, 0x10a6
  05a68  mov bx, 0x245c  ; "You don't"
  05a6b  mov dx, 0xed2
  05a6e  lcall 0x7d6, 0xf62
  05a73  mov bx, 0x246a  ; 'have any.'
  05a76  mov dx, 0xed6
  05a79  lcall 0x7d6, 0xf62
  05a7e  jmp 0x1bd7
L5A81:
  05a81  mov di, 0x1006
  05a84  mov si, 0x1088
  05a87  lcall 0x7d6, 0x10a6
  05a8c  mov di, 0xfb2
  05a8f  mov si, 0x1090
  05a92  lcall 0x7d6, 0x10a6
  05a97  mov bx, 0x2478  ; 'You pour the'
  05a9a  mov dx, 0xed2
  05a9d  lcall 0x7d6, 0xf62
  05aa2  mov bx, 0x2488  ; 'water & it'
  05aa5  mov dx, 0xed6
  05aa8  lcall 0x7d6, 0xf62
  05aad  mov bx, 0x2496  ; 'spills on'
  05ab0  mov dx, 0xeda
  05ab3  lcall 0x7d6, 0xf62
  05ab8  mov bx, 0x24a4  ; 'the ground.'
  05abb  mov dx, 0xede
  05abe  lcall 0x7d6, 0xf62
  05ac3  mov si, 0xc7a
  05ac6  lcall 0x7d6, 0x26aa
  05acb  je 0x5ad0
  05acd  jmp 0x5af1
L5AD0:
  05ad0  mov di, 0xfb2
  05ad3  mov si, 0x1468
  05ad6  lcall 0x7d6, 0x10a6
  05adb  mov bx, 0x24b4  ; 'The goblet had'
  05ade  mov dx, 0xee2
  05ae1  lcall 0x7d6, 0xf62
  05ae6  mov bx, 0x24c6  ; 'a hole in it!'
  05ae9  mov dx, 0xee6
  05aec  lcall 0x7d6, 0xf62
L5AF1:
  05af1  jmp 0x1bd7
L5AF4:
  05af4  mov si, 0x1040
  05af7  lcall 0x7d6, 0x10bd
  05afc  jmp 0x5bdc
L5AFF:
  05aff  mov si, 0xf32
  05b02  lcall 0x7d6, 0x227f
  05b07  shl bx, 1
  05b09  shl bx, 1
  05b0b  add bx, 0xe1a
  05b0f  mov dx, 0xfd6
  05b12  lcall 0x7d6, 0xf62
  05b17  mov bx, 0x20
  05b1a  lcall 0x7d6, 0x23be
  05b1f  xchg bx, dx
  05b21  mov cx, bx
  05b23  lcall 0x7d6, 0x245e
  05b28  lcall 0x7d6, 0x2237
  05b2d  mov di, 0xffa
  05b30  lcall 0x7d6, 0x10a3
  05b35  mov si, di
  05b37  lcall 0x7d6, 0x26aa
  05b3c  ja 0x5b41
  05b3e  jmp 0x5b68
L5B41:
  05b41  mov bx, cx
  05b43  lcall 0x7d6, 0x2386
  05b48  lcall 0x7d6, 0x2237
  05b4d  lcall 0x7d6, 0x1752
  05b52  lcall 0x7d6, 0x22ca
  05b57  mov ax, bx
  05b59  mov bx, cx
  05b5b  xchg dx, ax
  05b5c  lcall 0x7d6, 0x2478  ; 'You pour the'
  05b61  mov dx, cx
  05b63  lcall 0x7d6, 0xf62
L5B68:
  05b68  mov bx, 0xfe2
  05b6b  mov ax, 0xfd6
  05b6e  lcall 0x7d6, 0xfd2
  05b73  mov dx, 0
  05b76  jne 0x5b79
  05b78  dec dx
L5B79:
  05b79  mov si, 0xf32
  05b7c  lcall 0x7d6, 0x227f
  05b81  mov si, bx
  05b83  shl si, 1
  05b85  shl si, 1
  05b87  add si, 0xd96
  05b8b  mov di, 0xf1a
  05b8e  lcall 0x7d6, 0x19ce
  05b93  mov bx, 0
  05b96  jne 0x5b99
  05b98  dec bx
L5B99:
  05b99  and bx, dx
  05b9b  and bx, bx
  05b9d  jne 0x5ba2
  05b9f  jmp 0x5bd1
L5BA2:
  05ba2  mov di, 0xfb2
  05ba5  mov si, 0x10be
  05ba8  lcall 0x7d6, 0x10a6
  05bad  mov bx, 0x1e1e  ; "I don't think"
  05bb0  mov dx, 0xed2
  05bb3  lcall 0x7d6, 0xf62
  05bb8  mov bx, 0x1e30  ; 'that would be'
  05bbb  mov dx, 0xed6
  05bbe  lcall 0x7d6, 0xf62
  05bc3  mov bx, 0x24d8  ; 'advisable!'
  05bc6  mov dx, 0xeda
  05bc9  lcall 0x7d6, 0xf62
  05bce  jmp 0x1bd7
L5BD1:
  05bd1  mov di, 0x1040
  05bd4  mov si, 0xf32
  05bd7  lcall 0x7d6, 0x1772
L5BDC:
  05bdc  mov di, 0xf32
  05bdf  lcall 0x7d6, 0x10a3
  05be4  mov si, di
  05be6  mov di, 0x1050
  05be9  lcall 0x7d6, 0x19ce
  05bee  ja 0x5bf3
  05bf0  jmp 0x5aff
L5BF3:
  05bf3  mov di, 0xfb2
  05bf6  mov si, 0x11d6
  05bf9  lcall 0x7d6, 0x10a6
  05bfe  mov bx, 0x24e6  ; "I can't pet"
  05c01  mov dx, 0xed2
  05c04  lcall 0x7d6, 0xf62
  05c09  mov bx, 0xfe2
  05c0c  mov ax, 0x167e  ; 'a '
  05c0f  lcall 0x7d6, 0xf98
  05c14  xchg bx, ax
  05c15  mov bx, 0x1512  ; '!'
  05c18  lcall 0x7d6, 0xf98
  05c1d  mov dx, 0xed6
  05c20  lcall 0x7d6, 0xf62
  05c25  jmp 0x1bd7
L5C28:
  05c28  mov si, 0x1040
  05c2b  lcall 0x7d6, 0x10bd
  05c30  jmp 0x5cfa
L5C33:
  05c33  mov si, 0xf32
  05c36  lcall 0x7d6, 0x227f
  05c3b  shl bx, 1
  05c3d  shl bx, 1
  05c3f  add bx, 0xe1a
  05c43  mov dx, 0xfd6
  05c46  lcall 0x7d6, 0xf62
  05c4b  mov bx, 0x20
  05c4e  lcall 0x7d6, 0x23be
  05c53  xchg bx, dx
  05c55  mov cx, bx
  05c57  lcall 0x7d6, 0x245e
  05c5c  lcall 0x7d6, 0x2237
  05c61  mov di, 0xffa
  05c64  lcall 0x7d6, 0x10a3
  05c69  mov si, di
  05c6b  lcall 0x7d6, 0x26aa
  05c70  ja 0x5c75
  05c72  jmp 0x5c9c
L5C75:
  05c75  mov bx, cx
  05c77  lcall 0x7d6, 0x2386
  05c7c  lcall 0x7d6, 0x2237
  05c81  lcall 0x7d6, 0x1752
  05c86  lcall 0x7d6, 0x22ca
  05c8b  mov ax, bx
  05c8d  mov bx, cx
  05c8f  xchg dx, ax
  05c90  lcall 0x7d6, 0x2478  ; 'You pour the'
  05c95  mov dx, cx
  05c97  lcall 0x7d6, 0xf62
L5C9C:
  05c9c  mov bx, 0xfe2
  05c9f  mov ax, 0xfd6
  05ca2  lcall 0x7d6, 0xfd2
  05ca7  mov dx, 0
  05caa  jne 0x5cad
  05cac  dec dx
L5CAD:
  05cad  mov si, 0xf32
  05cb0  lcall 0x7d6, 0x227f
  05cb5  mov si, bx
  05cb7  shl si, 1
  05cb9  shl si, 1
  05cbb  add si, 0xd96
  05cbf  mov di, 0xf1a
  05cc2  lcall 0x7d6, 0x19ce
  05cc7  mov bx, 0
  05cca  jne 0x5ccd
  05ccc  dec bx
L5CCD:
  05ccd  and bx, dx
  05ccf  and bx, bx
  05cd1  jne 0x5cd6
  05cd3  jmp 0x5cef
L5CD6:
  05cd6  mov di, 0xfb2
  05cd9  mov si, 0x1040
  05cdc  lcall 0x7d6, 0x10a6
  05ce1  mov bx, 0x24f6  ; 'Do it yourself!'
  05ce4  mov dx, 0xed2
  05ce7  lcall 0x7d6, 0xf62
  05cec  jmp 0x1bd7
L5CEF:
  05cef  mov di, 0x1040
  05cf2  mov si, 0xf32
  05cf5  lcall 0x7d6, 0x1772
L5CFA:
  05cfa  mov di, 0xf32
  05cfd  lcall 0x7d6, 0x10a3
  05d02  mov si, di
  05d04  mov di, 0x1050
  05d07  lcall 0x7d6, 0x19ce
  05d0c  ja 0x5d11
  05d0e  jmp 0x5c33
L5D11:
  05d11  mov di, 0xfb2
  05d14  mov si, 0x11d6
  05d17  lcall 0x7d6, 0x10a6
  05d1c  mov bx, 0x250a  ; "I can't kill"
  05d1f  mov dx, 0xed2
  05d22  lcall 0x7d6, 0xf62
  05d27  mov bx, 0xfe2
  05d2a  mov ax, 0x167e  ; 'a '
  05d2d  lcall 0x7d6, 0xf98
  05d32  xchg bx, ax
  05d33  mov bx, 0x1512  ; '!'
  05d36  lcall 0x7d6, 0xf98
  05d3b  mov dx, 0xed6
  05d3e  lcall 0x7d6, 0xf62
  05d43  jmp 0x1bd7
L5D46:
  05d46  mov si, 0x1040
  05d49  lcall 0x7d6, 0x10bd
  05d4e  jmp 0x5dfc
L5D51:
  05d51  mov si, 0xf32
  05d54  lcall 0x7d6, 0x227f
  05d59  shl bx, 1
  05d5b  shl bx, 1
  05d5d  add bx, 0xc82
  05d61  mov dx, 0xfd6
  05d64  lcall 0x7d6, 0xf62
  05d69  mov bx, 0x20
  05d6c  lcall 0x7d6, 0x23be
  05d71  xchg bx, dx
  05d73  mov cx, bx
  05d75  lcall 0x7d6, 0x245e
  05d7a  lcall 0x7d6, 0x2237
  05d7f  mov di, 0xffa
  05d82  lcall 0x7d6, 0x10a3
  05d87  mov si, di
  05d89  lcall 0x7d6, 0x26aa
  05d8e  ja 0x5d93
  05d90  jmp 0x5dba
L5D93:
  05d93  mov bx, cx
  05d95  lcall 0x7d6, 0x2386
  05d9a  lcall 0x7d6, 0x2237
  05d9f  lcall 0x7d6, 0x1752
  05da4  lcall 0x7d6, 0x22ca
  05da9  mov ax, bx
  05dab  mov bx, cx
  05dad  xchg dx, ax
  05dae  lcall 0x7d6, 0x2478  ; 'You pour the'
  05db3  mov dx, cx
  05db5  lcall 0x7d6, 0xf62
L5DBA:
  05dba  mov bx, 0xfe2
  05dbd  mov ax, 0xfd6
  05dc0  lcall 0x7d6, 0xfd2
  05dc5  mov dx, 0
  05dc8  jne 0x5dcb
  05dca  dec dx
L5DCB:
  05dcb  mov si, 0xf32
  05dce  lcall 0x7d6, 0x227f
  05dd3  mov si, bx
  05dd5  shl si, 1
  05dd7  shl si, 1
  05dd9  add si, 0xc26
  05ddd  lcall 0x7d6, 0x26aa
  05de2  mov bx, 0
  05de5  jne 0x5de8
  05de7  dec bx
L5DE8:
  05de8  and bx, dx
  05dea  and bx, bx
  05dec  je 0x5df1
  05dee  jmp 0x5e48
L5DF1:
  05df1  mov di, 0x1040
  05df4  mov si, 0xf32
  05df7  lcall 0x7d6, 0x1772
L5DFC:
  05dfc  mov di, 0xf32
  05dff  lcall 0x7d6, 0x10a3
  05e04  mov si, di
  05e06  mov di, 0x104c
  05e09  lcall 0x7d6, 0x19ce
  05e0e  ja 0x5e13
  05e10  jmp 0x5d51
L5E13:
  05e13  mov di, 0xfb2
  05e16  mov si, 0x11d6
  05e19  lcall 0x7d6, 0x10a6
  05e1e  mov bx, 0x251a  ; "I don't have"
  05e21  mov dx, 0xed2
  05e24  lcall 0x7d6, 0xf62
  05e29  mov bx, 0xfe2
  05e2c  mov ax, 0x167e  ; 'a '
  05e2f  lcall 0x7d6, 0xf98
  05e34  xchg bx, ax
  05e35  mov bx, 0x252a  ; '.'
  05e38  lcall 0x7d6, 0xf98
  05e3d  mov dx, 0xed6
  05e40  lcall 0x7d6, 0xf62
  05e45  jmp 0x1bd7
L5E48:
  05e48  mov di, 0x10b6
  05e4b  mov si, 0xf32
  05e4e  lcall 0x7d6, 0x19ce
  05e53  je 0x5e58
  05e55  jmp 0x5edc
L5E58:
  05e58  mov di, 0xf1a
  05e5b  mov si, 0xdba
  05e5e  lcall 0x7d6, 0x19ce
  05e63  je 0x5e68
  05e65  jmp 0x5edc
L5E68:
  05e68  mov di, 0xfb2
  05e6b  mov bx, si
  05e6d  mov si, 0x1090
  05e70  lcall 0x7d6, 0x10a6
  05e75  mov cx, bx
  05e77  mov bx, 0x2096  ; 'The vampire'
  05e7a  mov dx, 0xed2
  05e7d  lcall 0x7d6, 0xf62
  05e82  mov bx, 0x20a6  ; 'sees the holy'
  05e85  mov dx, 0xed6
  05e88  lcall 0x7d6, 0xf62
  05e8d  mov bx, 0x20b8  ; 'cross and'
  05e90  mov dx, 0xeda
  05e93  lcall 0x7d6, 0xf62
  05e98  mov bx, 0x20c6  ; 'disappears!'
  05e9b  mov dx, 0xede
  05e9e  lcall 0x7d6, 0xf62
  05ea3  mov si, 0xde6
  05ea6  lcall 0x7d6, 0x227f
  05eab  lcall 0x7d6, 0xffd
  05eb0  mov si, 0xe12
  05eb3  lcall 0x7d6, 0x227f
  05eb8  lcall 0x7d6, 0x1017
  05ebd  lcall 0x7d6, 0x3021
  05ec2  mov bx, 0x20
  05ec5  lcall 0x7d6, 0x23be
  05eca  lcall 0x7d6, 0x2d79
  05ecf  mov di, cx
  05ed1  mov si, 0x1088
  05ed4  lcall 0x7d6, 0x10a6
  05ed9  jmp 0x1bd7
L5EDC:
  05edc  mov di, 0xf1a
  05edf  mov si, 0xdba
  05ee2  lcall 0x7d6, 0x19ce
  05ee7  mov bx, 0
  05eea  jne 0x5eed
  05eec  dec bx
L5EED:
  05eed  mov si, 0xdbe
  05ef0  lcall 0x7d6, 0x19ce
  05ef5  mov dx, 0
  05ef8  jne 0x5efb
  05efa  dec dx
L5EFB:
  05efb  or dx, bx
  05efd  and dx, dx
  05eff  jne 0x5f04
  05f01  jmp 0x5f1d
L5F04:
  05f04  mov di, 0xfb2
  05f07  mov si, 0x1098
  05f0a  lcall 0x7d6, 0x10a6
  05f0f  mov bx, 0x106a  ; ''
  05f12  mov dx, 0xed2
  05f15  lcall 0x7d6, 0xf62
  05f1a  jmp 0x4eea
L5F1D:
  05f1d  mov di, 0x1040
  05f20  mov si, 0xfaa
  05f23  lcall 0x7d6, 0x19ce
  05f28  je 0x5f2d
  05f2a  jmp 0x5f46
L5F2D:
  05f2d  mov di, 0xfb2
  05f30  mov si, 0x1098
  05f33  lcall 0x7d6, 0x10a6
  05f38  mov bx, 0x106a  ; ''
  05f3b  mov dx, 0xed2
  05f3e  lcall 0x7d6, 0xf62
  05f43  jmp 0x4eea
L5F46:
  05f46  mov di, 0xfb2
  05f49  mov si, 0x10be
  05f4c  lcall 0x7d6, 0x10a6
  05f51  mov bx, 0x2530  ; "There's not"
  05f54  mov dx, 0xed2
  05f57  lcall 0x7d6, 0xf62
  05f5c  mov bx, 0x2540  ; 'anyone to'
  05f5f  mov dx, 0xed6
  05f62  lcall 0x7d6, 0xf62
  05f67  mov bx, 0x254e  ; 'show it to!'
  05f6a  mov dx, 0xeda
  05f6d  lcall 0x7d6, 0xf62
  05f72  jmp 0x1bd7
L5F75:
  05f75  mov bx, 1
  05f78  mov dx, 0x54
  05f7b  lcall 0x7d6, 0xccb
  05f80  mov di, 0xfb2
  05f83  mov si, 0x1098
  05f86  lcall 0x7d6, 0x10a6
  05f8b  mov bx, 0x255e  ; 'Writing on the'
  05f8e  mov dx, 0xed2
  05f91  lcall 0x7d6, 0xf62
  05f96  mov bx, 0x2570  ; 'wall says...'
  05f99  mov dx, 0xed6
  05f9c  lcall 0x7d6, 0xf62
  05fa1  mov bx, 0x106a  ; ''
  05fa4  mov dx, 0xeda
  05fa7  lcall 0x7d6, 0xf62
  05fac  mov bx, 0x18
  05faf  xor dx, dx
  05fb1  lcall 0x7d6, 0x24da
  05fb6  xchg bx, ax
  05fb7  mov bx, 0xf36
  05fba  lcall 0x7d6, 0xfd2
  05fbf  je 0x5fc4
  05fc1  jmp 0x5fdd
L5FC4:
  05fc4  mov bx, 0x2580  ; ' No high score'
  05fc7  mov dx, 0xede
  05fca  lcall 0x7d6, 0xf62
  05fcf  mov bx, 0x106a  ; ''
  05fd2  mov dx, 0xee2
  05fd5  lcall 0x7d6, 0xf62
  05fda  jmp 0x1bd7
L5FDD:
  05fdd  mov bx, 0xf36
  05fe0  mov dx, 0xede
  05fe3  lcall 0x7d6, 0xf62
  05fe8  mov bx, 0xf3a
  05feb  mov dx, 0xee2
  05fee  lcall 0x7d6, 0xf62
  05ff3  mov bx, 0xede
  05ff6  mov dx, 0xe
  05ff9  mov cx, bx
  05ffb  lcall 0x7d6, 0x246f
  06000  mov dx, cx
  06002  lcall 0x7d6, 0xf62
  06007  mov bx, 0xee2
  0600a  mov dx, 0xe
  0600d  mov cx, bx
  0600f  lcall 0x7d6, 0x246f
  06014  mov dx, cx
  06016  lcall 0x7d6, 0xf62
  0601b  jmp 0x1bd7
L601E:
  0601e  mov bx, 1
  06021  lcall 0x7d6, 0xd15
  06026  mov bx, 2
  06029  mov dx, 0xfe2
  0602c  xor cx, cx
  0602e  lcall 0x7d6, 0xd24
  06033  mov bx, 2
  06036  lcall 0x7d6, 0x3039
  0603b  mov dx, bx
  0603d  mov bx, 0xf1a
  06040  lcall 0x7d6, 0x2d7e
  06045  mov bx, dx
  06047  lcall 0x7d6, 0x3039
  0604c  mov bx, 0xf26
  0604f  lcall 0x7d6, 0x2d7e
  06054  mov bx, dx
  06056  lcall 0x7d6, 0x3039
  0605b  mov bx, 0xf2a
  0605e  lcall 0x7d6, 0x2d7e
  06063  mov bx, dx
  06065  lcall 0x7d6, 0x3039
  0606a  mov bx, 0xf2e
  0606d  lcall 0x7d6, 0x2d56
  06072  mov bx, 0xf1e
  06075  lcall 0x7d6, 0x2d56
  0607a  mov bx, 0xf22
  0607d  lcall 0x7d6, 0x2d56
  06082  mov bx, 0xfae
  06085  lcall 0x7d6, 0x2d56
  0608a  mov bx, 0xfea
  0608d  lcall 0x7d6, 0x2d7e
  06092  mov si, 0x1040
  06095  lcall 0x7d6, 0x10bd
  0609a  jmp 0x60e0
L609D:
  0609d  mov bx, 2
  060a0  lcall 0x7d6, 0x3039
  060a5  mov si, 0xf32
  060a8  mov dx, si
  060aa  lcall 0x7d6, 0x227f
  060af  shl bx, 1
  060b1  shl bx, 1
  060b3  mov cx, bx
  060b5  add bx, 0xc26
  060b9  lcall 0x7d6, 0x2d56
  060be  mov bx, cx
  060c0  add cx, 0xcde
  060c4  mov ax, bx
  060c6  mov bx, cx
  060c8  lcall 0x7d6, 0x2d56
  060cd  add ax, 0xd3a
  060d0  xchg bx, ax
  060d1  lcall 0x7d6, 0x2d7e
  060d6  mov si, dx
  060d8  mov di, 0x1040
  060db  lcall 0x7d6, 0x1772
L60E0:
  060e0  mov di, 0xf32
  060e3  lcall 0x7d6, 0x10a3
  060e8  mov si, di
  060ea  mov di, 0x104c
  060ed  lcall 0x7d6, 0x19ce
  060f2  jbe 0x609d
  060f4  mov si, 0x1040
  060f7  lcall 0x7d6, 0x10bd
  060fc  jmp 0x616b
L60FF:
  060ff  mov bx, 2
  06102  lcall 0x7d6, 0x3039
  06107  mov dx, bx
  06109  mov si, 0xf32
  0610c  mov cx, si
  0610e  lcall 0x7d6, 0x227f
  06113  shl bx, 1
  06115  shl bx, 1
  06117  mov ax, bx
  06119  add bx, 0xd96
  0611d  lcall 0x7d6, 0x2d7e
  06122  mov bx, dx
  06124  lcall 0x7d6, 0x3039
  06129  mov word ptr [bp - 2], ax
  0612c  add ax, 0xe1a
  0612f  xchg bx, ax
  06130  lcall 0x7d6, 0x2d8d
  06135  xchg bx, ax
  06136  lcall 0x7d6, 0x3039
  0613b  mov bx, word ptr [bp - 2]
  0613e  mov dx, bx
  06140  add bx, 0xeee
  06144  lcall 0x7d6, 0x2d56
  06149  mov bx, dx
  0614b  add dx, 0xdc2
  0614f  mov ax, bx
  06151  mov bx, dx
  06153  lcall 0x7d6, 0x2d56
  06158  add ax, 0xdee
  0615b  xchg bx, ax
  0615c  lcall 0x7d6, 0x2d7e
  06161  mov si, cx
  06163  mov di, 0x1040
  06166  lcall 0x7d6, 0x1772
L616B:
  0616b  mov di, 0xf32
  0616e  lcall 0x7d6, 0x10a3
  06173  mov si, di
  06175  mov di, 0x1050
  06178  lcall 0x7d6, 0x19ce
  0617d  jbe 0x60ff
  0617f  mov bx, 2
  06182  lcall 0x7d6, 0xc8f
  06187  mov di, 0xfb2
  0618a  mov si, 0x1040
  0618d  lcall 0x7d6, 0x10a6
  06192  mov bx, 0x2592  ; ' Game Saved'
  06195  mov dx, 0xed2
  06198  lcall 0x7d6, 0xf62
  0619d  jmp 0x1bd7
L61A0:
  061a0  mov bx, 3
  061a3  lcall 0x7d6, 0xd15
  061a8  mov bx, 2
  061ab  mov dx, 0xfe2
  061ae  xor cx, cx
  061b0  lcall 0x7d6, 0xd24
  061b5  lcall 0x7d6, 0xc8f
  061ba  mov ax, bx
  061bc  mov bx, cx
  061be  lcall 0x7d6, 0xd15
  061c3  xchg bx, ax
  061c4  lcall 0x7d6, 0xd24
  061c9  mov bx, 2
  061cc  lcall 0x7d6, 0xc74
  061d1  cmp bx, -1
  061d4  je 0x61d9
  061d6  jmp 0x6221
L61D9:
  061d9  mov bx, 2
  061dc  lcall 0x7d6, 0xc8f
  061e1  mov bx, 0xfe2
  061e4  lcall 0x7d6, 0x21a7
  061e9  mov di, 0xfb2
  061ec  mov si, 0x10be
  061ef  lcall 0x7d6, 0x10a6
  061f4  mov cx, bx
  061f6  mov bx, 0x25a2  ; ' There is no'
  061f9  mov dx, 0xed2
  061fc  lcall 0x7d6, 0xf62
  06201  mov bx, 0x25b2  ; ' file named'
  06204  mov dx, 0xed6
  06207  lcall 0x7d6, 0xf62
  0620c  mov bx, cx
  0620e  mov ax, 0x10a4  ; ' '
  06211  lcall 0x7d6, 0xf98
  06216  mov dx, 0xeda
  06219  lcall 0x7d6, 0xf62
  0621e  jmp 0x1bd7
L6221:
  06221  mov bx, 2
  06224  lcall 0x7d6, 0x29be
  06229  lcall 0x7d6, 0x2c3d  db 01 05
  06230  mov bx, 0xf1a
  06233  lcall 0x7d6, 0x2d04
  06238  mov bx, 2
  0623b  lcall 0x7d6, 0x29be
  06240  lcall 0x7d6, 0x2c3d  db 01 05
  06247  mov bx, 0xf26
  0624a  lcall 0x7d6, 0x2d04
  0624f  mov bx, 2
  06252  lcall 0x7d6, 0x29be
  06257  lcall 0x7d6, 0x2c3d  db 01 05
  0625e  mov bx, 0xf2a
  06261  lcall 0x7d6, 0x2d04
  06266  mov bx, 2
  06269  lcall 0x7d6, 0x29be
  0626e  lcall 0x7d6, 0x2c3d  db 05 05 05 05 05 05
  06279  mov bx, 0xf2e
  0627c  lcall 0x7d6, 0x2d04
  06281  mov bx, 0xf1e
  06284  lcall 0x7d6, 0x2d04
  06289  mov bx, 0xf22
  0628c  lcall 0x7d6, 0x2d04
  06291  mov bx, 0xfae
  06294  lcall 0x7d6, 0x2d04
  06299  mov bx, 0xfea
  0629c  lcall 0x7d6, 0x2d04
  062a1  mov si, 0x1040
  062a4  lcall 0x7d6, 0x10bd
  062a9  jmp 0x62f8
L62AC:
  062ac  mov bx, 2
  062af  lcall 0x7d6, 0x29be
  062b4  lcall 0x7d6, 0x2c3d  db 03 05 05 05
  062bd  mov si, 0xf32
  062c0  mov dx, si
  062c2  lcall 0x7d6, 0x227f
  062c7  shl bx, 1
  062c9  shl bx, 1
  062cb  mov cx, bx
  062cd  add bx, 0xc26
  062d1  lcall 0x7d6, 0x2d04
  062d6  mov bx, cx
  062d8  add cx, 0xcde
  062dc  mov ax, bx
  062de  mov bx, cx
  062e0  lcall 0x7d6, 0x2d04
  062e5  add ax, 0xd3a
  062e8  xchg bx, ax
  062e9  lcall 0x7d6, 0x2d04
  062ee  mov si, dx
  062f0  mov di, 0x1040
  062f3  lcall 0x7d6, 0x1772
L62F8:
  062f8  mov di, 0xf32
  062fb  lcall 0x7d6, 0x10a3
  06300  mov si, di
  06302  mov di, 0x104c
  06305  lcall 0x7d6, 0x19ce
  0630a  jbe 0x62ac
  0630c  mov si, 0x1040
  0630f  lcall 0x7d6, 0x10bd
  06314  jmp 0x638e
L6317:
  06317  mov bx, 2
  0631a  lcall 0x7d6, 0x29be
  0631f  lcall 0x7d6, 0x2c3d  db 01 05
  06326  mov si, 0xf32
  06329  lcall 0x7d6, 0x227f
  0632e  shl bx, 1
  06330  shl bx, 1
  06332  add bx, 0xd96
  06336  lcall 0x7d6, 0x2d04
  0633b  mov bx, 2
  0633e  lcall 0x7d6, 0x29be
  06343  lcall 0x7d6, 0x2c3d  db 01 07
  0634a  mov si, 0xf32
  0634d  lcall 0x7d6, 0x227f
  06352  shl bx, 1
  06354  shl bx, 1
  06356  add bx, 0xe1a
  0635a  lcall 0x7d6, 0x2d04
  0635f  mov bx, 2
  06362  lcall 0x7d6, 0x29be
  06367  lcall 0x7d6, 0x2c3d  db 01 05
  0636e  mov si, 0xf32
  06371  lcall 0x7d6, 0x227f
  06376  shl bx, 1
  06378  shl bx, 1
  0637a  add bx, 0xeee
  0637e  lcall 0x7d6, 0x2d04
  06383  mov di, 0x1040
  06386  mov si, 0xf32
  06389  lcall 0x7d6, 0x1772
L638E:
  0638e  mov di, 0xf32
  06391  lcall 0x7d6, 0x10a3
  06396  mov si, di
  06398  mov di, 0x1050
  0639b  lcall 0x7d6, 0x19ce
  063a0  ja 0x63a5
  063a2  jmp 0x6317
L63A5:
  063a5  mov bx, 2
  063a8  lcall 0x7d6, 0xc8f
  063ad  jmp 0x23e
L63B0:
  063b0  mov si, 0x1146
  063b3  lcall 0x7d6, 0x10bd
  063b8  jmp 0x63ee
L63BB:
  063bb  mov si, 0xf32
  063be  mov dx, si
  063c0  lcall 0x7d6, 0x227f
  063c5  lcall 0x7d6, 0xffd
  063ca  mov bx, 0x1a
  063cd  lcall 0x7d6, 0x1017
  063d2  lcall 0x7d6, 0x3021
  063d7  mov bx, 0xf
  063da  lcall 0x7d6, 0x24b5
  063df  lcall 0x7d6, 0x2d79
  063e4  mov si, dx
  063e6  mov di, 0x1040
  063e9  lcall 0x7d6, 0x1772
L63EE:
  063ee  mov di, 0xf32
  063f1  lcall 0x7d6, 0x10a3
  063f6  mov si, di
  063f8  mov di, 0x1094
  063fb  lcall 0x7d6, 0x19ce
  06400  jbe 0x63bb
  06402  mov di, 0x1016
  06405  mov si, 0xfb2
  06408  lcall 0x7d6, 0x10a6
  0640d  mov si, 0x1040
  06410  lcall 0x7d6, 0x10bd
  06415  jmp 0x645a
L6418:
  06418  mov di, 0x10b6
  0641b  mov si, 0xf32
  0641e  lcall 0x7d6, 0x1772
  06423  mov dx, si
  06425  lcall 0x7d6, 0x22ca
  0642a  lcall 0x7d6, 0xffd
  0642f  mov bx, 0x1a
  06432  lcall 0x7d6, 0x1017
  06437  lcall 0x7d6, 0x3021
  0643c  mov si, dx
  0643e  lcall 0x7d6, 0x227f
  06443  shl bx, 1
  06445  shl bx, 1
  06447  add bx, 0xece
  0644b  lcall 0x7d6, 0x2d79
  06450  mov si, dx
  06452  mov di, 0x1040
  06455  lcall 0x7d6, 0x1772
L645A:
  0645a  mov di, 0xf32
  0645d  lcall 0x7d6, 0x10a3
  06462  mov si, di
  06464  mov di, 0x1016
  06467  lcall 0x7d6, 0x19ce
  0646c  jbe 0x6418
L646E:
  0646e  lcall 0x7d6, 0x23a1
  06473  xchg bx, ax
  06474  mov bx, 0x106a  ; ''
  06477  lcall 0x7d6, 0xfd2
  0647c  jne 0x646e
  0647e  mov si, 0x25c2
  06481  lcall 0x7d6, 0x10bd
  06486  jmp 0x64bc
L6489:
  06489  mov si, 0xf32
  0648c  mov dx, si
  0648e  lcall 0x7d6, 0x227f
  06493  lcall 0x7d6, 0xffd
  06498  mov bx, 1
  0649b  lcall 0x7d6, 0x1017
  064a0  lcall 0x7d6, 0x3021
  064a5  mov bx, 0x27
  064a8  lcall 0x7d6, 0x24b5
  064ad  lcall 0x7d6, 0x2d79
  064b2  mov si, dx
  064b4  mov di, 0x1040
  064b7  lcall 0x7d6, 0x1772
L64BC:
  064bc  mov di, 0xf32
  064bf  lcall 0x7d6, 0x10a3
  064c4  mov si, di
  064c6  mov di, 0x108c
  064c9  lcall 0x7d6, 0x19ce
  064ce  jbe 0x6489
  064d0  mov bx, 0x19
  064d3  lcall 0x7d6, 0xffd
  064d8  mov bx, 8
  064db  lcall 0x7d6, 0xffd
  064e0  xor bx, bx
  064e2  lcall 0x7d6, 0x1017
  064e7  lcall 0x7d6, 0x3021
  064ec  mov bx, 0x25c6  ; 'Press any key to continue'
  064ef  lcall 0x7d6, 0x2d79
L64F4:
  064f4  lcall 0x7d6, 0x23a1
  064f9  xchg bx, ax
  064fa  mov bx, 0x106a  ; ''
  064fd  lcall 0x7d6, 0xfd2
  06502  je 0x64f4
  06504  lcall 0x7d6, 0x789
  06509  mov bx, 2
  0650c  lcall 0x7d6, 0xffd
  06511  mov bx, 6
  06514  lcall 0x7d6, 0x1017
  06519  lcall 0x7d6, 0x3021
  0651e  mov bx, 0x25e4  ; "You're have failed to Escape!"
  06521  lcall 0x7d6, 0x2d8d
  06526  mov di, 0xfda
  06529  mov si, 0x2606
  0652c  lcall 0x7d6, 0x10a6
  06531  mov bx, 0x106a  ; ''
  06534  mov dx, 0xfd6
  06537  lcall 0x7d6, 0xf62
  0653c  jmp 0x6577
L653F:
  0653f  lcall 0x7d6, 0x789
  06544  mov bx, 2
  06547  lcall 0x7d6, 0xffd
  0654c  mov bx, 7
  0654f  lcall 0x7d6, 0x1017
  06554  lcall 0x7d6, 0x3021
  06559  mov bx, 0x260a  ; "You've Escaped the Castle!"
  0655c  lcall 0x7d6, 0x2d8d
  06561  mov di, 0xfda
  06564  mov si, 0x1048
  06567  lcall 0x7d6, 0x10a6
  0656c  mov bx, 0x106a  ; ''
  0656f  mov dx, 0xfd6
  06572  lcall 0x7d6, 0xf62
L6577:
  06577  mov si, 0x1146
  0657a  lcall 0x7d6, 0x10bd
  0657f  jmp 0x65fd
L6582:
  06582  mov si, 0xf32
  06585  lcall 0x7d6, 0x227f
  0658a  mov si, bx
  0658c  shl si, 1
  0658e  shl si, 1
  06590  mov bx, si
  06592  add si, 0xc26
  06596  mov di, 0x1040
  06599  lcall 0x7d6, 0x19ce
  0659e  mov dx, 0
  065a1  jne 0x65a4
  065a3  dec dx
L65A4:
  065a4  lcall 0x7d6, 0x26aa
  065a9  mov cx, 0
  065ac  jne 0x65af
  065ae  dec cx
L65AF:
  065af  or cx, dx
  065b1  and cx, cx
  065b3  jne 0x65b8
  065b5  jmp 0x65f2
L65B8:
  065b8  mov di, 0x14f8
  065bb  mov si, 0xfda
  065be  lcall 0x7d6, 0x1772
  065c3  mov di, si
  065c5  lcall 0x7d6, 0x10a3
  065ca  add bx, 0xe46
  065ce  mov si, bx
  065d0  lcall 0x7d6, 0x227f
  065d5  lcall 0x7d6, 0x23be
  065da  mov ax, 0xfd6
  065dd  lcall 0x7d6, 0xf98
  065e2  xchg bx, ax
  065e3  mov dx, bx
  065e5  mov bx, 0x10a4  ; ' '
  065e8  lcall 0x7d6, 0xf98
  065ed  lcall 0x7d6, 0xf62
L65F2:
  065f2  mov di, 0x1040
  065f5  mov si, 0xf32
  065f8  lcall 0x7d6, 0x1772
L65FD:
  065fd  mov di, 0xf32
  06600  lcall 0x7d6, 0x10a3
  06605  mov si, di
  06607  mov di, 0x104c
  0660a  lcall 0x7d6, 0x19ce
  0660f  ja 0x6614
  06611  jmp 0x6582
L6614:
  06614  mov di, 0x1040
  06617  mov si, 0xc2e
  0661a  lcall 0x7d6, 0x19ce
  0661f  mov bx, 0
  06622  jne 0x6625
  06624  dec bx
L6625:
  06625  lcall 0x7d6, 0x26aa
  0662a  mov dx, 0
  0662d  jne 0x6630
  0662f  dec dx
L6630:
  06630  or dx, bx
  06632  and dx, dx
  06634  jne 0x6639
  06636  jmp 0x6670
L6639:
  06639  mov di, 0x14f8
  0663c  mov si, 0xfda
  0663f  lcall 0x7d6, 0x1772
  06644  mov di, si
  06646  lcall 0x7d6, 0x10a3
  0664b  mov si, 0xe4e
  0664e  lcall 0x7d6, 0x227f
  06653  lcall 0x7d6, 0x23be
  06658  mov ax, 0xfd6
  0665b  lcall 0x7d6, 0xf98
  06660  xchg bx, ax
  06661  mov dx, bx
  06663  mov bx, 0x10a4  ; ' '
  06666  lcall 0x7d6, 0xf98
  0666b  lcall 0x7d6, 0xf62
L6670:
  06670  mov di, 0x1040
  06673  mov si, 0xc32
  06676  lcall 0x7d6, 0x19ce
  0667b  mov bx, 0
  0667e  jne 0x6681
  06680  dec bx
L6681:
  06681  lcall 0x7d6, 0x26aa
  06686  mov dx, 0
  06689  jne 0x668c
  0668b  dec dx
L668C:
  0668c  or dx, bx
  0668e  and dx, dx
  06690  jne 0x6695
  06692  jmp 0x66cc
L6695:
  06695  mov di, 0x14f8
  06698  mov si, 0xfda
  0669b  lcall 0x7d6, 0x1772
  066a0  mov di, si
  066a2  lcall 0x7d6, 0x10a3
  066a7  mov si, 0xe52
  066aa  lcall 0x7d6, 0x227f
  066af  lcall 0x7d6, 0x23be
  066b4  mov ax, 0xfd6
  066b7  lcall 0x7d6, 0xf98
  066bc  xchg bx, ax
  066bd  mov dx, bx
  066bf  mov bx, 0x10a4  ; ' '
  066c2  lcall 0x7d6, 0xf98
  066c7  lcall 0x7d6, 0xf62
L66CC:
  066cc  mov di, 0x1040
  066cf  mov si, 0xc56
  066d2  lcall 0x7d6, 0x19ce
  066d7  mov bx, 0
  066da  jne 0x66dd
  066dc  dec bx
L66DD:
  066dd  lcall 0x7d6, 0x26aa
  066e2  mov dx, 0
  066e5  jne 0x66e8
  066e7  dec dx
L66E8:
  066e8  or dx, bx
  066ea  and dx, dx
  066ec  jne 0x66f1
  066ee  jmp 0x6728
L66F1:
  066f1  mov di, 0x14f8
  066f4  mov si, 0xfda
  066f7  lcall 0x7d6, 0x1772
  066fc  mov di, si
  066fe  lcall 0x7d6, 0x10a3
  06703  mov si, 0xe76
  06706  lcall 0x7d6, 0x227f
  0670b  lcall 0x7d6, 0x23be
  06710  mov ax, 0xfd6
  06713  lcall 0x7d6, 0xf98
  06718  xchg bx, ax
  06719  mov dx, bx
  0671b  mov bx, 0x10a4  ; ' '
  0671e  lcall 0x7d6, 0xf98
  06723  lcall 0x7d6, 0xf62
L6728:
  06728  mov bx, 5
  0672b  lcall 0x7d6, 0xffd
  06730  mov bx, 2
  06733  lcall 0x7d6, 0x1017
  06738  lcall 0x7d6, 0x3021
  0673d  mov bx, 0x2628  ; 'You have collected these Treasues...'
  06740  lcall 0x7d6, 0x2d8d
  06745  mov bx, 0x106a  ; ''
  06748  mov ax, 0xfd6
  0674b  lcall 0x7d6, 0xfd2
  06750  je 0x6755
  06752  jmp 0x675e
L6755:
  06755  xchg dx, ax
  06756  mov bx, 0x2650  ; 'NONE'
  06759  lcall 0x7d6, 0xf62
L675E:
  0675e  mov bx, 0xfd6
  06761  mov dx, bx
  06763  lcall 0x7d6, 0x2386
  06768  lcall 0x7d6, 0x2237
  0676d  mov di, 0x14aa
  06770  lcall 0x7d6, 0x189f
  06775  mov si, 0x25c2
  06778  lcall 0x7d6, 0x175a
  0677d  mov di, 0x101a
  06780  lcall 0x7d6, 0x10a3
  06785  mov bx, 7
  06788  lcall 0x7d6, 0xffd
  0678d  mov si, di
  0678f  lcall 0x7d6, 0x227f
  06794  lcall 0x7d6, 0x1017
  06799  lcall 0x7d6, 0x3021
  0679e  mov bx, dx
  067a0  lcall 0x7d6, 0x2d79
  067a5  mov bx, 0x106a  ; ''
  067a8  mov dx, 0xfd6
  067ab  lcall 0x7d6, 0xf62
  067b0  mov si, 0x1040
  067b3  lcall 0x7d6, 0x10bd
  067b8  jmp 0x681e
L67BB:
  067bb  mov si, 0xf32
  067be  lcall 0x7d6, 0x227f
  067c3  mov si, bx
  067c5  shl si, 1
  067c7  shl si, 1
  067c9  mov bx, si
  067cb  add si, 0xeee
  067cf  lcall 0x7d6, 0x26aa
  067d4  jb 0x67d9
  067d6  jmp 0x6813
L67D9:
  067d9  mov di, 0x1048
  067dc  mov si, 0xfda
  067df  lcall 0x7d6, 0x1772
  067e4  mov di, si
  067e6  lcall 0x7d6, 0x10a3
  067eb  add bx, 0xea2
  067ef  mov si, bx
  067f1  lcall 0x7d6, 0x227f
  067f6  lcall 0x7d6, 0x23be
  067fb  mov ax, 0xfd6
  067fe  lcall 0x7d6, 0xf98
  06803  xchg bx, ax
  06804  mov dx, bx
  06806  mov bx, 0x10a4  ; ' '
  06809  lcall 0x7d6, 0xf98
  0680e  lcall 0x7d6, 0xf62
L6813:
  06813  mov di, 0x1040
  06816  mov si, 0xf32
  06819  lcall 0x7d6, 0x1772
L681E:
  0681e  mov di, 0xf32
  06821  lcall 0x7d6, 0x10a3
  06826  mov si, di
  06828  mov di, 0x13dc
  0682b  lcall 0x7d6, 0x19ce
  06830  jbe 0x67bb
  06832  mov bx, 0xa
  06835  lcall 0x7d6, 0xffd
  0683a  mov bx, 2
  0683d  lcall 0x7d6, 0x1017
  06842  lcall 0x7d6, 0x3021
  06847  mov bx, 0x2658  ; 'You have killed these Monsters......'
  0684a  lcall 0x7d6, 0x2d8d
  0684f  mov bx, 0x106a  ; ''
  06852  mov ax, 0xfd6
  06855  lcall 0x7d6, 0xfd2
  0685a  je 0x685f
  0685c  jmp 0x6868
L685F:
  0685f  xchg dx, ax
  06860  mov bx, 0x2650  ; 'NONE'
  06863  lcall 0x7d6, 0xf62
L6868:
  06868  mov bx, 0xfd6
  0686b  mov dx, bx
  0686d  lcall 0x7d6, 0x2386
  06872  lcall 0x7d6, 0x2237
  06877  mov di, 0x14aa
  0687a  lcall 0x7d6, 0x189f
  0687f  mov si, 0x25c2
  06882  lcall 0x7d6, 0x175a
  06887  mov di, 0x101a
  0688a  lcall 0x7d6, 0x10a3
  0688f  mov bx, 0xc
  06892  lcall 0x7d6, 0xffd
  06897  mov si, di
  06899  lcall 0x7d6, 0x227f
  0689e  lcall 0x7d6, 0x1017
  068a3  lcall 0x7d6, 0x3021
  068a8  mov bx, dx
  068aa  lcall 0x7d6, 0x2d79
  068af  mov bx, 0x14
  068b2  lcall 0x7d6, 0xffd
  068b7  mov bx, 0xc
  068ba  lcall 0x7d6, 0x1017
  068bf  lcall 0x7d6, 0x3021
  068c4  mov bx, 0x2680  ; 'Your Score:'
  068c7  lcall 0x7d6, 0x2d79
  068cc  mov bx, 0xfda
  068cf  lcall 0x7d6, 0x2d6a
  068d4  mov bx, 0x2690  ; 'MFT200O2L12DGBO3D4O2B4G4GABO3CO2BAGABO3C4'
  068d7  mov dx, 0xfd6
  068da  lcall 0x7d6, 0xf62
  068df  mov bx, 0x26be  ; 'MFT200O2L12DF#AO3C4O2A4D4F#GABAGF#AF#G4'
  068e2  mov dx, 0x101e
  068e5  lcall 0x7d6, 0xf62
  068ea  mov di, 0x26ea
  068ed  mov si, 0xfda
  068f0  lcall 0x7d6, 0x19ce
  068f5  je 0x68fa
  068f7  jmp 0x6927
L68FA:
  068fa  mov bx, 0x15
  068fd  lcall 0x7d6, 0xffd
  06902  mov bx, 0xc
  06905  lcall 0x7d6, 0x1017
  0690a  lcall 0x7d6, 0x3021
  0690f  mov bx, 0x26ee  ; '    PERFECT!'
  06912  lcall 0x7d6, 0x2d8d
  06917  mov bx, 0x101e
  0691a  mov ax, 0xfd6
  0691d  lcall 0x7d6, 0xf98
  06922  lcall 0x7d6, 0x2a83
L6927:
  06927  mov di, 0x26ea
  0692a  mov si, 0xfda
  0692d  lcall 0x7d6, 0x19ce
  06932  jb 0x6937
  06934  jmp 0x6954
L6937:
  06937  mov bx, 0x15
  0693a  lcall 0x7d6, 0xffd
  0693f  mov bx, 8
  06942  lcall 0x7d6, 0x1017
  06947  lcall 0x7d6, 0x3021
  0694c  mov bx, 0x26fe  ; '   (1550 is perfect)'
  0694f  lcall 0x7d6, 0x2d8d
L6954:
  06954  mov bx, 0x19
  06957  lcall 0x7d6, 0xffd
  0695c  mov bx, 0xa
  0695f  lcall 0x7d6, 0x1017
  06964  lcall 0x7d6, 0x3021
  06969  mov bx, 0x2716  ; ' - Press any key -'
  0696c  lcall 0x7d6, 0x2d79
L6971:
  06971  lcall 0x7d6, 0x23a1
  06976  xchg bx, ax
  06977  mov bx, 0x106a  ; ''
  0697a  lcall 0x7d6, 0xfd2
  0697f  jne 0x6971
L6981:
  06981  lcall 0x7d6, 0x23a1
  06986  xchg bx, ax
  06987  mov bx, 0x106a  ; ''
  0698a  lcall 0x7d6, 0xfd2
  0698f  je 0x6981
  06991  mov bx, 1
  06994  mov dx, 0x54
  06997  lcall 0x7d6, 0xccb
  0699c  mov bx, 0xf3a
  0699f  lcall 0x7d6, 0x1a00
  069a4  lcall 0x7d6, 0x2259
  069a9  mov di, 0x1022
  069ac  lcall 0x7d6, 0x10a3
  069b1  mov di, 0x1022
  069b4  mov si, 0xfda
  069b7  lcall 0x7d6, 0x19ce
  069bc  jbe 0x69c1
  069be  jmp 0x6a42
L69C1:
  069c1  mov bx, 0x19
  069c4  lcall 0x7d6, 0xffd
  069c9  mov bx, 0xa
  069cc  lcall 0x7d6, 0x1017
  069d1  lcall 0x7d6, 0x3021
  069d6  mov bx, 0x272c  ; 'Play Again (Y/N)?  '
  069d9  lcall 0x7d6, 0x2d79
L69DE:
  069de  lcall 0x7d6, 0x23a1
  069e3  mov dx, 0xfba
  069e6  lcall 0x7d6, 0xf62
  069eb  xchg dx, ax
  069ec  mov bx, 0x106a  ; ''
  069ef  lcall 0x7d6, 0xfd2
  069f4  je 0x69de
  069f6  mov bx, 0x2744  ; 'Y'
  069f9  mov ax, 0xfba
  069fc  lcall 0x7d6, 0xfd2
  06a01  mov dx, 0
  06a04  jne 0x6a07
  06a06  dec dx
L6A07:
  06a07  mov bx, 0x274a  ; 'y'
  06a0a  lcall 0x7d6, 0xfd2
  06a0f  mov cx, 0
  06a12  jne 0x6a15
  06a14  dec cx
L6A15:
  06a15  or cx, dx
  06a17  and cx, cx
  06a19  jne 0x6a1e
  06a1b  jmp 0x6a38
L6A1E:
  06a1e  lcall 0x7d6, 0x13db
  06a23  lcall 0x7d6, 0x789
  06a28  lcall 0x7d6, 0x3021
  06a2d  mov bx, 0x2750  ; 'Loading...'
  06a30  lcall 0x7d6, 0x2d79
  06a35  jmp 0x39
L6A38:
  06a38  lcall 0x7d6, 0xc9f
  06a3d  lcall 0x7d6, 0x15e7
L6A42:
  06a42  lcall 0x7d6, 0x789
  06a47  mov bx, 2
  06a4a  lcall 0x7d6, 0xffd
  06a4f  mov bx, 6
  06a52  lcall 0x7d6, 0x1017
  06a57  lcall 0x7d6, 0x3021
  06a5c  mov bx, 0x275e  ; 'You have made the High Score!'
  06a5f  lcall 0x7d6, 0x2d8d
  06a64  mov bx, 5
  06a67  lcall 0x7d6, 0xffd
  06a6c  mov bx, 6
  06a6f  lcall 0x7d6, 0x1017
  06a74  lcall 0x7d6, 0x3021
  06a79  mov bx, 0x2780  ; '          '
  06a7c  lcall 0x7d6, 0x2d79
  06a81  mov bx, 0xfda
  06a84  lcall 0x7d6, 0x2d7e
  06a89  mov bx, 0xf
  06a8c  lcall 0x7d6, 0xffd
  06a91  mov bx, 3
  06a94  lcall 0x7d6, 0xffd
  06a99  mov bx, 1
  06a9c  lcall 0x7d6, 0x1017
  06aa1  lcall 0x7d6, 0x3021
  06aa6  mov bx, 0x278e  ; 'Enter Your Name - '
  06aa9  lcall 0x7d6, 0x2d79
  06aae  mov bx, 0x106a  ; ''
  06ab1  mov dx, 0xfe2
  06ab4  lcall 0x7d6, 0xf62
  06ab9  mov bx, 0x106a  ; ''
  06abc  lcall 0x7d6, 0x2972  db 02
  06ac2  mov bx, 0xfe2
  06ac5  lcall 0x7d6, 0x259c
  06aca  mov bx, 0xfe2
  06acd  mov dx, bx
  06acf  lcall 0x7d6, 0x2386
  06ad4  cmp bx, 0xe
  06ad7  jg 0x6adc
  06ad9  jmp 0x6b05
L6ADC:
  06adc  mov bx, 0xf
  06adf  lcall 0x7d6, 0xffd
  06ae4  mov bx, 0x15
  06ae7  lcall 0x7d6, 0x1017
  06aec  lcall 0x7d6, 0x3021
  06af1  mov bx, dx
  06af3  lcall 0x7d6, 0x2386
  06af8  lcall 0x7d6, 0x24b5
  06afd  lcall 0x7d6, 0x2d79
  06b02  jmp 0x3769
L6B05:
  06b05  mov bx, 0xfda
  06b08  lcall 0x7d6, 0x289c
  06b0d  mov dx, 0x1026
  06b10  lcall 0x7d6, 0xf62
  06b15  mov bx, 0xfe2
  06b18  mov dx, 0xf36
  06b1b  lcall 0x7d6, 0x2eac
  06b20  mov bx, 0x1026
  06b23  mov dx, 0xf3a
  06b26  lcall 0x7d6, 0x2eac
  06b2b  mov bx, 1
  06b2e  mov dx, 0x54
  06b31  lcall 0x7d6, 0xcd5
  06b36  jmp 0x6a38
L6B39:
  06b39  xor bx, bx
  06b3b  lcall 0x7d6, 0x8ea
  06b40  mov dx, bx
  06b42  mov bx, 0x28
  06b45  lcall 0x7d6, 0x300b
  06b4a  lcall 0x7d6, 0x789
  06b4f  mov bx, dx
  06b51  lcall 0x7d6, 0xa3f
  06b56  lcall 0x7d6, 0xa3f
  06b5b  lcall 0x7d6, 0xa3f
  06b60  mov bx, 1
  06b63  lcall 0x7d6, 0xa59
  06b68  lcall 0x7d6, 0x3021
  06b6d  mov bx, 0x106a  ; ''
  06b70  lcall 0x7d6, 0x2d8d
  06b75  lcall 0x7d6, 0x100b
  06b7a  lcall 0x7d6, 0x100b
  06b7f  xor bx, bx
  06b81  lcall 0x7d6, 0x1017
  06b86  lcall 0x7d6, 0x3021
  06b8b  mov bx, 0x27a4  ; '           Castle Adventure'
  06b8e  lcall 0x7d6, 0x2d8d
  06b93  lcall 0x7d6, 0x3021
  06b98  mov bx, 0x106a  ; ''
  06b9b  lcall 0x7d6, 0x2d8d
  06ba0  lcall 0x7d6, 0x3021
  06ba5  mov bx, 0x106a  ; ''
  06ba8  lcall 0x7d6, 0x2d8d
  06bad  lcall 0x7d6, 0x3021
  06bb2  mov bx, 0x27c4  ; '    █ █ █ █                 █ █ █ █'
  06bb5  lcall 0x7d6, 0x2d8d
  06bba  lcall 0x7d6, 0x3021
  06bbf  mov bx, 0x27ec  ; '    ▓▓▓▓▓▓▓                 ▓▓▓▓▓▓▓'
  06bc2  lcall 0x7d6, 0x2d8d
  06bc7  lcall 0x7d6, 0x3021
  06bcc  mov bx, 0x2814  ; '     ▓▓▓▓▓                   ▓▓▓▓▓'
  06bcf  lcall 0x7d6, 0x2d8d
  06bd4  lcall 0x7d6, 0x3021
  06bd9  mov bx, 0x283a  ; '     ▓▓▓▓▓ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▄▄ ▓▓▓▓▓'
  06bdc  lcall 0x7d6, 0x2d8d
  06be1  lcall 0x7d6, 0x3021
  06be6  mov bx, 0x2860  ; '     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06be9  lcall 0x7d6, 0x2d8d
  06bee  lcall 0x7d6, 0x3021
  06bf3  mov bx, 0x2860  ; '     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06bf6  lcall 0x7d6, 0x2d8d
  06bfb  lcall 0x7d6, 0x3021
  06c00  mov bx, 0x2860  ; '     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c03  lcall 0x7d6, 0x2d8d
  06c08  lcall 0x7d6, 0x3021
  06c0d  mov bx, 0x2886  ; '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c10  lcall 0x7d6, 0x2d8d
  06c15  lcall 0x7d6, 0x3021
  06c1a  mov bx, 0x2886  ; '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c1d  lcall 0x7d6, 0x2d8d
  06c22  lcall 0x7d6, 0x3021
  06c27  mov bx, 0x2886  ; '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c2a  lcall 0x7d6, 0x2d8d
  06c2f  lcall 0x7d6, 0x3021
  06c34  mov bx, 0x2886  ; '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c37  lcall 0x7d6, 0x2d8d
  06c3c  lcall 0x7d6, 0x3021
  06c41  mov bx, 0x2886  ; '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c44  lcall 0x7d6, 0x2d8d
  06c49  lcall 0x7d6, 0x3021
  06c4e  mov bx, 0x2886  ; '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
  06c51  lcall 0x7d6, 0x2d8d
  06c56  lcall 0x7d6, 0x3021
  06c5b  mov bx, 0x28aa  ; '       ▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓'
  06c5e  lcall 0x7d6, 0x2d8d
  06c63  lcall 0x7d6, 0x3021
  06c68  mov bx, 0x28ce  ; '       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓'
  06c6b  lcall 0x7d6, 0x2d8d
  06c70  lcall 0x7d6, 0x3021
  06c75  mov bx, 0x28ce  ; '       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓'
  06c78  lcall 0x7d6, 0x2d8d
  06c7d  lcall 0x7d6, 0x3021
  06c82  mov bx, 0x28ce  ; '       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓'
  06c85  lcall 0x7d6, 0x2d8d
  06c8a  lcall 0x7d6, 0x3021
  06c8f  mov bx, 0x28ce  ; '       ▓▓▓▓▓▓▓▓▓▓█┼┼┼█▓▓▓▓▓▓▓▓▓▓'
  06c92  lcall 0x7d6, 0x2d8d
  06c97  lcall 0x7d6, 0x3021
  06c9c  mov bx, 0x28f2  ; '_______________________________________'
  06c9f  lcall 0x7d6, 0x2d79
  06ca4  xor bx, bx
  06ca6  lcall 0x7d6, 0xa3f
  06cab  lcall 0x7d6, 0xa3f
  06cb0  lcall 0x7d6, 0xa3f
  06cb5  lcall 0x7d6, 0xa59
  06cba  mov bx, 0x41c
  06cbd  mov ds, word ptr [0x90]
  06cc1  mov bl, byte ptr [bx]
  06cc3  xor bh, bh
  06cc5  push es
  06cc6  pop ds
  06cc7  xchg bx, ax
  06cc8  mov bx, 0x41a
  06ccb  mov ds, word ptr [0x90]
  06ccf  mov byte ptr [bx], al
  06cd1  push es
  06cd2  pop ds
  06cd3  mov bx, 0x291e  ; 'MF MS T200 P1'
  06cd6  lcall 0x7d6, 0x2a83
  06cdb  lcall 0x7d6, 0x23a1
  06ce0  xchg bx, ax
  06ce1  mov bx, 0x106a  ; ''
  06ce4  lcall 0x7d6, 0xfd2
  06ce9  je 0x6cee
  06ceb  jmp 0x6d47
L6CEE:
  06cee  mov bx, 0x2930  ; 'MF MS T200 O2 L12 D D D G2 P4'
  06cf1  lcall 0x7d6, 0x2a83
  06cf6  lcall 0x7d6, 0x23a1
  06cfb  xchg bx, ax
  06cfc  mov bx, 0x106a  ; ''
  06cff  lcall 0x7d6, 0xfd2
  06d04  je 0x6d09
  06d06  jmp 0x6d47
L6D09:
  06d09  mov bx, 0x2952  ; 'L12 D D D G2 P4'
  06d0c  lcall 0x7d6, 0x2a83
  06d11  lcall 0x7d6, 0x23a1
  06d16  xchg bx, ax
  06d17  mov bx, 0x106a  ; ''
  06d1a  lcall 0x7d6, 0xfd2
  06d1f  je 0x6d24
  06d21  jmp 0x6d47
L6D24:
  06d24  mov bx, 0x2966  ; 'L12 D D D L8 G D G B A G A B O3 C2 P3'
  06d27  lcall 0x7d6, 0x2a83
  06d2c  lcall 0x7d6, 0x23a1
  06d31  xchg bx, ax
  06d32  mov bx, 0x106a  ; ''
  06d35  lcall 0x7d6, 0xfd2
  06d3a  je 0x6d3f
  06d3c  jmp 0x6d47
L6D3F:
  06d3f  mov bx, 0x2990  ; 'O2 L12 D D D L8 G D G B A G O3 C O2 A G2'
  06d42  lcall 0x7d6, 0x2a83
L6D47:
  06d47  mov bx, 0x19
  06d4a  lcall 0x7d6, 0xffd
  06d4f  mov bx, 1
  06d52  lcall 0x7d6, 0x1017
  06d57  lcall 0x7d6, 0x3021
  06d5c  mov bx, 0x29bc  ; '  P - to play    I - for instructions'
  06d5f  lcall 0x7d6, 0x2d79
L6D64:
  06d64  lcall 0x7d6, 0x23a1
  06d69  mov dx, 0xfba
  06d6c  lcall 0x7d6, 0xf62
  06d71  xchg dx, ax
  06d72  mov bx, 0x106a  ; ''
  06d75  lcall 0x7d6, 0xfd2
  06d7a  je 0x6d64
  06d7c  mov bx, 0x117a  ; 'P'
  06d7f  mov ax, 0xfba
  06d82  lcall 0x7d6, 0xfd2
  06d87  mov dx, 0
  06d8a  jne 0x6d8d
  06d8c  dec dx
L6D8D:
  06d8d  mov bx, 0x29e6  ; 'p'
  06d90  lcall 0x7d6, 0xfd2
  06d95  mov cx, 0
  06d98  jne 0x6d9b
  06d9a  dec cx
L6D9B:
  06d9b  or cx, dx
  06d9d  and cx, cx
  06d9f  jne 0x6da4
  06da1  jmp 0x6dbb
L6DA4:
  06da4  lcall 0x7d6, 0x789
  06da9  lcall 0x7d6, 0x3021
  06dae  mov bx, 0x2750  ; 'Loading...'
  06db1  lcall 0x7d6, 0x2d79
  06db6  lcall 0x7d6, 0x1cc3
L6DBB:
  06dbb  mov bx, 0x1162  ; 'I'
  06dbe  mov ax, 0xfba
  06dc1  lcall 0x7d6, 0xfd2
  06dc6  mov dx, 0
  06dc9  je 0x6dcc
  06dcb  dec dx
L6DCC:
  06dcc  mov bx, 0x29ec  ; 'i'
  06dcf  lcall 0x7d6, 0xfd2
  06dd4  mov cx, 0
  06dd7  je 0x6dda
  06dd9  dec cx
L6DDA:
  06dda  and cx, dx
  06ddc  and cx, cx
  06dde  jne 0x6d64
  06de0  mov si, 0x1040
  06de3  lcall 0x7d6, 0x10bd
  06de8  jmp 0x6e08
L6DEB:
  06deb  lcall 0x7d6, 0x3021
  06df0  mov bx, 0x27
  06df3  lcall 0x7d6, 0x24b5
  06df8  lcall 0x7d6, 0x2d8d
  06dfd  mov di, 0x1040
  06e00  mov si, 0xf32
  06e03  lcall 0x7d6, 0x1772
L6E08:
  06e08  mov di, 0xf32
  06e0b  lcall 0x7d6, 0x10a3
  06e10  mov si, di
  06e12  mov di, 0x1468
  06e15  lcall 0x7d6, 0x19ce
  06e1a  jbe 0x6deb
  06e1c  lcall 0x7d6, 0x3021
  06e21  mov bx, 0x29f2  ; '   You are trapped in a deserted Castle'
  06e24  lcall 0x7d6, 0x2d8d
  06e29  lcall 0x7d6, 0x3021
  06e2e  mov bx, 0x2a1e  ; 'and you must escape. It is rumored that'
  06e31  lcall 0x7d6, 0x2d8d
  06e36  lcall 0x7d6, 0x3021
  06e3b  mov bx, 0x2a4a  ; 'the  castle is  full of treasures.  Can'
  06e3e  lcall 0x7d6, 0x2d8d
  06e43  lcall 0x7d6, 0x3021
  06e48  mov bx, 0x2a76  ; 'you find them all?                     '
  06e4b  lcall 0x7d6, 0x2d8d
  06e50  lcall 0x7d6, 0x3021
  06e55  mov bx, 0x27
  06e58  lcall 0x7d6, 0x24b5
  06e5d  lcall 0x7d6, 0x2d8d
  06e62  lcall 0x7d6, 0x3021
  06e67  mov bx, 0x2aa2  ; ' Use the cursor keypad to move your man'
  06e6a  lcall 0x7d6, 0x2d8d
  06e6f  lcall 0x7d6, 0x3021
  06e74  mov bx, 0x2ace  ; 'around the rooms.  To pick up a visible'
  06e77  lcall 0x7d6, 0x2d8d
  06e7c  lcall 0x7d6, 0x3021
  06e81  mov bx, 0x2afa  ; 'item,  just run into it.  To pick up an'
  06e84  lcall 0x7d6, 0x2d8d
  06e89  lcall 0x7d6, 0x3021
  06e8e  mov bx, 0x2b26  ; 'item not displayed  on  the screen, use'
  06e91  lcall 0x7d6, 0x2d8d
  06e96  lcall 0x7d6, 0x3021
  06e9b  mov bx, 0x2b52  ; 'the command  GET.  To  attack  monsters'
  06e9e  lcall 0x7d6, 0x2d8d
  06ea3  lcall 0x7d6, 0x3021
  06ea8  mov bx, 0x2b7e  ; 'just  run  into  them,  but only if you'
  06eab  lcall 0x7d6, 0x2d8d
  06eb0  lcall 0x7d6, 0x3021
  06eb5  mov bx, 0x2baa  ; 'have a weapon.The computer accepts most'
  06eb8  lcall 0x7d6, 0x2d8d
  06ebd  lcall 0x7d6, 0x3021
  06ec2  mov bx, 0x2bd6  ; 'two word commands. There are 83 rooms &'
  06ec5  lcall 0x7d6, 0x2d8d
  06eca  lcall 0x7d6, 0x3021
  06ecf  mov bx, 0x2c02  ; '13 treasures.  To  see the High Score ,'
  06ed2  lcall 0x7d6, 0x2d8d
  06ed7  lcall 0x7d6, 0x3021
  06edc  mov bx, 0x2c2e  ; 'look at the wall in the courtyard.     '
  06edf  lcall 0x7d6, 0x2d8d
  06ee4  lcall 0x7d6, 0x3021
  06ee9  mov bx, 0x27
  06eec  lcall 0x7d6, 0x24b5
  06ef1  lcall 0x7d6, 0x2d8d
  06ef6  lcall 0x7d6, 0x3021
  06efb  mov bx, 0x2c5a  ; ' one hint:Look at everything carefully!'
  06efe  lcall 0x7d6, 0x2d8d
  06f03  lcall 0x7d6, 0x3021
  06f08  mov bx, 0x27
  06f0b  lcall 0x7d6, 0x24b5
  06f10  lcall 0x7d6, 0x2d8d
  06f15  lcall 0x7d6, 0x3021
  06f1a  mov bx, 0x2c86  ; ' To save a game type   SAVE filename '
  06f1d  lcall 0x7d6, 0x2d8d
  06f22  lcall 0x7d6, 0x3021
  06f27  mov bx, 0x2cb0  ; ' To load a game type   LOAD filename '
  06f2a  lcall 0x7d6, 0x2d8d
  06f2f  lcall 0x7d6, 0x3021
  06f34  mov bx, 0x27
  06f37  lcall 0x7d6, 0x24b5
  06f3c  lcall 0x7d6, 0x2d8d
  06f41  jmp 0x6d47
L6F44:
  06f44  mov bx, 0x50
  06f47  lcall 0x7d6, 0x300b
  06f4c  xor bx, bx
  06f4e  lcall 0x7d6, 0xa3f
  06f53  lcall 0x7d6, 0xa3f
  06f58  lcall 0x7d6, 0xa59
  06f5d  lcall 0x7d6, 0xa3f
  06f62  lcall 0x7d6, 0xa3f
  06f67  lcall 0x7d6, 0xa3f
  06f6c  mov bx, 1
  06f6f  lcall 0x7d6, 0xa59
  06f74  lcall 0x7d6, 0x789
  06f79  lcall 0x7d6, 0x3021
  06f7e  mov bx, 0x106a  ; ''
  06f81  lcall 0x7d6, 0x2d8d
  06f86  lcall 0x7d6, 0x3021
  06f8b  mov bx, 0x2cda  ; '     ╓──────────────────────────────────────────────────────────────╖'
  06f8e  lcall 0x7d6, 0x2d8d
  06f93  lcall 0x7d6, 0x3021
  06f98  mov bx, 0x2d24  ; '     ║                    ┌──────────────────┐                      ║'
  06f9b  lcall 0x7d6, 0x2d8d
  06fa0  lcall 0x7d6, 0x3021
  06fa5  mov bx, 0x2d6e  ; '     ║                    │  FREEWARE GAMES  │                      ║'
  06fa8  lcall 0x7d6, 0x2d8d
  06fad  lcall 0x7d6, 0x3021
  06fb2  mov bx, 0x2db8  ; '     ║                    └──────────────────┘                      ║'
  06fb5  lcall 0x7d6, 0x2d8d
  06fba  lcall 0x7d6, 0x3021
  06fbf  mov bx, 0x2e02  ; '     ║                   User Supported Software                    ║'
  06fc2  lcall 0x7d6, 0x2d8d
  06fc7  lcall 0x7d6, 0x3021
  06fcc  mov bx, 0x2e4c  ; '     ║                                                              ║'
  06fcf  lcall 0x7d6, 0x2d8d
  06fd4  lcall 0x7d6, 0x3021
  06fd9  mov bx, 0x2e96  ; '     ║                      CASTLE ADVENTURE                        ║'
  06fdc  lcall 0x7d6, 0x2d8d
  06fe1  lcall 0x7d6, 0x3021
  06fe6  mov bx, 0x2e4c  ; '     ║                                                              ║'
  06fe9  lcall 0x7d6, 0x2d8d
  06fee  lcall 0x7d6, 0x3021
  06ff3  mov bx, 0x2ee0  ; '     ║       You are  encouraged to share  this  program with other ║'
  06ff6  lcall 0x7d6, 0x2d8d
  06ffb  lcall 0x7d6, 0x3021
  07000  mov bx, 0x2f2a  ; '     ║  users on the conditions that the program is not distributed ║'
  07003  lcall 0x7d6, 0x2d8d
  07008  lcall 0x7d6, 0x3021
  0700d  mov bx, 0x2f74  ; '     ║  in modified form, that no fee or consideration  is  charged ║'
  07010  lcall 0x7d6, 0x2d8d
  07015  lcall 0x7d6, 0x3021
  0701a  mov bx, 0x2fbe  ; '     ║  and that this notice is not bypassed or removed. If you are ║'
  0701d  lcall 0x7d6, 0x2d8d
  07022  lcall 0x7d6, 0x3021
  07027  mov bx, 0x3008  ; '     ║  using this program and finding if enjoyable , or  of  value ║'
  0702a  lcall 0x7d6, 0x2d8d
  0702f  lcall 0x7d6, 0x3021
  07034  mov bx, 0x3052  ; '     ║  then your contribution ( $10 suggested )  will  be  greatly ║'
  07037  lcall 0x7d6, 0x2d8d
  0703c  lcall 0x7d6, 0x3021
  07041  mov bx, 0x309c  ; '     ║  appreciated.                                                ║'
  07044  lcall 0x7d6, 0x2d8d
  07049  lcall 0x7d6, 0x3021
  0704e  mov bx, 0x2e4c  ; '     ║                                                              ║'
  07051  lcall 0x7d6, 0x2d8d
  07056  lcall 0x7d6, 0x3021
  0705b  mov bx, 0x30e6  ; '     ║             FREEWARE GAMES: written by Kevin Bales           ║'
  0705e  lcall 0x7d6, 0x2d8d
  07063  lcall 0x7d6, 0x3021
  07068  mov bx, 0x3130  ; '     ║                             1250 Lindenwood Lane             ║'
  0706b  lcall 0x7d6, 0x2d8d
  07070  lcall 0x7d6, 0x3021
  07075  mov bx, 0x317a  ; '     ║                             Atlanta,Georgia 30319            ║'
  07078  lcall 0x7d6, 0x2d8d
  0707d  lcall 0x7d6, 0x3021
  07082  mov bx, 0x31c4  ; '     ║                             Phone# (404) 321-3841            ║'
  07085  lcall 0x7d6, 0x2d8d
  0708a  lcall 0x7d6, 0x3021
  0708f  mov bx, 0x320e  ; '     ╙──────────────────────────────────────────────────────────────╜'
  07092  lcall 0x7d6, 0x2d8d
  07097  xor bx, bx
  07099  lcall 0x7d6, 0xa3f
  0709e  lcall 0x7d6, 0xa3f
  070a3  lcall 0x7d6, 0xa59
  070a8  mov bx, 0x320
  070ab  mov dx, 0x11be
  070ae  lcall 0x7d6, 0x635
  070b3  mov bx, 0x18
  070b6  lcall 0x7d6, 0xffd
  070bb  mov bx, 0x1a
  070be  lcall 0x7d6, 0xffd
  070c3  xor bx, bx
  070c5  lcall 0x7d6, 0x1017
  070ca  lcall 0x7d6, 0x3021
  070cf  mov bx, 0x3258  ; 'Press any key to continue...'
  070d2  lcall 0x7d6, 0x2d79
L70D7:
  070d7  lcall 0x7d6, 0x23a1
  070dc  xchg bx, ax
  070dd  mov bx, 0x106a  ; ''
  070e0  lcall 0x7d6, 0xfd2
  070e5  je 0x70d7
  070e7  lcall 0x7d6, 0x1cc3
L70EC:
  070ec  lcall 0x7d6, 0x1739
  070f1  cmp bx, 0x35
  070f4  jne 0x70f9
  070f6  jmp 0x710e
L70F9:
  070f9  lcall 0x7d6, 0x789
  070fe  lcall 0x7d6, 0x3021
  07103  mov bx, 0x3278  ; 'UNRECOVERABLE ERROR! GET NEW COPY'
  07106  lcall 0x7d6, 0x2d8d
  0710b  jmp 0x715a
L710E:
  0710e  lcall 0x7d6, 0x789
  07113  mov bx, 0xa
  07116  lcall 0x7d6, 0xffd
  0711b  mov bx, 2
  0711e  lcall 0x7d6, 0x1017
  07123  lcall 0x7d6, 0x3021
  07128  mov bx, 0x329e  ; 'You are missing the file CASTLE.RAN'
  0712b  lcall 0x7d6, 0x2d8d
  07130  mov bx, 0xc
  07133  lcall 0x7d6, 0xffd
  07138  mov bx, 2
  0713b  lcall 0x7d6, 0x1017
  07140  lcall 0x7d6, 0x3021
  07145  mov bx, 0x32c6  ; 'Call Kevin Bales at 321-3841 for'
  07148  lcall 0x7d6, 0x2d8d
  0714d  lcall 0x7d6, 0x3021
  07152  mov bx, 0x32ea  ; ' a copy of this required data file.'
  07155  lcall 0x7d6, 0x2d8d
L715A:
  0715a  mov bx, 0x41c
  0715d  mov ds, word ptr [0x90]
  07161  mov bl, byte ptr [bx]
  07163  xor bh, bh
  07165  push es
  07166  pop ds
  07167  xchg bx, ax
  07168  mov bx, 0x41a
  0716b  mov ds, word ptr [0x90]
  0716f  mov byte ptr [bx], al
  07171  push es
  07172  pop ds
L7173:
  07173  lcall 0x7d6, 0x23a1
  07178  mov dx, 0xfba
  0717b  lcall 0x7d6, 0xf62
  07180  xchg dx, ax
  07181  mov bx, 0x106a  ; ''
  07184  lcall 0x7d6, 0xfd2
  07189  je 0x7173
  0718b  xor bx, bx
  0718d  lcall 0x7d6, 0xa3f
  07192  lcall 0x7d6, 0xa3f
  07197  lcall 0x7d6, 0xa59
  0719c  lcall 0x7d6, 0x789
  071a1  lcall 0x7d6, 0x15e7
