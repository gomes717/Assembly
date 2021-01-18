    
    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

Reset:
    ;CLEAN_START

    ldx #$80
    stx COLUBK

    lda #$1C
    sta COLUPF

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
    ;allow playfield to reflect
    ldx #$00000001      ;D0 = 1
    stx CTRLPF
    
    ;7 lines without playfield
    ldx #0
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7 
        sta WSYNC
    REPEND
    
    ;create the top wall
    ldx #%11100000
    stx PF0
    ldx #%11111111
    stx PF1
    stx PF2
    REPEAT 7 
        sta WSYNC
    REPEND

    ;create the left/right and inside walls
    ldx #%00100000
    stx PF0
    ldx #0
    stx PF1
    stx PF2
    REPEAT  42
        sta WSYNC
    REPEND

    ldx #%10100000
    stx PF0
    ldx #%10000000
    stx PF1
    ldx #0
    stx PF2
    REPEAT  7
        sta WSYNC
    REPEND

    ldx #%10100000
    stx PF0
    ldx #0
    stx PF1
    stx PF2
    REPEAT  66
        sta WSYNC
    REPEND

    ldx #%10100000
    stx PF0
    ldx #%10000000
    stx PF1
    ldx #0
    stx PF2
    REPEAT  7
        sta WSYNC
    REPEND

    ldx #%00100000
    stx PF0
    ldx #0
    stx PF1
    stx PF2
    REPEAT  42
        sta WSYNC
    REPEND

    ;create bottom wall
    ldx #%11100000
    stx PF0
    ldx #%11111111
    stx PF1
    stx PF2
    REPEAT 7 
        sta WSYNC
    REPEND

    ;7 lines without playfield
    ldx #0
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7 
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

    org $FFFC
    .word Reset
    .word Reset