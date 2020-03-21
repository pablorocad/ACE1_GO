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

analizarEntrada macro p1,p2
pushear

mov bx,0
mov al,p1[bx]

s0:
cmp al,050h;si es P
  je comparar

cmp al,053h;si es S
  je comparar

cmp al,041h;si es A
  je escribirA

cmp al,042h;si es B
  je escribirB

cmp al,043h;si es C
  je escribirC

cmp al,044h;si es D
  je escribirD

cmp al,045h;si es E
  je s1

cmp al,046h;si es F
  je escribirF

cmp al,047h;si es G
  je escribirG

cmp al,048h;si es H
  je escribirH

s1:
mov bx,1
mov al,p1[bx]

cmp al,058h;si es X
  jne escribirE
  je comparar

escribirA:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirA1

cmp al,032h;si es 2
  je escribirA2

cmp al,033h;si es 3
  je escribirA3

cmp al,034h;si es 4
  je escribirA4

cmp al,035h;si es 5
  je escribirA5

cmp al,036h;si es 6
  je escribirA6

cmp al,037h;si es 7
  je escribirA7

cmp al,038h;si es 8
  je escribirA8


escribirB:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirB1

cmp al,032h;si es 2
  je escribirB2

cmp al,033h;si es 3
  je escribirB3

cmp al,034h;si es 4
  je escribirB4

cmp al,035h;si es 5
  je escribirB5

cmp al,036h;si es 6
  je escribirB6

cmp al,037h;si es 7
  je escribirB7

cmp al,038h;si es 8
  je escribirB8


escribirC:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirC1

cmp al,032h;si es 2
  je escribirC2

cmp al,033h;si es 3
  je escribirC3

cmp al,034h;si es 4
  je escribirC4

cmp al,035h;si es 5
  je escribirC5

cmp al,036h;si es 6
  je escribirC6

cmp al,037h;si es 7
  je escribirC7

cmp al,038h;si es 8
  je escribirC8


escribirD:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirD1

cmp al,032h;si es 2
  je escribirD2

cmp al,033h;si es 3
  je escribirD3

cmp al,034h;si es 4
  je escribirD4

cmp al,035h;si es 5
  je escribirD5

cmp al,036h;si es 6
  je escribirD6

cmp al,037h;si es 7
  je escribirD7

cmp al,038h;si es 8
  je escribirD8


escribirE:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirE1

cmp al,032h;si es 2
  je escribirE2

cmp al,033h;si es 3
  je escribirE3

cmp al,034h;si es 4
  je escribirE4

cmp al,035h;si es 5
  je escribirE5

cmp al,036h;si es 6
  je escribirE6

cmp al,037h;si es 7
  je escribirE7

cmp al,038h;si es 8
  je escribirE8

escribirF:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirF1

cmp al,032h;si es 2
  je escribirF2

cmp al,033h;si es 3
  je escribirF3

cmp al,034h;si es 4
  je escribirF4

cmp al,035h;si es 5
  je escribirF5

cmp al,036h;si es 6
  je escribirF6

cmp al,037h;si es 7
  je escribirF7

cmp al,038h;si es 8
  je escribirF8


escribirG:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirG1

cmp al,032h;si es 2
  je escribirG2

cmp al,033h;si es 3
  je escribirG3

cmp al,034h;si es 4
  je escribirG4

cmp al,035h;si es 5
  je escribirG5

cmp al,036h;si es 6
  je escribirG6

cmp al,037h;si es 7
  je escribirG7

cmp al,038h;si es 8
  je escribirG8


escribirH:
inc bx
mov al, p1[bx]

cmp al,031h;si es 1
  je escribirH1

cmp al,032h;si es 2
  je escribirH2

cmp al,033h;si es 3
  je escribirH3

cmp al,034h;si es 4
  je escribirH4

cmp al,035h;si es 5
  je escribirH5

cmp al,036h;si es 6
  je escribirH6

cmp al,037h;si es 7
  je escribirH7

cmp al,038h;si es 8
  je escribirH8


escribirA1:
mov bx,0
mov linea1[bx],p2
jmp salirAnalizador
escribirA2:
mov bx,0
mov linea2[bx],p2
jmp salirAnalizador
escribirA3:
mov bx,0
mov linea3[bx],p2
jmp salirAnalizador
escribirA4:
mov bx,0
mov linea4[bx],p2
jmp salirAnalizador
escribirA5:
mov bx,0
mov linea5[bx],p2
jmp salirAnalizador
escribirA6:
mov bx,0
mov linea6[bx],p2
jmp salirAnalizador
escribirA7:
mov bx,0
mov linea7[bx],p2
jmp salirAnalizador
escribirA8:
mov bx,0
mov linea8[bx],p2
jmp salirAnalizador

escribirB1:
mov bx,1
mov linea1[bx],p2
jmp salirAnalizador
escribirB2:
mov bx,1
mov linea2[bx],p2
jmp salirAnalizador
escribirB3:
mov bx,1
mov linea3[bx],p2
jmp salirAnalizador
escribirB4:
mov bx,1
mov linea4[bx],p2
jmp salirAnalizador
escribirB5:
mov bx,1
mov linea5[bx],p2
jmp salirAnalizador
escribirB6:
mov bx,1
mov linea6[bx],p2
jmp salirAnalizador
escribirB7:
mov bx,1
mov linea7[bx],p2
jmp salirAnalizador
escribirB8:
mov bx,1
mov linea8[bx],p2
jmp salirAnalizador

escribirC1:
mov bx,2
mov linea1[bx],p2
jmp salirAnalizador
escribirC2:
mov bx,2
mov linea2[bx],p2
jmp salirAnalizador
escribirC3:
mov bx,2
mov linea3[bx],p2
jmp salirAnalizador
escribirC4:
mov bx,2
mov linea4[bx],p2
jmp salirAnalizador
escribirC5:
mov bx,2
mov linea5[bx],p2
jmp salirAnalizador
escribirC6:
mov bx,2
mov linea6[bx],p2
jmp salirAnalizador
escribirC7:
mov bx,2
mov linea7[bx],p2
jmp salirAnalizador
escribirC8:
mov bx,2
mov linea8[bx],p2
jmp salirAnalizador

escribirD1:
mov bx,3
mov linea1[bx],p2
jmp salirAnalizador
escribirD2:
mov bx,3
mov linea2[bx],p2
jmp salirAnalizador
escribirD3:
mov bx,3
mov linea3[bx],p2
jmp salirAnalizador
escribirD4:
mov bx,3
mov linea4[bx],p2
jmp salirAnalizador
escribirD5:
mov bx,3
mov linea5[bx],p2
jmp salirAnalizador
escribirD6:
mov bx,3
mov linea6[bx],p2
jmp salirAnalizador
escribirD7:
mov bx,3
mov linea7[bx],p2
jmp salirAnalizador
escribirD8:
mov bx,3
mov linea8[bx],p2
jmp salirAnalizador

escribirE1:
mov bx,4
mov linea1[bx],p2
jmp salirAnalizador
escribirE2:
mov bx,4
mov linea2[bx],p2
jmp salirAnalizador
escribirE3:
mov bx,4
mov linea3[bx],p2
jmp salirAnalizador
escribirE4:
mov bx,4
mov linea4[bx],p2
jmp salirAnalizador
escribirE5:
mov bx,4
mov linea5[bx],p2
jmp salirAnalizador
escribirE6:
mov bx,4
mov linea6[bx],p2
jmp salirAnalizador
escribirE7:
mov bx,4
mov linea7[bx],p2
jmp salirAnalizador
escribirE8:
mov bx,4
mov linea8[bx],p2
jmp salirAnalizador

EscribirF1:
mov bx,5
mov linea1[bx],p2
jmp salirAnalizador
EscribirF2:
mov bx,5
mov linea2[bx],p2
jmp salirAnalizador
EscribirF3:
mov bx,5
mov linea3[bx],p2
jmp salirAnalizador
EscribirF4:
mov bx,5
mov linea4[bx],p2
jmp salirAnalizador
EscribirF5:
mov bx,5
mov linea5[bx],p2
jmp salirAnalizador
EscribirF6:
mov bx,5
mov linea6[bx],p2
jmp salirAnalizador
EscribirF7:
mov bx,5
mov linea7[bx],p2
jmp salirAnalizador
EscribirF8:
mov bx,5
mov linea8[bx],p2
jmp salirAnalizador

EscribirG1:
mov bx,6
mov linea1[bx],p2
jmp salirAnalizador
EscribirG2:
mov bx,6
mov linea2[bx],p2
jmp salirAnalizador
EscribirG3:
mov bx,6
mov linea3[bx],p2
jmp salirAnalizador
EscribirG4:
mov bx,6
mov linea4[bx],p2
jmp salirAnalizador
EscribirG5:
mov bx,6
mov linea5[bx],p2
jmp salirAnalizador
EscribirG6:
mov bx,6
mov linea6[bx],p2
jmp salirAnalizador
EscribirG7:
mov bx,6
mov linea7[bx],p2
jmp salirAnalizador
EscribirG8:
mov bx,6
mov linea8[bx],p2
jmp salirAnalizador

EscribirH1:
mov bx,7
mov linea1[bx],p2
jmp salirAnalizador
EscribirH2:
mov bx,7
mov linea2[bx],p2
jmp salirAnalizador
EscribirH3:
mov bx,7
mov linea3[bx],p2
jmp salirAnalizador
EscribirH4:
mov bx,7
mov linea4[bx],p2
jmp salirAnalizador
EscribirH5:
mov bx,7
mov linea5[bx],p2
jmp salirAnalizador
EscribirH6:
mov bx,7
mov linea6[bx],p2
jmp salirAnalizador
EscribirH7:
mov bx,7
mov linea7[bx],p2
jmp salirAnalizador
EscribirH8:
mov bx,7
mov linea8[bx],p2
jmp salirAnalizador

comparar:

salirAnalizador:

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
