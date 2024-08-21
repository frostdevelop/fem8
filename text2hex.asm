LDA 20
OUT 01
INP 00
JZO 04
MVR 00
JUP outputchar
#Outputchar
outputchar:
MVA 00
JZO endit
#Output 2 digits
MVR 01
MVR 02
LDA 10
DIV 01
MVA 01
JZO One
MVR 03
LDA 10
MLT 03
MVA 03
SUB 02
LDA One
MAP 01
JUP printhex
One:
MVA 02
MVR 01
LDA endit
MAP 01
JUP printhex
endit:
MPA 00
MVR 01
JPP 01
printhex:
MVA 01
MVR 03
LDA 09
SUB 03
MVA 03
JPG Alph
LDA 30
ADD 01
MVA 01
OUT 01
JUP done
Alph:
LDA 40
ADD 03
MVA 03
OUT 01
done:
MPA 01
MVR 01
JPP 01