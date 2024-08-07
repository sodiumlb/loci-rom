;
; Ullrich von Bassewitz, 1998-12-07, 2004-12-01
;
; Copy the data segment from the LOAD to the RUN location
;

        .export         copyaltfont
        .import         __FONTALT_LOAD__, __FONTALT_RUN__, __FONTALT_SIZE__
        .importzp       ptr1, ptr2, tmp1


copyaltfont:
        lda     #<__FONTALT_LOAD__         ; Source pointer
        sta     ptr1
        lda     #>__FONTALT_LOAD__
        sta     ptr1+1

        lda     #<__FONTALT_RUN__          ; Target pointer
        sta     ptr2
        lda     #>__FONTALT_RUN__
        sta     ptr2+1

        ldx     #<~__FONTALT_SIZE__
        lda     #>~__FONTALT_SIZE__        ; Use -(__DATASIZE__+1)
        sta     tmp1
        ldy     #$00

; Copy loop

@L1:    inx
        beq     @L3

@L2:    lda     (ptr1),y
        sta     (ptr2),y
        iny
        bne     @L1
        inc     ptr1+1
        inc     ptr2+1                  ; Bump pointers
        bne     @L1                     ; Branch always (hopefully)

; Bump the high counter byte

@L3:    inc     tmp1
        bne     @L2

; Done

        rts

