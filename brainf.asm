startins:
LDA 3E ;Smart Compilation is quicker
OUT 01 ;A compiler would not be pheasable in this as all registers are used
inploop:
INP 00 ;Regular compilation would also be infeasable due to the doubling of instructions
JZO inploop
OUT 01
MVR 00
LDA 80
OUT 01
LDA 72
SUB 00
MVA 00 ;Check ASCII through cj
JZO run
JPL edit
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
LDA 0F
ADD 00
MVA 00
JZO startins ;Check for clear
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
LDA 5C
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
#Evaluator and compile
run:
CLR 01
LDA 80
MVR 03
# Register 02 stores input evaluated, 01 stores adr. after use 00 to store return loop address then use 03 to store pointer for ram.
eval:
MVA 01
MPR 02
MVA 02
JZO space
LDA 5B
SUB 02
MVA 02
JPG bac]
JZO skp[
# Check 2
LDA 1F
ADD 02
MVA 02
JPG pi>
JZO pd<
# Check 3
LDA 0F
ADD 02
MVA 02
JPG co.
JZO cd-
# Check 4
INC 02
MVA 02
JZO cin,
JPL ci+
conteval:
INC 01
JUP eval
# Evaluation Jumps
pi>:
INC 03; +8 ins
JUP conteval
pd<:
DEC 03; +8 ins
JUP conteval
ci+:
MVA 03
MPR 02
INC 02
MRP 02
JUP conteval
cd-:
MVA 03
MPR 02
DEC 02
MRP 02
JUP conteval
cin,:
INP 00
MVR 02
MVA 03
MRP 02
JUP conteval
co.:
MVA 03
MPR 02
MVA 02
OUT 01
JUP conteval
skp[:
MVA 03; +
MPR 02
MVA 02
JZO skp
MVA 01
MVR 00
JUP conteval
bac]:
MVA 03
MPR 02
MVA 02
JZO conteval
MVA 00
MVR 01
JUP conteval
skp:
MVA 01
MPR 02
LDA 5D
SUB 02
MVA 02
JZO conteval
INC 01
JUP skp