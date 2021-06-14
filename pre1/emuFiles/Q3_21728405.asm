org 100h

;ELE338 - Preliminary Work 1 - Question 3
;Anil Karaca - 21728405 

MOV CX, 8d ;Assigning 8 to CX, since we are dealing with 8-bit binary numbers
;MOV DX, 00101001b; Assigning the first example to DX register
MOV DX, 01101010b; Assigning the second example to DX register
MOV AX, 0d ;Initializing a counter to AX register

JMP Rotate ;Jump to "Rotate" to initialize the process
FoundZero: INC AX ;Increase AX by 1
DEC CX ;Decrease the counter

Rotate: ROR DX, 1 ;Rotate DX to the right
JCXZ Done; Terminate the program if CX is 0
JNC FoundZero; Jump to "FoundZero" if CF is 0
LOOP Rotate; Decrease CX and jump to "Rotate" if CF 1

Done: ret