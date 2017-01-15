; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture
; Contains anything to do with shifting so I don't have to
; scroll through many things while working on the program



; Function that shifts pieces from the current shift to the desired shift
;    Arguments Taken-
;       R4 | Sublocation pointer to current shift (0xC)
;       R5 | Address of the piece rotation block (0x1300)
;       R6 | The direction to shift (normally from x input)
;            If 0 is passed in, assume default.
:       R7 | The sublocation pointer for the piece set (the _0 in R5)
;    Arguments Passed-
;       Calls no functions
;    Temporaries-
;       R8  | pieceRow counter
;       R9  | Current row temp
;       R10 |
;       R11 | Temporary holder for new shift
;       R12 |
;       R13 |
;       R14 | subtraciton result temp2
;       R15 | subtraction result temp
;
;       R16 | Address of piece block (0x1300 + piece designation)
;       R17 | Address of current shift for piece & upper bound of orientations
;       R18 | Current shift
;       R19 | Default shift
;       R20 | Desired shift
;       R21 |
;       R22 |
;       R23 |
;
;       R24 | Logical temporary
;       R25 | Logical temporary 2
;    Returns-
;       N/A
;
; Function start, calculate needed address from arguments
pshift: add R16 R5 R7
        add R17 R16 R4

        ; Now load current shift and default shift
        lw R18 R17 0x0
        lw R19 R17 0x1

        ; Is R6 0 (setup/new piece) or 1-3 (controller)
        ; If 0, we're resetting to default so
        ; R20 should be set to R19
        ; Otherwise,  R20 should be adjusted from R18 accordingly

        beqz R6 todeflt
        bnez R6 tonrml
        todeflt: addi R20 R19 0x0
        beqz R0 endtodn
        tonrml: addi R20 R18 0x0
          ; Calculate if R6 is 1 2 or 3
          ; SL for negative, SR for positive
          addi R15 R6 -2
              beqz R15 endtodn
              slti R24 R16 0x0
              bnez R24 ifSL
              sgti R24 R16 0x0
              bnez R24 ifSR

              ; For these if statements we first check if above/below bounds
              ; (note that we count shift from right corner)
              ifSL: addi R11 R20 1
                    sgei R24 R11 0xFF
                    bnez R24 endtodn
                    addi R20 R11 0x0
                    beqz R0 endtodn

              ifSR: addi R11 R20 -1
                    slti R24 R11 0x00
                    bnez R24 endtodn
                    addi R20 R11 0x0
                    beqz R0 endtodn
        ; At this point we have the current shift
        ; R18 and the desired shift R20

        ; Now we iterate over every orientation for that piece
        endtodn: addi R8 R16 0x0

        ; Here's the outer while loop.
        ; Go until R18 = R20
        shifting: sub R14 R20 R18
            ; if >0  shift left, if <0 shift right else end
            slti R24 R14 0x0
            sgti R25 R14 0x0
            beqz R14 enshift
            ; Here's the inner while loop. R17 has the upper bound of iteration
            ; Go until pointer on 0x13_C
            sh1: sub R15 R17 R8
                beqz R15 endsh1
                  bnez R25 shftL
                  bnez R24 shftR
                  beqz R0 retsft
                  ; Shifts
                  shftL: lw R9 R8 0x0
                          sll R9 R9
                          sw R9 R8 0x0
                          beqz R0 retsft
                  shftR: lw R9 R8 0x0
                          srl R9 R9
                          sw R9 R8 0x0
                          beqz R0 retsft
                  retsft: addi R8 R8 1
                          beqz R0 sh1
            endsh1: addi R8 R16 0x0

                    ; Adjust currentshift accordingly
                      bnez R25 eshftL
                      bnez R24 eshftR
                      beqz R0 ensh2
                      eshftL: addi R18 R18 1
                      beqz R0 ensh2
                      eshftR: addi R18 R18 -1
                      beqz R0 ensh2
                    ensh2: beqz R0 shifting
        enshift: sw R18 R16 0xC
        ; current shift stored and all piecerows have been shifted
        jr R31
