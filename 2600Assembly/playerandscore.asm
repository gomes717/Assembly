    
    processor 6502

    include "vcs.h"
    include "macro.h"

    seg.u variables
    org $80
P0Height ds 1       ;defines 1 byte for this variable
P1Height ds 1

    seg code
    org $F000

Reset:
    ;CLEAN_START

    ldx #$80
    stx COLUBK

    lda #$1C
    sta COLUPF

    lda #$48
    sta COLUP0

    lda #$C6
    sta COLUP1

    lda #10
    sta P0Height  ;P0Height = 10
    sta P1Height  ;P1Height = 10

Startframe:
    lda #02
    sta VBLANK
    sta VSYNC

    ;first 3 lines of blank space
    ;sta WSYNC
    ;sta WSYNC
    ;sta WSYNC
    REPEAT 3
        sta WSYNC
    REPEND

    ;turn off vsync
    lda #0
    sta VSYNC

    ;37 lines of VBLANK
    REPEAT 37
        sta WSYNC
    REPEND

    ;turn off vblank
    lda #0
    sta VBLANK

    ;start playfield
    ;dont allow playfield to reflect
    ;score having the same color of the players
    ldx #%00000010      ;D1 = 1
    stx CTRLPF

    ;Start 192 lines of visible lines

    ;10 lines without playfield
    ldx #0
    stx PF0
    stx PF1
    stx PF2
    REPEAT 10 
        sta WSYNC
    REPEND

    ;draw the score board
    ldy #$0
ScoreBoardLoop:             ;Loop y<10
    lda Numberbitmap,Y
    sta PF1
    sta WSYNC
    iny
    cpy #10
    bne ScoreBoardLoop

    lda #0
    sta PF1



    ;blank lines between scoreboard and players
    REPEAT 50
        sta WSYNC
    REPEND

    ldy #0
Player0Loop:             ;Loop y<P0Height
    lda Playerbitmap,Y
    sta GRP0
    sta WSYNC
    iny
    cpy P0Height
    bne Player0Loop

    lda #0
    sta GRP0

    ldy #0
Player1Loop:             ;Loop y<P1Height
    lda Playerbitmap,Y
    sta GRP1
    sta WSYNC
    iny
    cpy P1Height
    bne Player1Loop

    lda #0
    sta GRP1

    ;
    REPEAT 102
        sta WSYNC
    REPEND

    ;finish the frame
    lda #2
    sta VBLANK
    REPEAT 30
        sta WSYNC
    REPEND

    lda #0
    sta VBLANK
    
    jmp Startframe

    org $FFE8
Playerbitmap:         ;TANQUE
    .byte #%00011000  ;   xx    
    .byte #%11011011  ;xx xx xx
    .byte #%11011011  ;xx xx xx
    .byte #%11111111  ;xxxxxxxx
    .byte #%11111111  ;xxxxxxxx
    .byte #%11111111  ;xxxxxxxx
    .byte #%11111111  ;xxxxxxxx
    .byte #%11111111  ;xxxxxxxx
    .byte #%11000011  ;xx    xx
    .byte #%11000011  ;xx    xx

    org $FFF2
Numberbitmap:
    .byte #%00001110
    .byte #%00001110
    .byte #%00000010
    .byte #%00000010
    .byte #%00001110
    .byte #%00001110
    .byte #%00001000
    .byte #%00001000
    .byte #%00001110
    .byte #%00001110


    org $FFFC
    .word Reset
    .word Reset