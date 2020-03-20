include macro.asm

.model small
.stack 100h
.data
;db -> dato byte -> 8 bits
;dw -> dato word -> 16 bits
;dd -> doble word -> 32 bits
  inicio db 0ah,0dh,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',0ah,0dh,'FACULTAD DE INGENIERIA',0ah,0dh,'CIENCIAS Y SISTEMAS',0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1',0ah,0dh,'NOMBRE: PABLO ANDR',90h,'S ROCA DOMINGUEZ',0ah,0dh,'CARNET: 201700584',0ah,0dh,'SECCI',0a2h,'N: A',0ah,0dh,'$' ;caracter "$" para finalizar cadenas;
  ;se pueden concatenar caracteres ascii haciendo uso de su código ascii en decimal o en hexadecimal
  ;se concatenan con la coma, ejemplo: 'HOLA','_CONCATENADO',10h,'$'

   menuTexto db 0ah,0dh,'1) Iniciar Juego',0ah,0dh,'2) Cargar Juego',0ah,0dh,'3)Salir',0ah,0dh,'opcion: ', '$'
   ruta db 'guate.txt',0
   salto db 0ah,0dh,'$'

   ;definicion del tablero------------------------------------------------------
   ;000b -> vacio
   ;0001b -> Ficha negra
   ;010b -> ficha blanca
   linea8 db 000b,001b,001b,001b,000b,000b,000b,000b
   linea7 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea6 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea5 db 000b,000b,000b,010b,010b,000b,000b,000b
   linea4 db 000b,000b,000b,010b,000b,000b,000b,000b
   linea3 db 000b,000b,000b,010b,000b,000b,000b,000b
   linea2 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea1 db 000b,000b,000b,000b,000b,000b,000b,000b

   ;numeros-------------------
   ocho db 0ah,0dh,'8',020h,020h,020h,'$'
   siete db 0ah,0dh,'7',020h,020h,020h,'$'
   seis db 0ah,0dh,'6',020h,020h,020h,'$'
   cinco db 0ah,0dh,'5',020h,020h,020h,'$'
   cuatro db 0ah,0dh,'4',020h,020h,020h,'$'
   tres db 0ah,0dh,'3',020h,020h,020h,'$'
   dos db 0ah,0dh,'2',020h,020h,020h,'$'
   uno db 0ah,0dh,'1',020h,020h,020h,'$'

   vacio db '  ---','$'
   fb db 'FB---','$'
   fn db 'FN---','$'
   columnas db 0ah,0dh,020h,020h,020h,020h,'|    |    |    |    |    |    |    |','$'
   letras db 0ah,0dh,020h,020h,020h,020h,'A    B    C    D    E    F    G    H','$'
   ;----------------------------------------------------------------------------
.code

main  proc              ;Inicia proceso
print inicio

menuPrincipal:;menu principal--------------------------------------------
  print menuTexto

  call getchar

  cmp al,31h
    je iniciar
  cmp al,32h
    je cargar
  cmp al,33h
    je salir

iniciar:
  call pintarTablero
  jmp menuPrincipal

cargar:
  mov ax,@data
  mov ds,ax
  mov ah,3ch
  mov cx,0
  mov dx,offset ruta
  int 21h
  jc salir
  mov bx,ax
  mov ah,3eh
  int  21h
  jmp menuPrincipal
  ;---------------------------------------------------------------------------------------------

 salir:
   mov ah,4ch       ;Function (Quit with exit code (EXIT))
   xor al,al
   int 21h            ;Interruption DOS Functions

main endp

getchar proc near
mov ah,01h
int 21h
ret
getchar endp           ;Termina proceso

pintarTablero proc near;Proceso para imprimir el tablero
pushear
;FIla 8----------------------------------------------------
mov cx,7
mov bx,-1
print ocho
p8:
  inc bx
  mov al,linea8[bx]
  cmp al,000b
    je vap8

  cmp al,001b
    je fnp8

  cmp al,010b
    je fbp8

  vap8:;secciones para imprimir
  print vacio
  jmp re8

  fnp8:
  print fn
  jmp re8

  fbp8:
  print fb
  jmp re8

  re8:
Loop p8
print columnas

;FIla 7----------------------------------------------------
mov cx,7
mov bx,-1
print siete
p7:
  inc bx
  mov al,linea7[bx]
  cmp al,000b
    je vap7

  cmp al,001b
    je fnp7

  cmp al,010b
    je fbp7

  vap7:;secciones para imprimir
  print vacio
  jmp re7

  fnp7:
  print fn
  jmp re7

  fbp7:
  print fb
  jmp re7

  re7:
Loop p7
print columnas

;FIla 6----------------------------------------------------
mov cx,7
mov bx,-1
print seis
p6:
  inc bx
  mov al,linea6[bx]
  cmp al,000b
    je vap6

  cmp al,001b
    je fnp6

  cmp al,010b
    je fbp6

  vap6:;secciones para imprimir
  print vacio
  jmp re6

  fnp6:
  print fn
  jmp re6

  fbp6:
  print fb
  jmp re6

  re6:
Loop p6
print columnas

;FIla 5----------------------------------------------------
mov cx,7
mov bx,-1
print cinco
p5:
  inc bx
  mov al,linea5[bx]
  cmp al,000b
    je vap5

  cmp al,001b
    je fnp5

  cmp al,010b
    je fbp5

  vap5:;secciones para imprimir
  print vacio
  jmp re5

  fnp5:
  print fn
  jmp re5

  fbp5:
  print fb
  jmp re5

  re5:
Loop p5
print columnas

;FIla 4----------------------------------------------------
mov cx,7
mov bx,-1
print cuatro
p4:
  inc bx
  mov al,linea4[bx]
  cmp al,000b
    je vap4

  cmp al,001b
    je fnp4

  cmp al,010b
    je fbp4

  vap4:;secciones para imprimir
  print vacio
  jmp re4

  fnp4:
  print fn
  jmp re4

  fbp4:
  print fb
  jmp re4

  re4:
Loop p4
print columnas

;FIla 3----------------------------------------------------
mov cx,7
mov bx,-1
print tres
p3:
  inc bx
  mov al,linea3[bx]
  cmp al,000b
    je vap3

  cmp al,001b
    je fnp3

  cmp al,010b
    je fbp3

  vap3:;secciones para imprimir
  print vacio
  jmp re3

  fnp3:
  print fn
  jmp re3

  fbp3:
  print fb
  jmp re3

  re3:
Loop p3
print columnas

;FIla 2----------------------------------------------------
mov cx,7
mov bx,-1
print dos
p2:
  inc bx
  mov al,linea2[bx]
  cmp al,000b
    je vap2

  cmp al,001b
    je fnp2

  cmp al,010b
    je fbp2

  vap2:;secciones para imprimir
  print vacio
  jmp re2

  fnp2:
  print fn
  jmp re2

  fbp2:
  print fb
  jmp re2

  re2:
Loop p2
print columnas

;FIla 1----------------------------------------------------
mov cx,7
mov bx,-1
print uno
p1:
  inc bx
  mov al,linea1[bx]
  cmp al,000b
    je vap1

  cmp al,001b
    je fnp1

  cmp al,010b
    je fbp1

  vap1:;secciones para imprimir
  print vacio
  jmp re1

  fnp1:
  print fn
  jmp re1

  fbp1:
  print fb
  jmp re1

  re1:
Loop p1

print salto
print letras

popear
ret
pintarTablero endp      ;Termina proceso



end
