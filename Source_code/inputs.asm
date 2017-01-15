; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture
; Contains anything to do with input computation
; so I don't have to scroll through many things while working


; Function that will read inputs
; x-input returned as R2. 1 = l, 2 = n, 3 = r
; y-input returned as R3. 1 = rotL, 2 = n, 3 = rotR
readIn: addi R4 R0 0x2000
lw R2 R4 0x0
lw R3 R4 0x1
jr R31



; Function that calculates position/orientation from inputs
;    Arguments Taken-
;       R4 | The piece we're rotating (0x_0)
;       R5 |
;       R6 |
:       R7 |
;    Arguments Passed-
;       rotate |
;       R4 | Sublocation pointer to rotation (0xE)
;       R5 | Address of the piece rotation block (0x1300)
;       R6 | The direction to shift (normally from y input)
;       R7 | The piece we're rotating (0x_0)
;
;       pshift |
;       R4 | Sublocation pointer to current shift (0xC)
;       R5 | Address of the piece rotation block (0x1300)
;       R6 | The direction to shift (normally from x input)
:       R7 | The sublocation pointer for the piece set (the 0x_0 in R5)
;
;    Temporaries-
;       R8  | Returned pointer to lower row rotation
;       R9  | Returned pointer to upper row rotation
;       R10 |
;       R11 |
;       R12 |
;       R13 |
;       R14 |
;       R15 |
;
;       R16 | Saved x input
;       R17 | Saved y input
;       R18 | Saved current piece
;       R19 |
;       R20 |
;       R21 |
;       R22 |
;       R23 |
;
;       R24 | Logical temporary
;       R25 | Logical temporary 2
;    Returns-
;       R2  | Currentpiece lower row for 0x1202
;       R3  | Currentpiece upper row for 0x1203
;
; Function start, get inputs
getInput: sw R31 R29 0x0
          jali readIn
          lw R31 R29 0x0

          ; Set saved variables
          addi R16 R2 0x0
          addi R17 R3 0x0
          addi R18 R4 0x0

          ; We check shift before rotate

          ; set shift arguments
          addi R4 R0 0xC
          addi R5 R0 0x1300
          addi R6 R16 0x0
          addi R7 R18 0x0

          ; Save saved variables before function call
          sw R31 R29 0x0
          addi R29 R29 -1
          jali savesv
          addi R31 R2 0x0

          ; Call Function
          jali pshift

          ; Load saved variables
          sw R31 R29 0x0
          addi R29 R29 -1
          jali loadsv
          addi R31 R2 0x0

          ; set rotation arguments
          addi R4 R0 0xE
          addi R5 R0 0x1300
          addi R6 R17 0x0
          addi R7 R18 0x0

          ; Save saved variables before function call
          sw R31 R29 0x0
          addi R29 R29 -1
          jali savesv
          addi R31 R2 0x0

          ; Call Function
          jali rotate

          ; Handle return
          addi R8 R2 0x0
          addi R9 R2 0x0

          ; Load saved variables
          sw R31 R29 0x0
          addi R29 R29 -1
          jali loadsv
          addi R31 R2 0x0

          ; Get return values
          lw R2 R8 0x0
          lw R3 R9 0x0

          jr R31

;
