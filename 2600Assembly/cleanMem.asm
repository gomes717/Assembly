    processor 6502
    seg code
    org $F000

Start:
    sei
    cld
    ldx #$FF
    txs 

    lda #0
    ldx #$FF

memLoop:
    sta 0,X
    dex
    bne memLoop

    org $FFFC
    .word Start
    .word Start
    