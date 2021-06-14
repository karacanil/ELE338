org 100h
;ELE338 - Preliminary Work 3 - Question 1
;Anil Karaca - 21728405
MOV AX, 00000h ;Expected result:1 2 3 4
CALL findZero
MOV AX, 0D000h ;Expected result:2 3 4
CALL findZero
MOV AX, 00F0Ah ;Expected result:1 3
CALL findZero
MOV AX, 010F7h ;Expected result:2
CALL findZero
MOV AX, 0DDDDh ;Expected result:
CALL findZero
MOV AX, 02007h ;Expected result:2 3
CALL findZero

ret

findZero PROC

MOV SI, 1d ;Initialize the location counter SI
MOV BX, AX ;Assign AX to BX so we can freely work on BX

checkNibble:
CMP SI, 5d ;Check if we are done with the loop
JZ terminate 

SHR BX, 12 ;Leave the left most byte alone by shifting to the right
CMP BX, 0d ;Check if that byte is zero
JZ display ;If it is zero display it's location
continue:
INC SI ;Increment the location counter
ROL AX, 4 ;Rotate the AX to the left
MOV BX, AX ;Assign AX to BX so we can freely work on BX 
JMP checkNibble ;Jump to checkNibble 

display:
;Print the location of the zero we found
MOV DX, 30h
ADD DX, SI

MOV CX, AX ;Backup AX

MOV AH, 2d
INT 21h

;Print the space character
MOV DX, 20h
MOV AH, 2d
INT 21h

MOV AX, CX ;Restore AX back
JMP continue

terminate:
;Feed new line
MOV DX, 0Dh
MOV AH, 2d
INT 21h

MOV DX, 0Ah
MOV AH, 2d
INT 21h

RET
findZero ENDP