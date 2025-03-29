#The FEMBOY RAYCASTER!
#Let's have the map be 16x16.(256 bits and 32 bytes)
#Can be 8x8 for beta
#SYSTEM
#-
#1. Use dot product to figure out then use threstholds for each ray (getting vector from position to wall) then using the magnitude of each ray for distance?
#2. Use a static rotation matrix to rotate vectors then walk on those vectors (accessing the memory of the int part) until meeting a wall (also use a counter for those steps for sizing).
#-
#Option 2 more efficient because rotating direction still req rotation matrix
#Use ALU flag for out of bounds (and render wall there)
#use 8 bit minifloat as well. or 4 bit . fixed point (16 lol);
#Memory API: 
#00 Function return 1
#01 Function return 2
#02 Arg 1
#03 Arg 2
#(Reg 03 is ret)
#20-3F: Map
#30: sin
#31: cos
#F0 X position 
#F1 Y Position
#F2 Directionx
#F3 Directiony
#Set fov to ~64 with rays every 4.
#Init playerpos to 4x4
LDA 04
MAP F0
MAP F1
#Init map
#00011100
#00001100
#00001000
#11000000
#11000011
#00000011
#11000000
#11001100
LDA 1C
MAP 20
LDA 0C
MAP 21
LDA 08
MAP 22
LDA C0
MAP 23
LDA C3
MAP 24
LDA 03
MAP 25
LDA C0
MAP 26
LDA CC
MAP 27
#Setup rot (all fixed point)
LDA FE ;cos()
MAP 31
LDA 19 ;sin()
MAP 30
#Bit(00,01) Function 
bit:
LDA 01
MVR 02
bitlop:
MVA 01 ;Bit#
JZO endblop
LDA 02
MLT 02
DEC 01
JUP bitlop
endblop:
MVA 02
AND 00
JPP 03
