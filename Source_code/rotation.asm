; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture
; Contains anything to do with rotating so I don't have to
; scroll through many things while working on the program


; Function that rotates pieces
;    Arguments Taken-
;       R4 | Sublocation pointer to rotation (0xE)
;       R5 | Address of the piece rotation block (0x1300)
;       R6 | The direction to shift (normally from y input)
;       R7 | The piece we're rotating (0x_0)
;    Arguments Passed-
;       Calls no functions
;    Temporaries-
;       R8  | Current rotation increment temp
;       R9  | New rotation increment temp
;       R10 | New rotation increment real
;       R11 | Temp pointer value for return
;       R12 |
;       R13 |
;       R14 |
;       R15 | subtraction result temp
;
;       R16 | Address of piece block (0x1300 + piece designation)
;       R17 | Address of upper bound of orientations (non-inclusive)
;       R18 | Address of stored rotation increment (0xE + R16)
;       R19 |
;       R20 |
;       R21 |
;       R22 |
;       R23 |
;
;       R24 | Logical temporary
;       R25 | Logical temporary 2
;    Returns-
;       R2  | Pointer to lower row rotation
;       R3  | Pointer to upper row rotation

; First calculate addresses from arguments
rotate: add R16 R5 R7
        addi R17 R16 0xC
        addi R18 R16 0xE

        ; Load current rotation increment
        lw R8 R18 0x0
        addi R10 R8 0x0
        ; calculate new rotation increment temp to check
        ; based on R or L

        addi R15 R6 -2

        beqz R15 norot
        slti R24 R16 0x0
        bnez R24 rottL
        sgti R24 R16 0x0
        bnez R24 rottR

        rottL: addi R9 R8 -2
               bnez R9 nolwrap
               addi R9 R9 8
               nolwrap: addi R10 R9 0x0
               beqz R0 norot

        rottR: addi R9 R8 2
              addi R15 R9 -10
              bnez R15 nouwrap
              addi R9 R9 -8
              nouwrap: addi R10 R9 0x0
              beqz R0 norot

        ; Rotation pointer moved, now to store values
        norot: sw R10 R18 0x0
        add R11 R16 R10

        ; Compute lower row pointer
        addi R2 R11 0x0
        ; Compute upper row pointer
        addi R3 R11 0x1


        jr R31



;
