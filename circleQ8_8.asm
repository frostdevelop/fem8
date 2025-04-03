#Angles ig
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
#I tried to functionize the entire multiplication "pipeline", register movement + other overheads takes too much.
#Q8.8 further neccessary due to it's small "computation" size. Other formats are very shift-heavy and it'll bloat the rom
COS = FF
SIN = 04
#Calc using !(FFFF >> (4 + bit# of SIN))
FSIN = FC
RAD = 6
CENT = 88
#LDA 00 ;X
#MAP 02
LDA 01 ;Y
MAP 03
#Setup BACK
LDA 5F
MAP FA
LDA 01 ;Remove if needed
MAP FF
LDA C0
MAP FB
#Making Sprite
LDA 18
MAP F9
#LDA 00
#MAP FD
#LDA 04
#MAP FF
#INIT FULLY COMPRESSED
#LOOP
rotlop:
LDA aftinit1
#MAR:REC
#OUT 01
JUP initt
#Up
aftinit1:
MVR 03
LDA RAD
MLT 00
MLT 01
#MVA 00
#MAP 50
#MVA 01
#MAP 51
MLT 02
MVA 07
ADD 00
LDA RAD
MLT 03
MVA 07
ADD 01
#LDA CENT
#ADD 00
#ADD 01
MVA 00
SAL 04
MVR 00
MVA 01
SAL 04
SAR 04
IOR 00
LDA CENT
ADD 00
MVA 00
MAP FE
#UPDATE
LDA 04
MAP FF
#LDA 01
#MAP FF
#ROTATE (The hard part) could be infeasable for caster due to size constraints Above fully optimized
LDA aftinit2
JUP initt
aftinit2:
MVR 03
#MLT
LDA afttrig1
JUP mtrig
afttrig1:
#SUBTR
SUB 02 ;Might've found a hardware glitch here...
#OH SHOTO I FORGOT THR FLAG REGISTER
#LDA 62 ;Change this to 62 and the algorithm fails...
MVA 04
SAL 07
JNZ pos
#MPA 02
#JPL pos
INC 01
pos:
MPA 02
SAR 7
ADD 0
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
MVR 00
MVA 07
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
ADD 03
MVA 04
SAL 07 ;get the carry.
SAR 07
MVR 01
MVA 07
ADD 01
#Return
MVA 03
MAP 31
MPA 30
MVR 03
MPA 31
JPP 03
initt:
MVR 03
MPA 02
MVR 00
MPA 03
MVR 01
MPA 04
MVR 02
MPA 05
JPP 03
