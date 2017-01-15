; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture
;
; Contains utility functions called as intermediate steps
; so I don't have to scroll through many
; things while working on the program


; Function that saves R16 - R25 on the stack
; Uses no temporaries/arguments, doesn't save them either
; If I really need the arguments saved, just put them in saved variables
; Save, then decrement, then save then decrement, etc.
;    Arguments Taken-
;       N/A
;    Arguments Passed-
;       Calls no functions
;    Temporaries-
;       N/A
;    Returns-
;       R2 | The preserved return address from the calling function
;
;    Pre-call |
;                 sw R31 R29 0x0
;                 addi R29 R29 -1
;    Post-call |
;                 addi R31 R2 0x0

; First step is to load the return address into the return register
savesv: addi R29 R29 1
         lw R2 R29 0x0

         ; Now save all values properly
         sw R16 R29 0x0
         addi R29 R29 -1
         sw R17 R29 0x0
         addi R29 R29 -1
         sw R18 R29 0x0
         addi R29 R29 -1
         sw R19 R29 0x0
         addi R29 R29 -1
         sw R20 R29 0x0
         addi R29 R29 -1
         sw R21 R29 0x0
         addi R29 R29 -1
         sw R22 R29 0x0
         addi R29 R29 -1
         sw R23 R29 0x0
         addi R29 R29 -1

         ; stack pointer is now on a free address, return.
         jr R31



; Function that loads R16 - R25 from the stack
; Uses no temporaries/arguments, doesn't load them either
; Assumes stack pointer is pointed at a free address 2 below the
; R25 address (with the 1 below being the calling ra to return)
;    Arguments Taken-
;       N/A
;    Arguments Passed-
;      Calls no functions
;    Temporaries-
;       N/A
;    Returns-
;       R2 | The preserved return address from the calling function
;
;    Pre-call |
;                 sw R31 R29 0x0
;                 addi R29 R29 -1
;    Post-call |
;                 addi R31 R2 0x0

; First step is to load the return address into R2
loadsv: addi R29 R29 1
          lw R2 R29 0x0

          ; Now load all variables properly
          addi R29 R29 1
          lw R25 R29 0x0
          addi R29 R29 1
          lw R24 R29 0x0
          addi R29 R29 1
          lw R23 R29 0x0
          addi R29 R29 1
          lw R22 R29 0x0
          addi R29 R29 1
          lw R21 R29 0x0
          addi R29 R29 1
          lw R20 R29 0x0
          addi R29 R29 1
          lw R19 R29 0x0
          addi R29 R29 1
          lw R18 R29 0x0
          addi R29 R29 1
          lw R17 R29 0x0
          addi R29 R29 1
          lw R16 R29 0x0

          ; stack pointer now on address formerly holding R16
          ; and now considered free. Return
          jr R31
