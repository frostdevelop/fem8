#PI Calculator (Using Leibniz Infinite Series)
#Made by Lucas Lux
#MM
#00: OUT INT
#01: OUT FARAC
#02: CALC DENOM
#03: CALC MODE
#04: CALC REMAIN
#05: CALC FRAC REMAIN 
#06: CALC FRAC RES
LDA 01 ;One (Int part of out)
MAP 00
LDA 03 ;Denominator (3 is first in series)
MAP 02
divlop:
INC 00 ;Mode (add or sub)
sublop:
#No division required due to gauranteed remainder.
CLR 02
CLR 01
LDA 08 ;the 8 bits
MVR 03 ;Counter for shifts
LDA 01
MAP 04
#Fractional loop
fraclop:
MPA 04
SAL 01 ;Shift right
MVR 02
DEC 03
MPA 02
DIV 02 ;Divide and add
MVA 02
MAP 04
MVA 06
MAP 05
MVA 03
MVR 02
JZO endslop
JPL sarlop
sallop:
MPA 04 ;
SAL 01
MAP 04
DEC 02
MVA 02
JZO endslop
JUP sallop
sarlop:
MPA 04 ;
SAR 01
MAP 04
INC 02
MVA 02
JPL sarlop
endslop:
MPA 04 ;
ADD 01
MPA 05
JZO endflop
MAP 04
MVA 03
MVR 02
LDA 08
ADD 02
MVA 02
JZO endflop
JUP fraclop
endflop:
#end remain div
#MVA 01 ;Frac ans
#MAP 06
MPA 02
MVR 02
INC 02
INC 02 ;Next number
MVA 02
MAP 02
#New Regmap:
#02: Int part
#03: Frac part
MPA 00
MVR 02
MPA 01
MVR 03
#End regmap
MVA 00
JZO endsublop
MVA 01
SUB 03 ;Add to result
MVA 04
SAL 07
SAR 07
JPG skipdec
DEC 02
skipdec:
DEC 00
#Save result
MVA 02
MAP 00
MVA 03
MAP 01
JUP sublop
endsublop:
MVA 01
ADD 03 ;Add to result
MVA 04
SAL 07
SAR 07
ADD 02
#Save result
MVA 02
MAP 00
MVA 03
MAP 01
#Check
MPA 02
MVR 02
LDA 03 ;0B for check (de)
SUB 02
MVA 02 ;Check if denom lower than zero for carry
JPG divlop
endall:
MPA 01
SAR 06
#Start intout
MVR 01
#Only need one
LDA 30
ADD 01
MVA 01
OUT 01
#End Intout
MPA 01
SAL 02
#Start fixedout
MVR 01
LDA 2E
OUT 01
fixedlop:
LDA 0A
MLT 01
MVA 07
MVR 02
LDA 30
ADD 02
MVA 02
OUT 01
MVA 01
JNZ fixedlop
#End fixedout
HLT
