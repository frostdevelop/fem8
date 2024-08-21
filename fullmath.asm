#FULL MATH on the Fem8!
LDA con1
MAP 00
JUP getinp
con1:
MVA 00
MAP 05
sign:
INP 00
JZO sign
OUT 01
MAP 06
LDA con2
MAP 00
JUP getinp
con2:
MVA 00
MVR 02
MPA 05
MVR 00
MPA 06
MVR 01
LDA 3D
OUT 01
# 0x20
LDA 2A
SUB 01
MVA 01
JZO cont1
LDA 03
SUB 01
MVA 01
# 0x30
JPG cont2
JPL cont3
MVA 02
SUB 00
JUP cont4
cont3:
MVA 02
ADD 00
JUP cont4
# 0x40
cont1:
MVA 02
MLT 00
JUP cont4
cont2:
MVA 02
DIV 00
cont4:
#Negation detection
MVA 00
JGE cont5
NOT 00
# 0x50
INC 00
LDA 2D
OUT 01
cont5:
MVA 00
JZO space
#Output 2 digits
MVR 01
MVR 02
LDA 64
DIV 01
MVA 01
JZO Ten
MVR 03
LDA 64
MLT 03
MVA 03
SUB 02
LDA 30
ADD 01
MVA 01
OUT 01
Ten:
MVA 02
MVR 01
LDA 0A
DIV 02
MVA 02
#JZO One
MVR 03
LDA 0A
MLT 03
MVA 03
SUB 01
LDA 30
ADD 02
MVA 02
OUT 01
One:
LDA 30
ADD 01
MVA 01
OUT 01
CLR 03
space:
LDA 20
# 0x60
OUT 01
JUP 00
getinp:
INP 00
JZO getinp
OUT 01
MVR 02
char2:
INP 00
JZO char2
OUT 01
MVR 01
LDA 30
SUB 01
SUB 02
MVA 01
JPL oneso
char3:
INP 00
JZO char3
OUT 01
MVR 00
LDA 30
SUB 00
MVA 00
JPL tenso
LDA 64
MLT 02
MVA 02
ADD 00
ptens:
LDA 0A
MLT 01
MVA 01
ADD 00
backinp:
MPA 00
MVR 01
JPP 01
oneso:
MVA 02
MVR 00
JUP backinp
tenso:
MVA 01
MVR 00
MVA 02
MVR 01
JUP ptens