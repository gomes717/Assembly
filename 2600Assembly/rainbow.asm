    processor 6502
    
    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

START:
    CLEAN_START
    
NextFrame:
    lda #2
    sta VBLANK
    sta VSYNC

    sta WSYNC
    sta WSYNC
    sta WSYNC

    lda #0
    sta VSYNC

    ldx #37
LoopVBlank:
    sta WSYNC
    dex
    bne LoopVBlank

    lda #0
    sta VBLANK

    ldx #192
LoopScanline:
    stx COLUBK
    sta WSYNC
    dex
    bne LoopScanline

    lda #2
    sta VBLANK

    ldx #30
LoopOverScan:
    sta WSYNC
    dex
    bne LoopOverScan

    jmp NextFrame

    org $FFFC
    .word START
    .word START