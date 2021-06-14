org 100h
;ELE338 - Preliminary Work 4 - Question 1
;Anýl Karaca - 21728405
JMP start
msgShape: DB "Enter S/s for square or T/t for triangle:",0Dh,0Ah,24h
msgHeight: DB "Enter the height of the shape:",0Dh,0Ah,24h
msgError: DB "It is not a valid input",0Dh,0Ah,24h

;Prints "X" on the emulator screen
printX PROC
    MOV DX, 58h
    MOV AH, 2h
    INT 21h
RET
printX ENDP

;Prints space on the emulator screen    
printSpace PROC
    MOV DX, 20h
    MOV AH, 2h
    INT 21h
RET
printSpace ENDP

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

;Print prompt msg and get the height
getHeight PROC
    CALL printNewline
    MOV DX, msgHeight
    MOV AH, 9h
    INT 21h
    MOV AH, 1h
    INT 21h
RET
getHeight ENDP

;Controls the operation for square shape
squareProc PROC
    ;Get the height of the shape properly
    promptHeight:
    CALL getHeight
    MOV AH, 0d ;Reset AH
    ;Check if the input is valid
    CMP AX, 3Ah ;39h is "9" so we check 3Ah
    JGE promptHeight
    CMP AX, 30h ;30h is "0"
    JLE promptHeight
    
    MOV BX, 0d ;Reset BX
    SUB AL, 30h ;Turn the ASCII to integer
    MOV BL, AL ;Store the height in BL
    ;Check if the input is 1
    CMP AL, 1d
    JZ oneSquare
    
    MOV CX, 0d ;Reset CX
    MOV CL, BL
    ;Print the first line
    CALL printNewline
    firstLine:
    CALL printX
    LOOP firstLine
    
    MOV CX, BX
    SUB CX, 2d
    CMP CX, 0d ;Check if the height is 2
    JZ ifTwo ;If it is 2 skip the middle part  
    ;Print the middle lines
    middleLine:
    MOV SI, BX
    SUB SI, 2d
    
    CALL printNewline
    CALL printX ;Print the first X
    
    ;Print the spaces in between
    addSpace:
    CMP SI, 0d
    JZ doneSpace
    CALL printSpace
    DEC SI
    JMP addSpace
    
    doneSpace:
    CALL printX ;Print the second X
    LOOP middleLine
    
    ifTwo:
    MOV CX, 0d ;Reset CX
    MOV CL, BL
    
    ;Print the last line
    CALL printNewline
    lastLine:
    CALL printX
    LOOP lastLine
    CALL printNewline
    
    JMP terminateSquare
    
    oneSquare:
    CALL printNewline
    CALL printX
    ;JMP terminateSquare
    
terminateSquare:    
RET
squareProc ENDP

;Controls the operation for triangle shape
triangleProc PROC
    ;Get the height of the shape properly
    promptHeightTri:
    CALL getHeight
    MOV AH, 0d ;Reset AH
    ;Check if the input is valid
    CMP AX, 3Ah ;39h is "9" so we check 3Ah
    JGE promptHeightTri
    CMP AX, 31h ;31h is "1"
    JLE promptHeightTri
    
    MOV BX, 0d
    SUB AL, 30h
    MOV BL, AL ;Store the height in BL
    
    MOV CX, 0d ;Reset CX
    MOV CL, BL
    DEC CL
    ;Print the first line
    CALL printNewline
    firstLineSpace:
    CALL printSpace
    LOOP firstLineSpace
    CALL printX
    
    CMP BL, 2d ;Check if the height is 2
    JZ ifTwoTri ;If it is 2 skip the middle part
    
    MOV SI, 1d
    MOV BP, BX
    CALL printNewline
    ;Print the middle lines of a triangle
    middleLineTri:
    MOV CL, BL
    SUB CX, SI
    DEC CX
    ;Print the space before the first X
    firstSpace:
    CALL printSpace
    LOOP firstSpace
    
    ;Print the first X
    CALL printX
    
    MOV DI, SI
    ADD DI, DI
    DEC DI
    MOV CX, DI
    ;Print the space between the first and the second X 
    secondSpace:
    CALL printSpace
    LOOP secondSpace
    
    ;Print the second X and a new line
    CALL printX
    CALL printNewline
    
    INC SI
    DEC BP
    CMP BP, 2d
    JNZ middleLineTri
    JMP ifNotTwo
    
    ifTwoTri:
    CALL printNewline
    ifNotTwo:
    ;Print X on the last line
    MOV CL, BL
    ADD CL, CL
    DEC CL
    lastLineX:
    CALL printX
    LOOP lastLineX
        
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
CALL squareProc
JMP terminate
triangle:
CALL triangleProc
JMP terminate

    
terminate:   
ret