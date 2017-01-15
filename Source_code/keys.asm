; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture
;
; Contains comments on registers and addresses
; Keep on-hand and make sure to include in the final program
;


; Register Key
; R0      | constant 0
; R1      | assembler temporary
; R2-R3   | function return values
; R4-R7   | function arguments
; R8-R15  | temporaries
; R16-R23 | saved variables
; R24-R25 | temporaries
; R29     | stack pointer
; R31     | function return address

; temporaries will be further specified above the functions

; Address Key
; 0x1000 - 0x101F = 32x32 screen
; 0x1100 - 0x111F = 32x32 frame buffer
; 0x1200 = Currentpiece lower row
; 0x1201 = Currentpiece upper row
; 0x1202 = Check lower row
; 0x1203 = Check upper row
; 0x13A0 - 0x13E9 = Piece orientations as follows
; For the 2nd least significant bit:
;   A = single box
;   B = 2 boxes stacked
;   C = Diagonal boxes
;   D = L shape
;   E = 4 boxes in a square
; For the 1st least significant bit:
;   Every 2 is a new orientation (lower then upper)
;   2&3, 4&5, 6&7, 8&9
;   0&1, A&B is a placeholder to reset the rotation
;   C holds the current shift, defaults to 0x0
;   D holds the default shift of 0xF
;   E holds the rotation increment {2, 4, 6, 8}
;
; 0x2000 = x input. 1 = l, 2 = n, 3 = r
; 0x2001 = y input. 1 = rotL, 2 = n, 3 = rotR
; 0x3000 = score
;
