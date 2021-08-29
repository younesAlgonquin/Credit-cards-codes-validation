; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
; Author(s):                                    Younes Boutaleb
; Student Number(s):                            041019068
; Date:                                         08/09/2021
;
; Purpose:                                      Credit Card Number Validation
;
; Preconditions:                                   Load the file containing the credit card codes
;                                                Define storage areas for variables, constants, array of CC codes and program code.
;                                                Configure hardware to display results.
;                                               Initialize constants and the stack and clear memory location that will hold the number valid/Invalid CC
;                                                Both pointers X and Y points to the beginning of CC codes array.
;
; Notes:                                        This is the main method which will call all subroutines and display the results;
;                                                  This program can handle any number of CC with any number of digits
;
;
; Postcondition:                                The program displays the results indefinitly using HEX Displays
;                                                  Registers A and B destroyed and reloaded after each loop
;                                                The number of valid/invalid CC is stored in the FINALRESULTS memory area.
;




; Address Constants - Do NOT change
STORAGE1        equ     $1000                   ; Storage starts here for original cards
FINALRESULTS    equ     $1030                   ; Final number of valid and invalid cards
PROGRAMSTART    equ     $2000                   ; Executable code starts here

; Hardware Configuration - Complete the Constant values
DIGIT3_PP0      equ    %1110                    ; HEX Display MSB (left most digit)
DIGIT0_PP3      equ    %0111                    ; Display LSB (right most digit)


; Program Constants - Do not change these values
NUMBERSOFCARDS  equ     6                       ; Six Cards to process
NUMDIGITS       equ     4                       ; Each Card has 4 digits

; You may add other Constant here if needed

OFFSET1         equ     24
OFFSET2         equ     26
OFFSET3         equ     0
OFFSET4         equ     2

; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                      ; HEX Display Multiplexing Delay

                org STORAGE1                    ; Note: a Label cannot be placed
Cards                                           ; on same line as org statement
#include        Sec_303_CC_Numbers.txt          ; substitute the appropriate file name here.
EndCards


; Do not change this code.
; Place your results here as you loop through your solution
                org  FINALRESULTS
InvalidResult   ds      1                       ; Count of Invalid CARDs processed
ValidResult     ds      1                       ; Count of Valid CARDs processed
; end of do not change

                org     ProgramStart
                lds     #ProgramStart           ; Stack used to protect values
; --- Your code starts here

                clr     InvalidResult           ;clear the number of Invalid code before starting the program
                clr     ValidResult             ;clear the number of valid code before starting the program

                ldx     #Cards                  ;Register X points to the array of credit cards codes
                ldy     #Cards                  ;Register Y points to the array of credit cards codes
                
SubroutinsLoop  jsr     Add_Odd                 ;subroutine to Calculate the sum gigits in odd positions of the code using the given algorithm
                jsr     Add_Even                ;subroutine to Calculate the sum of digits in even positions of the code using the given algorithm
                jsr     Validate_CC             ;subroutine to check wheather a code is valid or not
                ldaa    InvalidResult           ;Calculate the number of processed cards  by adding the number of valid codes to the number of invalid ones
                adda    ValidResult
                cmpa    #NUMBERSOFCARDS         ;Process the next code if there still unprocessed codes
                blo     SubroutinsLoop





; Do not change and code below here
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT3_PP0             ; Select MSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT0_PP3             ; Select LSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Eelay for DELAY_VALUE milliseconds
                bra     Display                 ; Endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                            ; you write this one
#include Add_Even.asm                           ; you write this one
#include Validate_CC.asm                        ; you write this one
#include Config_HEX_Displays.asm                ; provided to you - no changes permitted
#include Hex_Display.asm                        ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm            ; Library File    - no changes permitted

                end

************************* No Code Past Here ****************************

; -------------------------------------
;        END of <main()> -
;--------------------------------------