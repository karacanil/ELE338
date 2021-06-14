org 100h
;ELE338 - Preliminary Work 2 - Question 2
;Anil Karaca - 21728405

JMP start  
somewords DB "transistor inductor capacitor",'$'
start:
MOV BX, 0d ;Initialize the counter BX
;Make the first letter uppercase
XOR somewords[BX], 20h

loopOver:
;Check if we encounter the space(20h) character
CMP somewords[BX], 20h
JZ convertNext
;If the character is not space keep looking 
INC BX
CMP BX, 29d
JNZ loopOver
;Jump to display if have traversed the whole string
JMP display

convertNext:
;If we have encountered the space(20h) character make the next character uppercase
INC BX
XOR somewords[BX], 20h ;XOR the character with 20h so we can make it uppercase
;Go back to the loop which traverses the string
JMP loopOver

display:
MOV BX, 0d ;Reset the counter BX

loopDisplay:
MOV DL, somewords[BX] ;Assign the character to DL so we can print it
MOV AH, 2d ;Assign AH to 2d so we can print characters
INT 21h ;Open the command prompt
INC BX
;Check if we have done printing
CMP BX, 29d
JNZ loopDisplay

ret