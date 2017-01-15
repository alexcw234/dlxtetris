; ICS 331
; Tetris
; Alex Watanabe
; Using DLX architecture

addi R8 R0 0x0

; R29 stack pointer
addi R29 R0 0xFFFFF


beqz R0 main




; Main function
main: jali setup
