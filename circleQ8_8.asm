#Angles ig
#*Q8.8 fixed is forced due to nature of sin(1deg)
#This program doesn't operate rom consraints. (MLT segment too large) 
#todo:
#Optimization
#try subroutine format
#try Q4.4 fixed
#MM:
#00: COS
#01: SIN
#02: XINT
#03: YINT
#04: XFRAC
#05: YFRAC
#06: TEMPINT
#07: TEMPFRAC
#20: TEMPCALC
LDA FF ;cos
MAP 00
LDA 04 ;sin
MAP 01
LDA 00 ;X
MAP 02
LDA 01 ;Y
MAP 03
#Setup BACK
LDA 5F
MAP FA
LDA 01
MAP FF
LDA 40
MAP FB
LDA 0F*
MAP FD
LDA 80
MAP FE
LDA 04
MAP FF
LDA 01
MAP FF
LDA F0
MAP FD
LDA 08
MAP FE
LDA 04
MAP FF
LDA 01
MAP FF
#Making Sprite
LDA 18
MAP F9
LDA 00
MAP FD
LDA 04
MAP FF
#LOOP
rotlop:
MPA 02
MVR 00
MPA 03
MVR 01
MPA 04
MVR 02
MPA 05
MVR 03
LDA 06
MLT 00
MLT 01
LDA 08
ADD 00
ADD 01
MVA 00
SAL 04
MVR 00
MVA 01
SAL 04
SAR 04
IOR 00
MVA 00
MAP FE
#UPDATE
LDA 05
MAP FF
LDA 01
MAP FF
#ROTATE (The hard part) could be infeasable for caster due to size constraints
MPA 02
MVR 00
MPA 03
MVR 01
MPA 04
MVR 02
MPA 05
MVR 03
#MLT
#XFRAC
MPA 00
MLT 02
MVA 07 ;Decimal shifts so that overflow is correct.
MVR 02
#XINT
MPA 00
MLT 00
MVA 00
ADD 02
MVA 04
SAL 07 ;get the carry.
SAR 07
MAP 20
MVA 07
MVR 00
MPA 20
ADD 00
#YFRAC
MPA 01
MLT 03
MVA 07 ;Decimal shifts so that overflow is correct.
MVR 03
#YINT
MPA 01
MLT 01
MVA 01
ADD 03
MVA 04
SAL 07 ;get the carry.
SAR 07
MAP 20
MVA 07
MVR 01
MPA 20
ADD 01
#SUBTR
MVA 03
SUB 02
MVA 04
SAR 07
SAL 07
JZO neg
INC 01
neg:
MVA 01
SUB 00
MVA 00
JGE ncorr
INC 00
ncorr:
MVA 00
MAP 06
MVA 02
MAP 07
#2 (too large it's impossible.) I must use 8 bit.
#Commit
MPA 06
MAP 02
MPA 07
MAP 04
JUP rotlop
HLT
