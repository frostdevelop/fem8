#232/27
#INT:00
#FRAC:01
#CALC: 10
#CALC: 11
#M00: X
#M01: Y
#M02: Remainder (Dividing)
#M03: Remainder (temp)
#ADD
LDA E8 ;232
MAP 00
MVR 00
LDA 1B ;27
MAP 01
ADD 00
MVA 04
SAL 07
SAR 07
MVR 01
#MLT
MPA 00
MVR 00
MPA 01
MLT 00
MVA 07
MVR 01
#DIV
MPA 00
MVR 00
MPA 01
DIV 00
MVA 06 ;remain
MAP 02
CLR 02
CLR 01
LDA 08 ;the 8 bits
MVR 03 ;Counter for shifts
#Fractional loop
fraclop:
MPA 02
SAL 01 ;Shift right
MVR 02
DEC 03
MPA 01 ;27
DIV 02 ;Divide and add
MVA 02
MAP 02
MVA 06
MAP 03
MVA 03
MVR 02
JZO endslop
JPL sarlop
sallop:
MPA 02
SAL 01
MAP 02
DEC 02
MVA 02
JZO endslop
JUP sallop
sarlop:
MPA 02
SAR 01
MAP 02
INC 02
MVA 02
JPL sarlop
endslop:
MPA 02
ADD 01
MPA 03
JZO endflop
MAP 02
MVA 03
MVR 02
LDA 08
ADD 02
MVA 02
JZO endflop
JUP fraclop
endflop:
HLT
