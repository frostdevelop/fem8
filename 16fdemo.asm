#232/27
#INT:00
#FRAC:01
LDA E8 ;232
MVR 00
LDA 1B ;27
DIV 00 ;8
MVA 06 ;16
#do a sal 1 and chkz loop for real situations
SAL 03 ;Shift it right 3 (bits remain after div)
MVR 01
LDA 27
DIV 01
MVA 01
SAL 05 ;Get frac part
MVR 01
#new it
MVA 06
SAL 03 ;Shift right
MVR 02
LDA 27
DIV 02
MVA 02
SAL 02 ;Get frac part
ADD 01
#new it
MVA 06
SAL 03 ;Shift right
MVR 02
LDA 27
DIV 02
MVA 02
SAR 01 ;Get frac part
ADD 01
#new it
SAL 03 ;Shift right
MVR 02
LDA 27
DIV 02
MVA 02
SAR 04 ;Get frac part
ADD 01
#new it
SAL 03 ;Shift right
MVR 02
LDA 27
DIV 02
MVA 02
SAR 07 ;Get frac part
ADD 01
HLT
