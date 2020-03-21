print macro p1
pushear
mov ax,@data
mov ds, ax
mov ah,09h          ;Function(print string)
mov dx,offset p1         ;DX = String terminated by "$"
int 21h
popear           ;Interruptions DOS Functions
endm

crearArchivo macro p1 ;macro para la creacion de archivo
pushear

mov ax,@data;limpiamos el registro
mov ds,ax;lo pasamos a dx
mov ah,3ch
mov cx,0
mov dx,offset p1
int 21h
jc salir ;en case de un error
mov bx,ax
mov ah,3eh
int  21h

popear
endm

escribirEnArchivo macro p1,p2 ;macro para la creacion de archivo
pushear
;Escritura de archivo
mov cx,p2 ;num de caracteres a grabar
mov dx,offset p1
mov ah,40h
int 21h
popear
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
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
endm
