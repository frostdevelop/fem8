#Angles test ig
#Assemble with version 1.1
#MM:
#00: COS
#01: SIN
#02: XINT
#03: YINT
#04: XFRAC
#05: YFRAC
#06: TEMPINT
#07: TEMPFRAC
#08: TEMPINT2
#09: TEMPFRAC2
#20: TEMPCALC
#21: TEMPCALC2
#30: Ret
#31: Val
#40: Ret2
COS = FF
SIN = 04
FSIN = FC
#Calc using !(FFFF >> (4 + bit# of SIN))
#LDA 00 ;X
#MAP 02
LDA 01 ;Y
MAP 03
#LOOP
rotlop:
#ROTATE (The hard part) could be infeasable for caster due to size constraints
MPA 02
MVR 00
MPA 03
MVR 01
MPA 04
MVR 02
MPA 05
MVR 03

LDA 'a'
OUT 1
waitlop3:
INP 0
JZO waitlop3

#MLT
LDA afttrig1
JUP mtrig
afttrig1:
#SUBTR
SUB 02
MVA 04
SAL 07
#MVA 02
JNZ pos
INC 01
pos:
MVA 01
SUB 00
MVA 00
MAP 06
MVA 02
MAP 07
#Calc Y
MPA 03
MVR 00
MPA 02
MVR 01
MPA 05
MVR 02
MPA 04
MVR 03
#the really small calculation is messing it up
#However, I can't correct it using a double negation due to size constraints (again)
LDA afttrig2
JUP mtrig
afttrig2:
ADD 02
MVA 04
SAL 07
SAR 07
ADD 00
#Negate Correct
#MVA 01 ;I get this was cheating but HEAR ME OUT IT WORKS ALRIGHT!?
#SAR 1 ;Calc using 8-(4+3) (3 is the bit# of 4)
MPA 02
JGE skpfix
LDA FSIN ;Calc using !(FFFF >> 7) 
IOR 01
skpfix:
MVA 01
ADD 00
#Commit
MVA 00
MAP 03
MVA 02
MAP 05
MPA 06
MAP 02
MPA 07
MAP 04
JUP rotlop
#Everything above has been thoroughly optimized.
mtrig:
#XFRAC
MAP 30
LDA COS
MLT 02
MVA 07 ;Decimal shifts so that overflow is correct.
MVR 02
#XINT
LDA COS
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
#LDA SIN
#*4 is basically sal 2 so sar 8-2
MVA 03
SAR 6
MVR 03
#YINT
LDA SIN
MLT 01
MVA 01
#SAL 02
ADD 03
MVA 04
SAL 07 ;get the carry.
SAR 07
MAP 20
MVA 07
#SAR 6
MVR 01
MPA 20
ADD 01
#Return
MVA 03
MAP 31
MPA 30
MVR 03
MPA 31
JPP 03
