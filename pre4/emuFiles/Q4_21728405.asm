org 100h
;ELE338 - Preliminary Work 4 - Question 4
;Anýl Karaca - 21728405

JMP start

;Detect mouse cursor
detectMouse PROC
    mouseLoop:
    ;(CX,DX) in (x,y) format
    ;BX=1 -> left mouse button down
    MOV AX, 3d
    INT 33h
    CMP BX, 1d ;Check if the left mouse button is clicked
    JNZ mouseLoop
    CALL drawBox
    JMP mouseLoop
        
RET
detectMouse ENDP

;Draw a 2x2 box
drawBox PROC
    ;Store the location of the mouse cursor in (SI,DI) form
    SHR CX, 1 ;Divide CX by 2 to get the correct x-coordinate
    MOV SI, CX
    MOV DI, DX
    
    ;Set starting point(Upper Side)
    SUB CX, 1d
    SUB DX, 1d
    
    MOV AL, 2d ;Set the color of the pixels
    
    ;Set ending point(Upper Side)
    ADD SI, 1d
    ;Print upper side
    upperSide:
    MOV AH, 0Ch
    INT 10h
    INC CX ;Update coordinate
    CMP CX, SI
    JLE upperSide
    
    ;Set ending point(Right Side)
    ADD DI, 1d
    ;Print right side
    rightSide:
    MOV AH, 0Ch
    INT 10h
    INC DX ;Update coordinate
    CMP DX, DI
    JLE rightSide
    
    ;Set ending point(Bottom Side)
    SUB SI, 2d
    ;Print bottom side
    bottomSide:
    MOV AH, 0Ch
    INT 10h
    DEC CX ;Update coordinate
    CMP CX, SI
    JGE bottomSide
    
    ;Set ending point(Left Side)
    SUB DI, 2d
    ;Print left side
    leftSide:
    MOV AH, 0Ch
    INT 10h
    DEC DX ;Update coordinate
    CMP DX, DI
    JGE leftSide
    
RET
drawBox ENDP

start:
;Open 640x480 screen    
MOV AH, 0d
MOV AL, 12h
INT 10h
INT 10h

CALL detectMouse ;Initiate the process
ret