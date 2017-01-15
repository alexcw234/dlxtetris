; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture
;
; Contains setup functions so I don't have to
; scroll through many things while working on the program



; Setup function
;    Arguments Taken-
;       None
;    Arguments Passed-
;       pshift |
;                R4 | Sublocation pointer to current shift (0xC)
;                R5 | Address of the piece rotation block 0x13_0 - 0x13_B
;                R6 | The direction to shift (normally from x input)
:                R7 | The sublocation pointer for the piece set (the _0 in R5)
;    Temporaries-
;       R8  |
;       R9  |
;       R10 |
;       R11 |
;       R12 |
;       R13
;       R14
;       R15
;
;       R16 | Default shift of 0xF (middle of screen)
;       R17 | Piece row 00
;       R18 | Piece row 01
;       R19 | Piece row 10
;       R20 | Piece row 11
;       R21 | Default rotation increment of 2
;       R22
;       R23
;
;       R24
;       R25
;
;    Returns-
;
;
;

; Function start. Stack pointer saved first
setup: sw R31 R29 0x0
  addi R29 R29 -1

; Because this is the setup there is no lw
; setting up registers for passing to pshift
; R4 is sublocation pointer to current shift (0xC)
addi R4 R0 0xC
; R5 is address to start from (also address of the shift)
addi R5 R0 0x1300
; R6 is the direction to shift (normally from x input)
; passing in 0 here instead for the setup
addi R6 R0 0x0
; R7 is the sublocation pointer for the piece set
addi R7 R0 0x0

; Here we set the default shifts and orientations

; set default shift
addi R16 R0 0xF
; piece occupation values 00 01 10 11
addi R17 R0 0x0
addi R18 R0 0x1
addi R19 R0 0x2
addi R20 R0 0x3

; default rotation increment
addi R21 2

; now we save all orientation positions, then call shift per piece
; A = single box

sw R0 R5 0xA0
sw R0 R5 0xA1
sw R18 R5 0xA2
sw R17 R5 0xA3
sw R19 R5 0xA4
sw R17 R5 0xA5
sw R17 R5 0xA6
sw R19 R5 0xA7
sw R17 R5 0xA8
sw R18 R5 0xA9
sw R0 R5 0xAA
sw R0 R5 0xAB
sw R0 R5 0xAC
sw R16 R5 0xAD
sw R21 R5 0xAE

; Save saved variables before function call
sw R31 R29 0x0
addi R29 R29 -1
jali savesv
addi R31 R2 0x0

; Set function arguments
addi R7 R0 0xA0

; Call Function
jali pshift

; Load saved variables
sw R31 R29 0x0
addi R29 R29 -1
jali loadsv
addi R31 R2 0x0


;   B = 2 boxes stacked
sw R0 R5 0xB0
sw R0 R5 0xB1
sw R18 R5 0xB2
sw R18 R5 0xB3
sw R20 R5 0xB4
sw R17 R5 0xB5
sw R19 R5 0xB6
sw R19 R5 0xB7
sw R17 R5 0xB8
sw R20 R5 0xB9
sw R0 R5 0xBA
sw R0 R5 0xBB
sw R0 R5 0xBC
sw R16 R5 0xBD
sw R21 R5 0xBE

; Save saved variables before function call
sw R31 R29 0x0
addi R29 R29 -1
jali savesv
addi R31 R2 0x0

; Set function arguments
addi R7 R0 0xB0

; Call Function
jali pshift

; Load saved variables
sw R31 R29 0x0
addi R29 R29 -1
jali loadsv
addi R31 R2 0x0

;   C = Diagonal boxes
sw R0 R5 0xC0
sw R0 R5 0xC1
sw R19 R5 0xC2
sw R18 R5 0xC3
sw R18 R5 0xC4
sw R19 R5 0xC5
sw R19 R5 0xC6
sw R18 R5 0xC7
sw R18 R5 0xC8
sw R19 R5 0xC9
sw R0 R5 0xCA
sw R0 R5 0xCB
sw R0 R5 0xCC
sw R16 R5 0xCD
sw R21 R5 0xCE

; Save saved variables before function call
sw R31 R29 0x0
addi R29 R29 -1
jali savesv
addi R31 R2 0x0

; Set function arguments
addi R7 R0 0xC0

; Call Function
jali pshift

; Load saved variables
sw R31 R29 0x0
addi R29 R29 -1
jali loadsv
addi R31 R2 0x0


;   D = L shape
sw R0 R5 0xD0
sw R0 R5 0xD1
sw R20 R5 0xD2
sw R18 R5 0xD3
sw R20 R5 0xD4
sw R19 R5 0xD5
sw R19 R5 0xD6
sw R20 R5 0xD7
sw R20 R5 0xD8
sw R18 R5 0xD9
sw R0 R5 0xDA
sw R0 R5 0xDB
sw R0 R5 0xDC
sw R16 R5 0xDD
sw R21 R5 0xDE

; Save saved variables before function call
sw R31 R29 0x0
addi R29 R29 -1
jali savesv
addi R31 R2 0x0

; Set function arguments
addi R7 R0 0xD0

; Call Function
jali pshift

; Load saved variables
sw R31 R29 0x0
addi R29 R29 -1
jali loadsv
addi R31 R2 0x0


;   E = 4 boxes in a square
sw R0 R5 0xE0
sw R0 R5 0xE1
sw R20 R5 0xE2
sw R20 R5 0xE3
sw R20 R5 0xE4
sw R20 R5 0xE5
sw R20 R5 0xE6
sw R20 R5 0xE7
sw R20 R5 0xE8
sw R20 R5 0xE9
sw R0 R5 0xEA
sw R0 R5 0xEB
sw R0 R5 0xEC
sw R16 R5 0xED
sw R21 R5 0xEE

; Save saved variables before function call
sw R31 R29 0x0
addi R29 R29 -1
jali savesv
addi R31 R2 0x0

; Set function arguments
addi R7 R0 0xE0

; Call Function
jali pshift

; Load saved variables
sw R31 R29 0x0
addi R29 R29 -1
jali loadsv
addi R31 R2 0x0


; Reloads the stack pointer
addi R29 R29 1
lw R29 R31 0x0

jr R31
