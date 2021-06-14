org 100h
;ELE338 - Preliminary Work 3 - Question 2
;Anil Karaca - 21728405
MOV AX,0B007h ;Expected result:AX=700Bh
CALL swap
MOV AX,0AABBh ;Expected result:AX=BABAh
CALL swap
MOV AX,0EEDDh ;Expected result:AX=DEDEh
CALL swap
MOV AX,07700h ;Expected result:AX=0707h
CALL swap
MOV AX,07901h ;Expected result:AX=1907h
CALL swap
MOV AX,00FB6h ;Expected result:AX=6FB0h
CALL swap

ret

swap PROC
    
ROL AH,4 ;Swap the nibbles in AH
ROR AX,4 ;Rotate the number to the right by a nibble
ROL AL,4 ;Swap the nibbles in AL

RET
swap ENDP
