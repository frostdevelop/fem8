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
list:
CLR 00
LDA 0A
MVR 01
lstlop:
MVA 01
JZO space
MVA 00
MPR 03
MVA 03
JZO skpp
MVA 00
MVR 02
LDA 30
ADD 02
MVA 02
OUT 01
LDA 2C
OUT 01
skpp:
DEC 01
INC 00
JUP lstlop
view:
LDA 76
OUT 01
LDA display
MVR 02
JUP getloc
display:
MVA 00
JZO space
MVA 01
MPR 02
MVA 02
OUT 01
INC 01
DEC 00
JUP display
edit:
LDA 09
ADD 00
MVA 00
JZO startins
JPL append
LDA 65
OUT 01
LDA beforeloop ;init the registers for the loop
MVR 02
JUP getloc ;Get ram address of the start of the file
beforeloop:
CLR 03
editloop:
INP 00
JZO editloop
OUT 01
MVR 02
MVR 00
LDA 2E
SUB 02
MVA 02
JZO endedit
MVA 01
MRP 00
INC 03
INC 01
JUP editloop
endedit:
MVA 03
SUB 01
LDA 0A
SUB 01
MVA 01
JZO skpdec
LDA 18
DIV 01
MVA 01
skpdec:
MRP 03
JUP space
loped:
INP 00
JZO loped
MVR 01
MVA 00
MRP 01
JUP space
space:
LDA 20
OUT 01
JUP startins
getloc:
LDA 3E
OUT 01
lopine:
INP 00
JZO lopine
OUT 01
MVR 00
LDA 30
SUB 00
LDA 18
MVR 01
MVA 00
MLT 01
MPR 00
MVA 01
LDA 0A
ADD 01
LDA 80
OUT 01
JPP 02
append:
LDA 61
OUT 01
LDA addapp
MVR 02
JUP getloc
addapp:
MVA 00
ADD 01
JUP editloop