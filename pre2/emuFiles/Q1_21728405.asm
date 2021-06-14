org 100h
;ELE338 - Preliminary Work 2 - Question 1
;Anil Karaca - 21728405

;Get input
MOV BX, 0d ;Assign 0 to the counter BX
indata DB 10 DUP (?) ;Initialize the input array

input:
;Read input from screen, wait until a key is pressed         
MOV AH, 1d 
INT 21h
;Store the input in array indata
MOV AH, 0d            
MOV indata[BX], AL
;Increment counter, check if we are done taking input   
INC BX
CMP BX, 10d
JNZ input

;Swap case
MOV BX, 0d ;Assign 0 to the counter BX
outdata DB 10 DUP (?) ;Initialize the output array

swap:
XOR indata[BX], 20h ;Swap cases by XOR'ing a character with 20h
MOV CL, indata[BX] ;Store the output in an intermediate value
MOV outdata[BX], CL ;Store the output in output array  

;Increment counter, check if we are done swapping cases
INC BX
CMP BX, 10d
JNZ swap
              
;Display output
MOV BX, 0d ;Assign 0 to the counter BX

;New line
MOV DL, 0Dh ;Assign carriage return to DL 
MOV AH, 2d
INT 21h

MOV DL, 0Ah ;Assign line feed to DL 
MOV AH, 2d
INT 21h

output:           
MOV DL, outdata[BX] ;Assign line feed to DL
;Print the value of DL on the screen
MOV AH, 2d
INT 21h
;Increment counter, check if we are done printing
INC BX
CMP BX, 10d
JNZ output

;Terminate the program
MOV AH, 4CH
INT 21H
ret