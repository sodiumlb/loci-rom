;
; 2023, Rumbledethumps
; 2024, Sodiumlightbaby
;
; Enables the C IRQ tools

.export initirq, doneirq, _irq_int, _nmi_int
;.import callirq 
.import _exit, ReadKeyboard

.include "loci.inc"

.segment "ONCE"

initirq:
    lda #<handler
    ldx #>handler
    sei
    sta $FFFE
    stx $FFFF
    cli
    rts

.code

doneirq:
    sei
    rts

.segment "LOWCODE"

_irq_int:

_nmi_int:

handler:
    cld
    sei
    pha
    txa
    pha
    ;tsx
    ;inx
    ;inx
    ;lda $100,X
    ;and #$10
    ;bne break
    tya
    pha
    ;jsr callirq
    lda VIA_T1CL        ;clear timer interrupt
    jsr ReadKeyboard
    pla
    tay
    pla
    tax
    pla
    cli
    rti

break:
    lda #$FF
    sta MIA_A
    jmp _exit
