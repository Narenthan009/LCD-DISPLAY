
	#include<p18f4550.inc>

lp_cnt	    equ 0x00
lp_cnt1  	equ 0x01

LCD_CTRL	equ PORTC
RS			equ RC4
RW			equ RC5
EN			equ RC6

		org	0x00
		goto	start
		org	0x08
		retfie
		org	0x18
		retfie



;==============================================================================================
;==============================================================================================

;Write a code to read input from a keypad, and two push buttons and display them on an LCD.
;Demonstrate the functionality of your code in Proteus. 

;Below are the requirements of the project.

;1. If the first push button is pressed, display your name on the first row of the LCD.
;2. If the second push button is pressed display your student id on the first row of the LCD.
;3. If any of the keypad button is pressed, display the number on the second row of the LCD.
;4. If nothing is pressed the LCD should not display anything.  

;==============================================================================================
;==============================================================================================



; SUBROUTINE FOR TIME DELAY


dup_nop		macro	kk
			variable i
i=0
			while i < kk
			nop
i+=1
			endw
			endm


D10ms		movlw	D'20'					; Delay for 10ms for 20MHz crystal
			movwf	lp_cnt1,A	
again1		movlw	D'250'
			movwf	lp_cnt,A
again		dup_nop	D'17'					; Standard operating time delay by operators
			decfsz	lp_cnt,F,A
			bra again
			decfsz	lp_cnt1,F,A
			bra	again1
			
			return	


; SUBROUTINE FOR COMMAND CODE


cmd_code	bcf		LCD_CTRL,RS,A ; RS=0	; Code to send command to LCD
			bcf		LCD_CTRL,RW,A ; RW=0			
			bsf		LCD_CTRL,EN,A ;	E=1
			call	D10ms
			bcf		LCD_CTRL,EN,A ;	E=0
		
			return


; SUBROUTINE TO SEND DATA


send_data	bsf		LCD_CTRL,RS,A ; RS=1	; Code to send data to LCD
			bcf		LCD_CTRL,RW,A ; RW=0			
			bsf		LCD_CTRL,EN,A ;	E=1
			call	D10ms
			bcf		LCD_CTRL,EN,A ;	E=0
		
			return


; SUBROUTINE FOR MY NAME 'NARENTHAN'

				
my_name		movlw	0x80      				 ; Start cursor at first line
			movwf	PORTD,A
			call	cmd_code
		;================================================================
			movlw	D'78'     						  ; Send alphabet 'N'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'65'     						  ; Send alphabet 'A'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'82'      						  ; Send alphabet 'R'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'69'      						  ; Send alphabet 'E'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'78'      						  ; Send alphabet 'N'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'84'     						  ; Send alphabet 'T'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'72'     						  ; Send alphabet 'H'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'65'      						  ; Send alphabet 'A'
			movwf	PORTD,A
			call	send_data
		;=================================================================		
			movlw	D'78'      						  ; Send alphabet 'N'
			movwf	PORTD,A
			call	send_data
		
			return


; SUBROUTINE FOR MY STUDENT ID 'DE95998'


my_id		movlw	0x80      				 ; Start cursor at first line
			movwf	PORTD,A
			call	cmd_code
		;=================================================================
			movlw	D'68'     						 ; Send alphabet 'D'
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'69'     						 ; Send alphabet 'E'
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'57'    						    ; Send number '9'
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'53'    						     ; Send number '5'
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'57'     						     ; Send number '9'
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'57'     							 ; Send number '9'
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'56'      							 ; Send number '8'
			movwf	PORTD,A
			call	send_data
		
			return


;	SUBROUTINE FOR NUMBERS '1' TO '9'


		;================================================================
num_0	    movlw	D'48'      							; Send number '0'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_1		movlw	D'49'     							; Send number '1'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_2		movlw	D'50'      							; Send number '2'
			movwf	PORTD,A
			call	send_data
		
			return	
		;================================================================
num_3		movlw	D'51'      							; Send number '3'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_4		movlw	D'52'      							; Send number '4'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_5		movlw	D'53'      							; Send number '5'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_6		movlw	D'54'      							; Send number '6'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_7		movlw	D'55'      							; Send number '7'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_8		movlw	D'56'      							; Send number '8'
			movwf	PORTD,A
			call	send_data
		
			return
		;================================================================
num_9		movlw	D'57'     						 	; Send number '9'
			movwf	PORTD,A
			call	send_data
		
			return


; SUBROUTINE TO ON LCD DISPLAY

	
on_LCD		movlw	0x0C			    	; On LCD display with cursor off
			movwf	PORTD,A
			call	cmd_code

			return


; SUBROUTINE TO CLEAR LCD DISPLAY


clr_LCD		movlw	0x01     							; Clear LCD display 
			movwf	PORTD,A
			call	cmd_code
			
			return


; SUBROUTINE TO CONFIGURE LCD


config_LCD	movlw	0x38    			  ; Configure 2 lines and 5x7 matrix
			movwf	PORTD,A
			call    cmd_code

			return


; SUBROUTINE FOR KEYPAD FIRST ROW 	


setupA		movlw	0xC0      					; Start cursor at second line
			movwf	PORTD,A	
			call	cmd_code

			bsf		PORTB,4,A				 ; Setup for keypad for first row
			bcf		PORTB,5,A
			bcf 	PORTB,6,A
			bcf		PORTB,7,A

			return


; SUBROUTINE FOR KEYPAD SECOND ROW 


setupB		movlw	0xC0      					 ; Start cursor at second line
			movwf	PORTD,A	
			call	cmd_code
		
			bcf		PORTB,4,A	 			 ; Setup for keypad for second row
			bsf		PORTB,5,A
			bcf		PORTB,6,A
			bcf		PORTB,7,A

			return


; SUBROUTINE FOR KEYPAD THIRD ROW 


setupC		movlw	0xC0      	 			      ; Start cursor at second line
			movwf	PORTD,A	
			call	cmd_code

			bsf		PORTB,6,A	 			   ; Setup for keypad for third row
			bcf		PORTB,7,A
			bcf		PORTB,5,A
			bcf		PORTB,4,A

			return


; SUBROUTINE FOR KEYPAD FOURTH ROW 


setupD		movlw	0xC0      					  ; Start cursor at second line
			movwf	PORTD,A	
			call	cmd_code

			bcf		PORTB,4,A	 			   ; Setup for keypad for fourth row
			bcf		PORTB,5,A
			bcf		PORTB,6,A
			bsf		PORTB,7,A

			return


; SPECIAL SUBROUTINE FOR STAR AND HASHTAG KEY


special_1	movlw	0x80      					 
			movwf	PORTD,A	
			call	cmd_code
			movlw	D'83'     						  
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'84'     						  
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'65'    						   
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'89'    						    
			movwf	PORTD,A
			call	send_data
			
			return
	

special_2	call	setupD
		
			movlw	D'83'     						     
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'65'     							
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'70'      							 
			movwf	PORTD,A
			call	send_data
		;=================================================================
			movlw	D'69'      							 
			movwf	PORTD,A
			call	send_data

			return




; MAIN PROGRAM


start		movlw	B'00001110'
			movwf	TRISB,A
			clrf	TRISC,A	  					       ; Configure TRIS
			clrf	TRISD,A
			
		;================================================================
			call	config_LCD	      ; Configure 2 lines and 5x7 matrix
		;================================================================
			call	on_LCD	        	; On LCD display with cursor off
		;================================================================
			
check		btfsc	PORTC,0,A	    ; If B0 not pressed, skip next line 
			call	my_id
			call	clr_LCD
			bcf		PORTC,0,A
			bra		check1
		
check1		btfsc 	PORTC,1,A 		; If B1 not pressed, skip next line
			call	my_name
			call	clr_LCD
			bcf		PORTC,1,A
			bra		show1		
		;================================================================
			
		
show1		call	setupA			; Show number 1
			btfsc	PORTB,1,A
			call	num_1
			bra		show2
			
			
		
show2		call	setupA			; Show number 2
			btfsc	PORTB,2,A
			call	num_2
			bra		show3
			

		
show3		call	setupA			; Show number 3
			btfsc	PORTB,3,A
			call	num_3
			bra		show4
		
		;================================================================
			
	
show4		call	setupB			; Show number 4
			btfsc	PORTB,1,A
			call	num_4
			bra		show5
				
		
		
show5		call	setupB			; Show number 5
			btfsc	PORTB,2,A
			call	num_5
			bra		show6

		
	
show6		call	setupB			; Show number 6
			btfsc	PORTB,3,A
			call	num_6
			bra		show7
		
		;================================================================
			
		
show7		call	setupC			; Show number 7
			btfsc	PORTB,1,A
			call	num_7
			bra		show8
				
		
		
show8		call	setupC			; Show number 8
			btfsc	PORTB,2,A
			call	num_8
			bra		show9

		
	
show9		call	setupC			; Show number 9
			btfsc	PORTB,3,A
			call	num_9
			bra		show_SP1
		;=================================================================
			
show_SP1	bcf		PORTB,6,A
			bsf		PORTB,7,A
			btfsc	PORTB,1,A		; Show SPECIAL 1
			call	special_1
			bra		show0
	
show0		call	setupD			; Show number 0
			btfsc	PORTB,2,A
			call	num_0
			bra		show_SP2

show_SP2	btfsc	PORTB,3,A		; Show SPECIAL 2
			call	special_2
			bra		check
		;=================================================================
		
			end










