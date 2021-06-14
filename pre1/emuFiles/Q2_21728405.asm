org 100h

;ELE338 - Preliminary Work 1 - Question 2
;Anil Karaca - 21728405    

MOV AX, 0d ;Assigning 1 to AX register which will indicate the position  
;MOV BX 10111111b ;Assigning the first example number to BX register 
MOV BX, 11111011b ;Assigning the second example number to BX register

Back: ROR BX, 1 ;Rotating BX to the right by one to check the LSB
INC AX ;Increase the position AX
JC Back ;Jump if the bit(CF) is 1

ret