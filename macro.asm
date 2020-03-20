print macro p1
mov ax,@data
mov ds, ax
mov ah,09h          ;Function(print string)
mov dx,offset p1         ;DX = String terminated by "$"
int 21h               ;Interruptions DOS Functions
endm

pushear macro
  push ax
  push bx
  push cx
  push dx
  push si
  push di
endm

popear macro
  pop ax
  pop bx
  pop cx
  pop dx
  pop si
  pop di
endm
