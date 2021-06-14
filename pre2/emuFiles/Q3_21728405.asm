org 100h
;ELE338 - Preliminary Work 2 - Question 3
;Anil Karaca - 21728405

JMP start                                                
somewords DB "transistor inductor capacitor",'$'
start:
MOV BX, 0d ;Initialize the counter BX

inStack:
MOV CL, somewords[BX] ;Assign the character to CL so we can push it
PUSH CX ;Push the character to the stack
INC BX
CMP BX, 29d ;Check if we have pushed all the characters
JNZ inStack ;Loop until we push all the characters

MOV BX, 0d ;Reset the counter BX
outStack:
POP CX ;Pop the character out of the stack
MOV somewords[BX], CL ;Assign the characters back to array
INC BX
CMP BX, 29d ;Check if we have popped all the characters
JNZ outStack ;Loop until we pop all the characters

MOV BX, 0d ;Reset the counter BX
display:
MOV DL, somewords[BX] ;Assign the character to DL so we can print it
MOV AH, 2d ;Assign AH to 2d so we can print characters
INT 21h ;Open the command prompt
INC BX
;Check if we have done printing
CMP BX, 29d
JNZ display

ret