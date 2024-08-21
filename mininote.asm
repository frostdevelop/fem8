startins:
LDA 3E
OUT 01
inploop:
INP 00
JZO inploop
OUT 01
MVR 00
LDA 80
OUT 01
LDA 6C
SUB 00
MVA 00 ;Check ASCII through cj
JPG view
JPL edit
JUP startins
view:
LDA 76
OUT 01
LDA 3E
OUT 01
CLR 01 ;Location
display:
MVA 01
MPR 02
MVA 02
JZO space
OUT 01
INC 01
JUP display
edit:
LDA 09
ADD 00
MVA 00
JZO startins
JPL append
LDA 65
OUT 01
LDA 3E
OUT 01
CLR 01 ;Location
editloop:
INP 00
JZO editloop
OUT 01
MVR 02 ;02 and 00 are temp
MVR 00
LDA 2E
SUB 02
MVA 02
JZO endedit
MVA 01
MRP 00
INC 01
JUP editloop
endedit:
MVA 01
CLR 00
MRP 00
JUP space
space:
LDA 20
OUT 01
JUP startins
append:
MVA 01
MPR 00
MVA 00
JZO enap
INC 01
JUP append
enap:
LDA 61
OUT 01
LDA 3E
OUT 01
JUP editloop