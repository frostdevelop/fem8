#Pong (No initialization of time)
#Set clr
LDA FF
MAP F9
start:
#Set direction
LDA F1
MAP 01
#Set pos2
LDA 03
MAP FD
#Set pos1
LDA 08
MAP FE
#Write
LDA 04
MAP FF
#Define ball and slot
LDA 01
MAP FC
#Set pos2
LDA 00
MAP FD
#Set pos1
LDA F7
MAP FE
#BAKE
LDA 04
MAP FF
#Flags
LDA 90
MAP FB
back:
#Back
LDA 00
MAP FC
#Main loop here (Check the timing for ball updates and also borders)
lop:
MPA F6
MVR 00
MPA 00
XOR 00
MVA 00
JZO mov
INP 00
JZO lop
OUT 01
MVR 02
MPA F8
MVR 00
LDA 73
SUB 02
MVA 02
JZO s
DEC 00
JUP upd
s:
INC 00
upd:
MVA 00
JPL lop
MVR 01
LDA 0C
SUB 01
MVA 01
JPG lop
MVA 00
MAP FE
LDA 05
MAP FF
JUP lop
mov:
MPA 00
MVR 00
LDA 01
XOR 00
MVA 00
MAP 00
#Initial X calc
CLR 02
#Get ball position
LDA 01
MAP FC
MPA F8
MVR 00
SAR 04
MVR 01
#Check if want to dec it
MPA 01
SAR 04
ADD 01
chy:
MVA 01
SAL 04
IOR 02
#Send to 01 for check.
#Now check
ccy:
MPA 01
ADD 00
fin:
LDA 0F
AND 00
AND 01
MVA 00
IOR 02
MVA 02
MAP FE
LDA 05
MAP FF
MVA 01
JZO inpad
MVA 00
JZO bou2
LDA 0F
SUB 01
SUB 00
MVA 01
JZO bou1
MVA 00
JZO bou3
#no more lda
JUP back
bou1:
LDA F1
MAP 01
JUP back
bou2:
LDA 11
MAP 01
JUP back
bou3:
LDA FF
MAP 01
JUP back
cup:
LDA 03
SUB 00
MVA 00
JPG res
rew:
LDA 01
MAP FC
INC 03
MVA 03
OUT 00
JUP back
inpad:
LDA 1F
MAP 01
#Check for hitbox by JGT and JLT array. if not, HLT, if do, inc and jump.
LDA 00
MAP FC
MPA F8
SUB 00
MVA 00
JGE cup
res:
INP 00
JZO res
CLR 03
LDA 00
MAP FE
OUT 00