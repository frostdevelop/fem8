#Snake.
#Have a 16x16 grid of 2 bits (each byte will hold 4 and total would be 64 bytes allocated.
#This grid will be used to store the body of the snake where the cursor of the tail will travel through and read the direction and erase there once traveled. 
#Advance the snake and apple based on current direction after every clock check. (Add bittest maybe to isolate bits on fem-16vO)
#Also on the clock check, check for apple and head intersection and head body intersection (check for apple only in v1)
#WASD keys for direction (maybe lock if needed)
#Add background in later iterations.
#Have the matrix store tail direction pointing at head
#Better to have matrix before variables
#Tail place as of now is byte 21.
#4 pixels per byte (/2)
#4 bytes per row
#If too large, try to use more functions with register jump command.
#Clear Screen
LDA 01
MAP FF
#Flag setting (Disable background update)
LDA C0
MAP FB
#Time is set to 41 in memory, direction 42, (00 forward, 01 backward, 10 up, 11 down) score 43, matrix 00
#Direction
LDA 10
MAP 42
#Make snake tail
#POS
LDA 78
MAP FE
#Bake
LDA 04
MAP FF
#Make snake head.
LDA 01
MAP FC
#Color
LDA 19
MAP F9
#Set snake pos
LDA 88
MAP FE
#Bake
LDA 04
MAP FF
#Make apple
LDA 02
MAP FC
#CLR
LDA E0
MAP F9
LDA lop
MVR 02
JUP ranmos
#Initialize position matrix 
lop:
#Checking the time
MPA F6
MVR 00
MPA 41
XOR 00
MVA 00
JNZ lop
#Flip the time
MPA 41
MVR 00
LDA 01
XOR 00
MVA 00
MAP 41
INP 00 ;Check for movement requests
JNZ chkchr
cmov:
#Move head (Using opm)
LDA 01 ;Set ID
MAP FC
#Optimized position modification algorithm
MPA F8
MVR 00
MVR 01
MPA 42
SAR 04
SAL 04
ADD 00
LDA F0
AND 00
MVA 00
IOR 02
MPA 42
ADD 01
LDA 0F
AND 01
MVA 01
IOR 02
#End algorithm
MVA 02 ;Commit to P1
MAP FE
#ToDO: Bake changes to direction matrix (Mv to 1, shr 2, Mv to 0, shl 2, sub 1, 0 is address, 1 is the chosen two bits) next, transform the direction to two bits. (maybe start with two bits now?
LDA cbkdir
MVR 03
JUP getpos
cbkdir:
#Bake position to the head.
LDA 05 ;Bake changes
MAP FF
MPA 42 ;Get direction
MVR 02
LDA 10 ;Convert direction to new format algorithm (change direction format to be better)
SUB 02
MVA 02
JPG bw
JZO fw
LDA 0F
ADD 02
MVA 02
JPG up
JZO dw
bkmtx:
#Commit the direction to the matrix position
MVR 02
LDA 03
MVR 03 ;Use and on this later in order to delete that part
#Choose between an auto and jump
shlop:
#Shift to correct pair algorithm
MVA 01
JZO dlop
MVA 02
SAL 02 ;Shift actual data (to or it)
MVR 02
MVA 03
SAL 02 ;Shift the isolater
MVR 03
DEC 01 ;Decrement bit position
JUP shlop
#bake it to matrix
dlop:
NOT 03 ;Not the place to replace in order to isolate and delete
MVA 00
MPR 01 ;Get the matrix value at that place
MVA 03
AND 01 ;Delete old value
MVA 02
IOR 01 ;Commit value to matrix value
MVA 00
MRP 01
#Check for intersection with apple (snake intersection later)
LDA 02 ;Set ID
MAP FC
MPA FE ;Get head position
MVR 00
MPA F8 ;Get apple position
SUB 00 ;Compare and jump to apple if needed.
MVA 00
JZO apple
#Move tail
mtail:
LDA 00 ;Set ID
MAP FC
#ToDO: Retrieve matrix value by 8 bit position
LDA cget
MVR 03
JUP getpos ;Get the matrix position
cget:
MVA 00
MPR 02 ;Get the contents
glop:
#Loop to get the exact bit pair
MVA 01
JZO eglop
MVA 02
SAR 02
MVR 02
DEC 01
JUP glop
LDA 03
AND 02
MVA 02
eglop:
#Interpret
JZO r
MVR 00 
LDA 02
SUB 00
MVA 00
JZO u
JPG d
JPL l
JUP lop ;Done moving
chkchr:
MVR 00
LDA 53
SUB 00
MVA 00
JPG W
JZO S
LDA 12
ADD 00
MVA 00
JPG D
JZO A
JUP cmov
#ADD Chcks for opposite later
apple:
MPA 43
MVR 00
INC 00
MVA 00
MAP 43
LDA lop ;skip the tail update for simple growing
MVR 02
JUP ranmos
bw:
LDA 01
JUP bkmtx
fw:
LDA 00
JUP bkmtx
up:
LDA 02
JUP bkmtx
dw:
LDA 03
JUP bkmtx
W:
LDA 0F
JUP commit
A:
LDA F0
JUP commit
S:
LDA 01
JUP commit
D:
LDA 10
commit:
MAP 42
JUP cmov
ranmos:
LDA FF ;Get random value
MAP F7
MPA F7
MAP FE ;Set position
LDA 04 ;Bake
MAP FF
JPP 02
getpos:
MPA F8 ;Get position
MVR 01 ;01 is the bit pair number
SAR 02
MVR 00 ;00 is the Address
SHL 02
SUB 01 ;Get bit pair address
JPP 03