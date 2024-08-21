# Fixed point math on fem8
# 10.1875*1.3125
LDA A3
MAP 01
MVR 00
LDA sec
MAP 00
JUP outputchar
sec:
LDA 2A
OUT 01
LDA 15
MVR 00
MAP 02
LDA mlt
MAP 00
JUP outputchar
mlt:
MPA 01
MVR 00
LDA 3D
OUT 01
MPA 02
MLT 00
MVA 00
SAR 04
MVR 00
MVA 07
SAL 04
IOR 00
MVA 00
OUT 00
LDA contprg
MAP 00
JUP outputchar
contprg:
LDA 20
OUT 01
MPA 01
MVR 00
LDA nex
MAP 00
JUP outputchar
nex:
LDA 2F
OUT 01
MPA 02
MVR 00
LDA contnex
MAP 00
JUP outputchar
contnex:
LDA 3D
OUT 01
MPA 01
MVR 00
MPA 02
DIV 00
MVA 00
SAL 04
MVR 00
MVA 06
SAL 01
MVR 01
MPA 02
SAR 02
DIV 01
MVA 01
SAL 01
ADD 00
LDA halt
MAP 00
JUP outputchar
halt:
NOP
HLT #0.375
#Outputchar
outputchar:
MVA 00
SAR 04
JZO frac
#Output 2 digits
MVR 01
MVR 02
LDA 0A
DIV 01
MVA 01
JZO One
MVR 03
LDA 0A
MLT 03
MVA 03
SUB 02
LDA 30
ADD 01
MVA 01
OUT 01
One:
LDA 30
ADD 02
MVA 02
OUT 01
CLR 03
frac:
MVA 00
SAL 04
SAR 04
JZO endit
MVR 01
LDA 2E
OUT 01
LDA 04
MVR 00
fracl:
MVA 03
SUB 01
MVA 01
JZO endit
LDA 0A
MLT 01
MVA 01
SAR 04
MVR 02
SAL 04
MVR 03
LDA 30
ADD 02
MVA 02
OUT 01
DEC 00
MVA 00
JNZ fracl
endit:
CLR 03
MPA 00
MVR 00
JPP 00