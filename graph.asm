#Function graphing
#Have it iterate along the 16 screen and create 16 sprites of points for each point (This is quad 1)
#Register setup: 00: row counter 11: General calculation 01: Memory buffer/general buffer
#Could use ram or accumulator as argument transfer method.
#INC 00 ;testing
#Initialize PPU
LDA FF
MAP FA
LDA 01
MAP FF
LDA 40
MAP FB
LDA E0
MAP F9
LDA 04
MAP FF
lop:
MVA 00
SAR 04
JPG deinit
MVA 00
JUP func
aftfunc:
MVR 01
SAR 04
JPG lopcyc
LDA 0F
MVR 03
MVA 01
SUB 03
MVA 00
SAL 04
IOR 03
#Output it to screen
MVA 03
MAP FE
LDA 05
MAP FF
LDA 01
MAP FF
lopcyc:
INC 00
JUP lop
deinit:
HLT
func:
#f(x)=((x/2-5)^3+5(x/2-5)^2)/3
SAR 01
MVR 03
LDA 05
SUB 03
MVA 03
MVR 02
MLT 03
MLT 03
MLT 02
LDA 05
MLT 02
MVA 02
ADD 03
LDA 03
DIV 03
MVA 03
JUP aftfunc