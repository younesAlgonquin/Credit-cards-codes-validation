; Add_Odd.assm
;
; Author(s):                                    Younes Boutaleb
; Student Number(s):                            041019068
; Date:                                         08/09/2021

;Purpose                                        Subroutine to calculate the sum of digits in odd position within the credit card code

;Preconditions:                                 Use accumulator A as a counter to keep the number of processed digits.
;                                               Use accumulator to keep adding algorithm result on on each odd digit
;
; Notes:     					Accumulator A keeps track of the current position of pointer X within the code
;                                               Accumulator B adds the odd digit calculation to its content after each loop
;
;
; Postcondition:                                Sum of Even digits is stored in memory after processing all Even digits
;                                               Only Accumulators A and B are distroyes at the end of the subroutine

Add_Odd
                    ldaa        #$00            ;Initialize register A to 0
                    ldab        #$00            ;Initialize register B to 0
                    clr         OFFSET1,y            ;clear memory position at cards array end

LoopOdd             ldab        OFFSET3,x             ;read the first odd position of credit card code
                    addb        OFFSET4,x+            ;read the same digit again and add it to register B. Move pointer X to the next odd digit
                    cmpb        #$0A            ;if the sum if less than nine jump (only one digit) we don't need to cross add the digits
                    blo         Next            ;ignore digits cross sum                           ;;;;;;
                    subb        #$0A            ;if the register b value is greater than 10 then get the last digit by substracting fron the original number (always between 0 and 18)
                    addb        #$01            ;add one to the found digit which represents the most left digit



Next                addb        OFFSET1,y            ;Add the result found from the previous odd digits to register A
                    stab        OFFSET1,y            ;Overwrite the memory data with the result
                    inca                        ;Increment register A (the counter) twice as register X moved two position through the code
                    inca
                    cmpa        #NUMDIGITS      ;Check if register X is still pointing to the same code
                    blo         LoopOdd         ;If it's true repeat the subroutine to the following odd digit


                    rts                         ; Sum of Odd Digit returned

                    end

; -------------------------------------
;        END of <Add_Odd> -
;--------------------------------------