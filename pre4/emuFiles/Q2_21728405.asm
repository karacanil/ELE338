org 100h
;ELE338 - Preliminary Work 4 - Question 2
;Anýl Karaca - 21728405
JMP start
msgShape: DB "Enter S/s for square or T/t for triangle:",0Dh,0Ah,24h
msgHeightSquare: DB "Enter the height of the square (000-480):",0Dh,0Ah,24h
msgHeightTriangle: DB "Enter the height of the triangle (000-320):",0Dh,0Ah,24h
msgError: DB "It is not a valid input",0Dh,0Ah,24h

;Prints new line on the emulator screen
printNewline PROC
    MOV DX, 0Dh
    MOV AH, 2h
    INT 21h
    MOV DX, 0Ah
    MOV AH, 2h
    INT 21h
RET
printNewline ENDP

;This procedure takes 3 digit input and stores it in BP
formatInput PROC
    ;1st digit input
    MOV AH, 1h
    INT 21h
    SUB AX, 30h
    MOV BL, 100d
    MUL BL
    MOV BP, AX
    ;2nd digit input
    MOV AH, 1h
    INT 21h
    SUB AX, 30h
    MOV BL, 10d
    MUL BL
    ADD BP,AX
    ;3rd digit input
    MOV AH, 1h
    INT 21h
    
    MOV AH, 0d
    SUB AX, 30h
    ADD BP, AX     
RET
formatInput ENDP

squareProc PROC
    ;Prompt height of the square
    promptHeightSquare:
    CALL printNewline
    MOV DX, msgHeightSquare
    MOV AH, 9h
    INT 21h    
    CALL formatInput
    CMP BP, 480d ;Check if the input is valid
    JGE promptHeightSquare ;Keep looping until the input is valid
    
    ;Find starting point CX, DX
    MOV BX, 2d
    MOV DX, 0d
    MOV AX, BP
    DIV BX
    
    MOV CX, 320d ;Set CX to be half of screen width
    MOV DX, 240d ;Set DX to be half of screen height
    
    SUB CX, AX
    SUB DX, AX
    
    ;Find ending point SI, DI
    MOV SI, CX
    ADD SI, BP
    
    MOV DI, DX
    ADD DI, BP
    
    ;Open 640x480 screen    
    MOV AH, 0d
    MOV AL, 12h
    INT 10h
    INT 10h
    
    MOV AL, 3d ;Set the color of the pixels
    
    ;Print upper side
    upperSide:
    MOV AH, 0Ch
    INT 10h
    INC CX ;Update coordinate
    CMP CX, SI
    JLE upperSide
    
    ;Print right side
    rightSide:
    MOV AH, 0Ch
    INT 10h
    INC DX ;Update coordinate
    CMP DX, DI
    JLE rightSide
    
    ;Print bottom side
    SUB SI, BP
    bottomSide:
    MOV AH, 0Ch
    INT 10h
    DEC CX ;Update coordinate
    CMP CX, SI
    JGE bottomSide
    
    ;Print left side
    SUB DI, BP
    leftSide:
    MOV AH, 0Ch
    INT 10h
    DEC DX ;Update coordinate
    CMP DX, DI
    JGE leftSide
        
RET
squareProc ENDP

triangleProc PROC
    ;Prompt height of the triangle
    promptHeightTriangle:
    CALL printNewline
    MOV DX, msgHeightTriangle
    MOV AH, 9h
    INT 21h    
    CALL formatInput
    CMP BP, 320d ;Check if the input is valid
    JGE promptHeightTriangle ;Keep looping until the input is valid
    
    ;Find starting point CX, DX
    MOV BX, 2d
    MOV DX, 0d
    MOV AX, BP
    DIV BX
    PUSH AX ;Store this value so we can use it later
    
    MOV CX, 320d ;Set CX to be half of screen width
    MOV DX, 240d ;Set DX to be half of screen height
    
    SUB DX, AX
    
    ;Find ending point SI, DI
    MOV SI, CX
    ADD SI, AX
    
    MOV DI, DX
    ADD DI, BP
    
    ;Open 640x480 screen    
    MOV AH, 0d
    MOV AL, 12h
    INT 10h
    INT 10h
    
    MOV AL, 3d ;Set the color of the pixels
    
    ;Print right side
    rightSideTriangle:
    MOV AH, 0Ch
    INT 10h
    ADD DX, 2d ;Update coordinate
    INC CX
    CMP DX, DI
    JLE rightSideTriangle
    
    ;Print bottom side
    SUB SI, BP
    bottomSideTriangle:
    MOV AH, 0Ch
    INT 10h 
    DEC CX ;Update coordinate
    CMP CX, SI
    JGE bottomSideTriangle
    
    ;Print right side
    POP AX
    ADD SI, AX
    SUB DI, BP
    MOV AL, 3d ;Set the color of the pixels again  
    leftSideTriangle:
    MOV AH, 0Ch
    INT 10h
    SUB DX, 2d ;Update coordinate
    INC CX
    CMP DX, DI
    JGE leftSideTriangle

RET
triangleProc ENDP

start:
;Print prompt msg to get the shape
MOV DX, msgShape
MOV AH, 9h
INT 21h
;Get the shape input
MOV AH, 1h
INT 21h

;Check if the input is "S" or "s"
CMP AL, 53h
JZ square
CMP AL, 73h
JZ square
;Check if the input is "T" or "t"
CMP AL, 54h
JZ triangle
CMP AL, 74h
JZ triangle

;If the input is invalid print error msg
CALL printNewline
MOV DX, msgError
MOV AH, 9h
INT 21h
CALL printNewline
JMP start

square:
CALL squareProc ;Print square by calling it's procedure
JMP terminate
triangle:
CALL triangleProc ;Print triangle by calling it's procedure
JMP terminate
    
terminate:   
ret