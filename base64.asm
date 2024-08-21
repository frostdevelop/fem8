# 00 is next and 01 is right now
INP 00
JZO 00 ;check if input is there
afterinp:
MVR 00
aftermv:
INC 02
MVA 02
MVR 03
LDA 02
SUB 03
MVA 03
JZO two
JPG three
MVA 00
SAR 02
IOR 01
MVA 00
SAL 04
MVR 00
JUP aftershift
two:
MVA 00
SAR 04
IOR 01
MVA 00
SAL 02
MVR 00
JUP aftershift
three:
CLR 02
MVA 00
SAR 06
IOR 01
aftershift:
LDA 3F
AND 01
LDA 41
ADD 01
MVA 01
MVR 03
LDA 74
SUB 03
MVA 03
JPG num
LDA 1A
ADD 03
MVA 03
JPG lower
fromval:
MVA 01
OUT 01
MVA 02
JZO szero
MVR 03
LDA 04
SUB 03
MVA 03
JZO sfour
MVA 00
MVR 01
continp:
INP 00
JZO valloop
JUP afterinp
lower:
LDA 06
ADD 01
JUP fromval
num:
LDA 0B
SUB 03
MVA 03
JZO plus
JPG slash
LDA 45
SUB 01
JUP fromval
plus:
LDA 2B
MVR 01
JUP fromval
slash:
LDA 2F
MVR 01
JUP fromval
szero:
MVA 00
MVR 01
LDA 04
MVR 02
JUP aftershift
sfour:
CLR 01
CLR 02
JUP continp
stoploop:
LDA 20
OUT 01
CLR 01
CLR 00
CLR 02
JUP 00
valloop:
MVA 01
JZO stoploop
CLR 00
JUP aftermv