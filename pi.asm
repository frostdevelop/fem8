#PI Calculator (Using Leibniz Infinite Series)
#Made by Lucas Lux
LDA 40 ;One (as top 2 bits)
MVR 00 ;The int part
LDA 03 ;Denominator (3 is first in series)
MVR 01
divlop:
INC 03 ;Mode (add or sub)
sublop:
LDA 80 ;One (as top one bit)
MVR 02
MVA 01
DIV 02 ;Get float of frac
INC 01
INC 01 ;Next number
MVA 03
JZO endsublop
MVA 02
SAR 01
SUB 00 ;Add to result
DEC 03
JUP sublop
endsublop:
MVA 02
SAR 01
ADD 00 ;Add to result
#output hex
MVA 00
SAL 02
OUT 00
MVA 01
MVR 02
LDA 03
SUB 02
MVA 02 ;Check if denom lower than zero for carry
JPG divlop
#Output stuff
MVA 00
SAR 04 ;Get int part (Just reinterpret instead of multiplying)
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
LDA 2E
OUT 01
MVA 00
SAL 04 ;Get rid of int part
SAR 04
JZO endit
MVR 01
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
SAR 04 ;What to shift to get the int part of 10*it
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
HLT
