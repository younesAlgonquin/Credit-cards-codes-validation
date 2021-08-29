; Validate_CC.asm
;
; Author(s):                                            Younes Boutaleb
; Student Number(s):                                    041019068
; Date:                                                 08/09/2021

;Purpose                                             	Subroutine to add all code digits and determine wether it's a valid code or not


;Preconditions:                                         Initialize the register B with the results of Add_Odd and Add_Even subroutines.
;
;
; Notes:           					This subroutine is called only after calling Add_Even and Add_Odd subroutines
;
;
;
; Postcondition:                                 	The number of valid/invalid CC codes is incremented
;

Validate_CC
                ldab            #$00                    ;Initialize register B  which will hold operations results
                addb            OFFSET1,y                    ;add the sum of odd and even digits to B
                addb            OFFSET2,y

GetReminder     cmpb            #$0A                    ;if it's less than ten then we don't need to divide it by 10
                blo             CompareReminder         ;Skip reminder determination process
                subb            #$0A                    ;If not keep substracting ten of register B till it's less than ten
                bra             GetReminder
                
CompareReminder cmpb            #$00                    ;If the reminder in register  B is equal to 0 then it's a valid code. Increment valid codes record
                beq             ValidLoop
                inc             InvalidResult           ;Otherwise increment invalid codes record
                bra             InvalidLoop
ValidLoop       inc             ValidResult

InvalidLoop     rts                                     ; Valid or Invalid Indicator returned

                end

; -------------------------------------
;        END of <Validate_CC> -
;--------------------------------------