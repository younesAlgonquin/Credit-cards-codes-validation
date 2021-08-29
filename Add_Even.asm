; Add_Even.asm
;
; Author(s):                                   Younes Boutaleb
; Student Number(s):                           041019068
; Date:                                        08/09/2021

;Purpose                                       Subroutine to calculate the sum of digits in even positions within the credit card code

;Preconditions:                                 Use accumilator A as a counter to keep the number of processed digits.
;						Decrement pointer X to go back to first Even digit in the code after it was user in for odd digits.
;
; Notes:                			Accumulator A keeos track of the current position of pointer X within the code
;                                               Accumulator B adds the Even digit to its content after each loop
;
;
; Postcondition:                                Sum of Even digits is stored in memory after processing all Even digits
;                                               Only Accumulators A and B are distroyes at the end of the subroutine

Add_Even
                clr             OFFSET2,y       ;clear memory location where the sum will be stored
                ldaa            #$01           ;INITIALIZE THE COUNTER
DecrementX      dex                            ;move pointer X to the first Even digit in the current credit card code
                inca                           ;Register A counts the number of positions to decrement x
                cmpa            #NUMDIGITS
                bne             DecrementX      ;Loop until x reaches the first even digit of the current code
                
                ldaa            #$00            ;Initialize registers A to be used as a counter
                ldab            #$00            ;Initialize registers B store the value of the sum of Even digits
LoopEven        addb            OFFSET4,x+            ;Add the current even digit to register B then move to the next one
                inca
                inca
                cmpa            #NUMDIGITS
                blo             LoopEven
                stab            OFFSET2,y         ;Store the sum of even digits in memory
                dex
                
                rts                             ; Sum of Even Digits returned

                end

; -------------------------------------
;        END of <Add_Even> -
;--------------------------------------