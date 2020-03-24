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
   pathEsTablero db 'tablero.htm',0
   pathTableroFInal db 'final.htm',0
   pathArchivoG db 'texto2.txt',0
   salto db 0ah,0dh,'$'

   ;definicion del tablero------------------------------------------------------
   ;000b -> vacio
   ;0001b -> Ficha negra
   ;010b -> ficha blanca
   linea8 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea7 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea6 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea5 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea4 db 000b,000b,000b,000b,000b,000b,000b,000b
   linea3 db 000b,000b,000b,000b,000b,000b,000b,000b
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
   vacio8 db '  ','$'
   fb8 db 'FB','$'
   fn8 db 'FN','$'
   columnas db 0ah,0dh,020h,020h,020h,020h,'|    |    |    |    |    |    |    |','$'
   letras db 0ah,0dh,020h,020h,020h,020h,'A    B    C    D    E    F    G    H','$'

   ;----------------------------------------------------------------------------

   ;HTML========================================================================
   abrirHtml db '<HTML>',0ah,0dh,'<head><title>201700584</title></head>',0ah,0dh,'<body align=center>',0ah,0dh,'<table align=center border="0" cellspacing="0" cellpadding="0">'
   cerrarTabla db '</table>',0ah,0dh
   cerrarHtml db 0ah,0dh,'</body>',0ah,0dh,'</html>'
   abrirTr db '<tr>'
   cerrarTr db '</tr>'
   abrirTd db '<td>'
   cerrarTd db '</td>'
   etFb db '<TD><IMG SRC="blanca.png"></TD>'
   etFn db '<TD><IMG SRC="negra.png"></TD>'
   etVacia db '<TD><IMG SRC="vacia.png"></TD>'
   etCuadrado db '<TD><IMG SRC="cuadrado.png"></TD>'
   etCirculo db '<TD><IMG SRC="circulo.png"></TD>'
   etTriangulo db '<TD><IMG SRC="triangulo.png"></TD>'
   ochoHTML db '8'
   sieteHTML db '7'
   seisHTML db '6'
   cincoHTML db '5'
   cuatroHTML db '4'
   tresHTML db '3'
   dosHTML db '2'
   unoHTML db '1'
   ceroHTML db '0'
   aHTML db 'A'
   bHTML db 'B'
   cHTML db 'C'
   dHTML db 'D'
   eHTML db 'E'
   fHTML db 'F'
   gHTML db 'G'
   hHTML db 'H'
   fechaHora db '<h1>Fecha:00/00/2000 Hora: 00:00:00</h1>'
   winBlanco db '<h2>Ganador: Blanco</h2>'
   winNegro db '<h2>Ganador: Negro</h2>'
   winner db 'ganador'
   ;============================================================================

   ;==============Juego=================
   scriptTurnoNegra db 0ah,0dh,'Turno Negras: ','$'
   scriptTurnoBlanca db 0ah,0dh,'Turno Blancas: ','$'
   entrada db 4 dup('$'),'$'

   pass db 'PASS','$'
   exit db 'EXIT','$'
   show db 'SHOW','$'
   save db 'SAVE','$'

   detExit db 000b
    detPass db 000b
   ;====================================
   handler dw ?
   texto db 65 dup('$')
.code

main  proc              ;Inicia proceso
print inicio

menuPrincipal:;menu principal--------------------------------------------
  print menuTexto
  call vaciarTablero
  call getchar

  cmp al,31h
    je iniciar
  cmp al,32h
    je cargar
  cmp al,33h
    je salir

iniciar:

;call pintarTablero
;jmp menuPrincipal
;crearArchivo pathEsTablero
  ;call pintarTablero
  turnoNegras:
    print scriptTurnoNegra
    mov detExit,000b
    call leerEntrada
    mov ah,001b
    call analizarEntrada
    call eliminarFicha

    mov al,detExit
    cmp al,100b
    je retornoMenu
    cmp al,001b
    je turnoNegras

    call pintarTablero
    jmp turnoBlancas
    ;jmp retornoMenu

  turnoBlancas:
    print scriptTurnoBlanca
    mov detExit,000b
    call leerEntrada
    mov ah,010b
    call analizarEntrada
    call eliminarFicha

    mov al,detExit
    cmp al,100b
    je retornoMenu
    cmp al,001b
    je turnoBlancas



    call pintarTablero
    jmp turnoNegras
    ;jmp retornoMenu

  retornoMenu:
  jmp menuPrincipal

cargar:
  call leerArchivo
  call cargarPartida
  call pintarTablero

  jmp iniciar
  ;---------------------------------------------------------------------------------------------

 salir:
   mov ah,4ch       ;Function (Quit with exit code (EXIT))
   xor al,al
   int 21h            ;Interruption DOS Functions

main endp

;===============================================================================================================
;========================================PROCESOS===============================================================
;===============================================================================================================
getchar proc near
mov ah,01h
int 21h
ret
getchar endp           ;Termina proceso

leerEntrada proc near

pushear
mov ax,@data
mov ds,ax
mov ah,3fh
mov bx,00
mov cx,5
mov dx,offset[entrada]
int 21h

;print salto

;mov ah,09h
;mov dx,offset[entrada]
;int 21h
popear

;print fb

ret
leerEntrada endp


GetDate proc
    mov ah,2ah
    int 21h

    mov al,dl
    call convert
    mov [bx + 10],ax

    mov al,dh
    call convert
    mov [bx + 13],ax

    mov ah,2ah
    int 21h
    add cx,0F830H
    mov ax,cx
    aam
    mov cx,ax

    call Disp
    ret
GetDate endp

GetTime proc
    mov ah,2ch
    int 21h

    mov al,ch
    call Convert
    mov [bx + 27],ax

    mov al,cl
    call convert
    mov [bx+30],ax

    mov al,dh
    call convert
    mov [bx+33],ax

    ret
GetTime endp

Convert proc
    mov ah,0
    mov dl,10
    div dl
    or ax,3030h
    ret
Convert endp

disp proc
    MOV dl,ch      ; Since the values are in BX, BH Part
    ADD dl,30h    ; ASCII Adjustment
    mov [bx+18],dl

    MOV dl,cl      ; BL Part
    ADD dl,30h     ; ASCII Adjustment
    mov [bx+19],dl
    RET
disp endp      ; End Disp Procedure

leerArchivo proc near
;pushear

mov ah,3dh
mov al,0 ;indicar que se abre archivo en lectura
mov dx,offset pathArchivoG
int 21h
mov handler,ax

mov ah,3fh
mov bx,handler
mov cx,64
lea dx,texto
int 21h

fin:
  mov ah,3eh
  mov bx,handler
  int 21h

;popear
ret
leerArchivo endp

vaciarTablero proc near
pushear

mov cx,8
mov bx,-1
p8:
inc bx
mov linea8[bx],000b
Loop p8

mov cx,8
mov bx,-1
p7:
inc bx
mov linea7[bx],000b
Loop p7

mov cx,8
mov bx,-1
p6:
inc bx
mov linea6[bx],000b
Loop p6

mov cx,8
mov bx,-1
p5:
inc bx
mov linea5[bx],000b
Loop p5

mov cx,8
mov bx,-1
p4:
inc bx
mov linea4[bx],000b
Loop p4

mov cx,8
mov bx,-1
p3:
inc bx
mov linea3[bx],000b
Loop p3

mov cx,8
mov bx,-1
p2:
inc bx
mov linea2[bx],000b
Loop p2

mov cx,8
mov bx,-1
p1:
inc bx
mov linea1[bx],000b
Loop p1
popear
ret
vaciarTablero endp

pintarTablero proc near;Proceso para imprimir el tablero
pushear
;FIla 8----------------------------------------------------
mov cx,8
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
mov cx,8
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
mov cx,8
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
mov cx,8
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
mov cx,8
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
mov cx,8
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
mov cx,8
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
mov cx,8
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

reporteActualTablero proc near
pushear

editar:
;abrir el archivo
mov ah,3dh
mov al,1h ;Abrimos el archivo en solo escritura.
mov dx,offset pathEsTablero
int 21h
;jc salir ;Si hubo error
mov bx,ax ; mover hadfile
escribirEnArchivo abrirHtml,SIZEOF abrirHtml

;FIla 8----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr

escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo ochoHTML,SIZEOF ochoHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html8:
  inc di
  mov al,linea8[di]
  cmp al,000b
    je vahtml8

  cmp al,001b
    je fnhtml8

  cmp al,010b
    je fbhtml8

  vahtml8:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml8

  fnhtml8:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml8

  fbhtml8:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml8

  rehtml8:
Loop html8
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 7----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo sieteHTML,SIZEOF sieteHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html7:
  inc di
  mov al,linea7[di]
  cmp al,000b
    je vahtml7

  cmp al,001b
    je fnhtml7

  cmp al,010b
    je fbhtml7

  vahtml7:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml7

  fnhtml7:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml7

  fbhtml7:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml7

  rehtml7:
Loop html7
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 6----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo seisHTML,SIZEOF seisHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html6:
  inc di
  mov al,linea6[di]
  cmp al,000b
    je vahtml6

  cmp al,001b
    je fnhtml6

  cmp al,010b
    je fbhtml6

  vahtml6:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml6

  fnhtml6:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml6

  fbhtml6:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml6

  rehtml6:
Loop html6
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 5----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cincoHTML,SIZEOF cincoHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html5:
  inc di
  mov al,linea5[di]
  cmp al,000b
    je vahtml5

  cmp al,001b
    je fnhtml5

  cmp al,010b
    je fbhtml5

  vahtml5:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml5

  fnhtml5:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml5

  fbhtml5:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml5

  rehtml5:
Loop html5
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 4----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cuatroHTML,SIZEOF cuatroHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html4:
  inc di
  mov al,linea4[di]
  cmp al,000b
    je vahtml4

  cmp al,001b
    je fnhtml4

  cmp al,010b
    je fbhtml4

  vahtml4:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml4

  fnhtml4:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml4

  fbhtml4:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml4

  rehtml4:
Loop html4
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 3----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo tresHTML,SIZEOF tresHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html3:
  inc di
  mov al,linea3[di]
  cmp al,000b
    je vahtml3

  cmp al,001b
    je fnhtml3

  cmp al,010b
    je fbhtml3

  vahtml3:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml3

  fnhtml3:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml3

  fbhtml3:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml3

  rehtml3:
Loop html3
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 2----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo dosHTML,SIZEOF dosHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html2:
  inc di
  mov al,linea2[di]
  cmp al,000b
    je vahtml2

  cmp al,001b
    je fnhtml2

  cmp al,010b
    je fbhtml2

  vahtml2:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml2

  fnhtml2:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml2

  fbhtml2:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml2

  rehtml2:
Loop html2
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 1----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo unoHTML,SIZEOF unoHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html1:
  inc di
  mov al,linea1[di]
  cmp al,000b
    je vahtml1

  cmp al,001b
    je fnhtml1

  cmp al,010b
    je fbhtml1

  vahtml1:;secciones para imprimir
  escribirEnArchivo etVacia,SIZEOF etVacia
  jmp rehtml1

  fnhtml1:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml1

  fbhtml1:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml1

  rehtml1:
Loop html1
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

escribirEnArchivo abrirTr,SIZEOF abrirTr

escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cerrarTd,SIZEOF cerrarTd

escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo aHTML,SIZEOF aHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo bHTML,SIZEOF bHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cHTML,SIZEOF cHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo dHTML,SIZEOF dHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo eHTML,SIZEOF eHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo fHTML,SIZEOF fHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo gHTML,SIZEOF gHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo hHTML,SIZEOF hHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd

escribirEnArchivo cerrarTr,SIZEOF cerrarTr
escribirEnArchivo cerrarTabla,SIZEOF cerrarTabla

escribirEnArchivo fechaHora,SIZEOF fechaHora

escribirEnArchivo cerrarHtml,SIZEOF cerrarHtml

;imprime msjescr
cmp cx,ax
;jne salir ;error salir
mov ah,3eh  ;Cierre de archivo
int 21h

popear
ret
reporteActualTablero endp

;=========================================================================================
;==========================================REPORTE FINAL==================================
;=========================================================================================
reporteFinal proc near
pushear

editar:
;abrir el archivo
mov ah,3dh
mov al,1h ;Abrimos el archivo en solo escritura.
mov dx,offset pathTableroFInal
int 21h
;jc salir ;Si hubo error
mov bx,ax ; mover hadfile
escribirEnArchivo abrirHtml,SIZEOF abrirHtml

;FIla 8----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr

escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo ochoHTML,SIZEOF ochoHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html8:
  inc di
  mov al,linea8[di]
  cmp al,000b
    je vahtml8

  cmp al,001b
    je fnhtml8

  cmp al,010b
    je fbhtml8

  vahtml8:;secciones para imprimir
  push di
    cmp di,0
    je validar0h8
    cmp di,7
    je validar7h8
    jne validarMedioh8

  validar0h8:
  validar7h8:
  validarMedioh8:
  dec di
  mov al,linea8[di]
  cmp al,001b
  je validarMedioNegraIzq8

  cmp al,010b
  je validarMedioBlancaIzq8

  validarMedioNegraIzq8:
  inc di
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraAbajo8
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml8
  validarMedioNegraAbajo8:
  inc di
  mov al,linea8[di]
  cmp al,001b
  je validarMedioNegraDer8
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml8
  validarMedioNegraDer8:
  dec di
  mov linea8[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml8

  validarMedioBlancaIzq8:
  inc di
  mov al,linea7[di]
  cmp al,010b
  je validarMedioBlancaAbajo8
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml8
  validarMedioBlancaAbajo8:
  inc di
  mov al,linea8[di]
  cmp al,010b
  je validarMedioBlancaDer8
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml8
  validarMedioBlancaDer8:
  dec di
  mov linea8[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml8

  fnhtml8:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml8

  fbhtml8:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml8

  rehtml8:
  dec cx
cmp cx,0
jne html8
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 7----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo sieteHTML,SIZEOF sieteHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html7:
  inc di
  mov al,linea7[di]
  cmp al,000b
    je vahtml7

  cmp al,001b
    je fnhtml7

  cmp al,010b
    je fbhtml7

  vahtml7:;secciones para imprimir
  push di
    cmp di,0
    je validar0h7
    cmp di,7
    je validar7h7
    jne validarMedioh7

  validar0h7:
  validar7h7:
  validarMedioh7:
  mov al,linea8[di]
  cmp al,001b
  je validarMedioNegraArriba7

  cmp al,010b
  je validarMedioBlancaArriba7

  validarMedioNegraArriba7:
  dec di
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraIzq7
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml7
  validarMedioNegraIzq7:
  inc di
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraAbajo7
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml7
  validarMedioNegraAbajo7:
  inc di
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraDer7
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml7
  validarMedioNegraDer7:
  dec di
  mov linea7[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml7

  validarMedioBlancaArriba7:
  dec di
  mov al,linea7[di]
  cmp al,010b
  je validarMedioBlancaIzq7
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml7
  validarMedioBlancaIzq7:
  inc di
  mov al,linea6[di]
  cmp al,010b
  je validarMedioBlancaAbajo7
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml7
  validarMedioBlancaAbajo7:
  inc di
  mov al,linea7[di]
  cmp al,010b
  je validarMedioBlancaDer7
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml7
  validarMedioBlancaDer7:
  dec di
  mov linea7[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml7

  fnhtml7:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml7

  fbhtml7:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml7

  rehtml7:
  dec cx
cmp cx,0
jne html7
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 6----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo seisHTML,SIZEOF seisHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html6:
  inc di
  mov al,linea6[di]
  cmp al,000b
    je vahtml6

  cmp al,001b
    je fnhtml6

  cmp al,010b
    je fbhtml6

  vahtml6:;secciones para imprimir
  push di
    cmp di,0
    je validar0h6
    cmp di,6
    je validar6h6
    jne validarMedioh6

  validar0h6:
  validar6h6:
  validarMedioh6:
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraArriba6

  cmp al,010b
  je validarMedioBlancaArriba6

  validarMedioNegraArriba6:
  dec di
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraIzq6
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml6
  validarMedioNegraIzq6:
  inc di
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraAbajo6
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml6
  validarMedioNegraAbajo6:
  inc di
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraDer6
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml6
  validarMedioNegraDer6:
  dec di
  mov linea6[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml6

  validarMedioBlancaArriba6:
  dec di
  mov al,linea6[di]
  cmp al,010b
  je validarMedioBlancaIzq6
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml6
  validarMedioBlancaIzq6:
  inc di
  mov al,linea5[di]
  cmp al,010b
  je validarMedioBlancaAbajo6
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml6
  validarMedioBlancaAbajo6:
  inc di
  mov al,linea6[di]
  cmp al,010b
  je validarMedioBlancaDer6
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml6
  validarMedioBlancaDer6:
  dec di
  mov linea6[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml6

  fnhtml6:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml6

  fbhtml6:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml6

  rehtml6:
  dec cx
cmp cx,0
jne html6
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 5----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cincoHTML,SIZEOF cincoHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html5:
  inc di
  mov al,linea5[di]
  cmp al,000b
    je vahtml5

  cmp al,001b
    je fnhtml5

  cmp al,010b
    je fbhtml5

  vahtml5:;secciones para imprimir
  push di
    cmp di,0
    je validar0h5
    cmp di,5
    je validar5h5
    jne validarMedioh5

  validar0h5:
  validar5h5:
  validarMedioh5:
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraArriba5

  cmp al,010b
  je validarMedioBlancaArriba5

  validarMedioNegraArriba5:
  dec di
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraIzq5
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml5
  validarMedioNegraIzq5:
  inc di
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraAbajo5
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml5
  validarMedioNegraAbajo5:
  inc di
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraDer5
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml5
  validarMedioNegraDer5:
  dec di
  mov linea5[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml5

  validarMedioBlancaArriba5:
  dec di
  mov al,linea5[di]
  cmp al,010b
  je validarMedioBlancaIzq5
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml5
  validarMedioBlancaIzq5:
  inc di
  mov al,linea4[di]
  cmp al,010b
  je validarMedioBlancaAbajo5
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml5
  validarMedioBlancaAbajo5:
  inc di
  mov al,linea5[di]
  cmp al,010b
  je validarMedioBlancaDer5
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml5
  validarMedioBlancaDer5:
  dec di
  mov linea5[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml5

  fnhtml5:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml5

  fbhtml5:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml5

  rehtml5:
  dec cx
cmp cx,0
jne html5
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 4----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cuatroHTML,SIZEOF cuatroHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html4:
  inc di
  mov al,linea4[di]
  cmp al,000b
    je vahtml4

  cmp al,001b
    je fnhtml4

  cmp al,010b
    je fbhtml4

  vahtml4:;secciones para imprimir
  push di
    cmp di,0
    je validar0h4
    cmp di,4
    je validar4h4
    jne validarMedioh4

  validar0h4:
  validar4h4:
  validarMedioh4:
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraArriba4

  cmp al,010b
  je validarMedioBlancaArriba4

  validarMedioNegraArriba4:
  dec di
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraIzq4
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml4
  validarMedioNegraIzq4:
  inc di
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraAbajo4
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml4
  validarMedioNegraAbajo4:
  inc di
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraDer4
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml4
  validarMedioNegraDer4:
  dec di
  mov linea4[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml4

  validarMedioBlancaArriba4:
  dec di
  mov al,linea4[di]
  cmp al,010b
  je validarMedioBlancaIzq4
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml4
  validarMedioBlancaIzq4:
  inc di
  mov al,linea3[di]
  cmp al,010b
  je validarMedioBlancaAbajo4
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml4
  validarMedioBlancaAbajo4:
  inc di
  mov al,linea4[di]
  cmp al,010b
  je validarMedioBlancaDer4
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml4
  validarMedioBlancaDer4:
  dec di
  mov linea4[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml4

  fnhtml4:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml4

  fbhtml4:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml4

  rehtml4:
  dec cx
cmp cx,0
jne html4
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 3----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo tresHTML,SIZEOF tresHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html3:
  inc di
  mov al,linea3[di]
  cmp al,000b
    je vahtml3

  cmp al,001b
    je fnhtml3

  cmp al,010b
    je fbhtml3

  vahtml3:;secciones para imprimir
  push di
    cmp di,0
    je validar0h3
    cmp di,3
    je validar3h3
    jne validarMedioh3

  validar0h3:
  validar3h3:
  validarMedioh3:
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraArriba3

  cmp al,010b
  je validarMedioBlancaArriba3

  validarMedioNegraArriba3:
  dec di
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraIzq3
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml3
  validarMedioNegraIzq3:
  inc di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraAbajo3
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml3
  validarMedioNegraAbajo3:
  inc di
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraDer3
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml3
  validarMedioNegraDer3:
  dec di
  mov linea3[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml3

  validarMedioBlancaArriba3:
  dec di
  mov al,linea3[di]
  cmp al,010b
  je validarMedioBlancaIzq3
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml3
  validarMedioBlancaIzq3:
  inc di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaAbajo3
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml3
  validarMedioBlancaAbajo3:
  inc di
  mov al,linea3[di]
  cmp al,010b
  je validarMedioBlancaDer3
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml3
  validarMedioBlancaDer3:
  dec di
  mov linea3[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml3

  fnhtml3:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml3

  fbhtml3:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml3

  rehtml3:
  dec cx
cmp cx,0
jne html3
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 2----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo dosHTML,SIZEOF dosHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html2:
  inc di
  mov al,linea2[di]
  cmp al,000b
    je vahtml2

  cmp al,001b
    je fnhtml2

  cmp al,010b
    je fbhtml2

  vahtml2:;secciones para imprimir
  push di
    cmp di,0
    je validar0h2
    cmp di,2
    je validar2h2
    jne validarMedioh2

  validar0h2:
  validar2h2:
  validarMedioh2:
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraArriba2

  cmp al,010b
  je validarMedioBlancaArriba2

  validarMedioNegraArriba2:
  dec di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraIzq2
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml2
  validarMedioNegraIzq2:
  inc di
  mov al,linea1[di]
  cmp al,001b
  je validarMedioNegraAbajo2
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml2
  validarMedioNegraAbajo2:
  inc di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraDer2
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml2
  validarMedioNegraDer2:
  dec di
  mov linea2[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml2

  validarMedioBlancaArriba2:
  dec di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaIzq2
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml2
  validarMedioBlancaIzq2:
  inc di
  mov al,linea1[di]
  cmp al,010b
  je validarMedioBlancaAbajo2
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml2
  validarMedioBlancaAbajo2:
  inc di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaDer2
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml2
  validarMedioBlancaDer2:
  dec di
  mov linea2[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml2

  fnhtml2:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml2

  fbhtml2:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml2

  rehtml2:
  dec cx
cmp cx,0
jne html2
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

;FIla 1----------------------------------------------------
escribirEnArchivo abrirTr,SIZEOF abrirTr
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo unoHTML,SIZEOF unoHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
mov cx,8
mov di,-1
html1:
  inc di
  mov al,linea1[di]
  cmp al,000b
    je vahtml1

  cmp al,001b
    je fnhtml1

  cmp al,010b
    je fbhtml1

  vahtml1:;secciones para imprimir
  push di
    cmp di,0
    je validar0h1
    cmp di,7
    je validar7h1
    jne validarMedioh1

  validar0h1:
  validar7h1:
  validarMedioh1:
  dec di
  mov al,linea1[di]
  cmp al,001b
  je validarMedioNegraIzq1

  cmp al,010b
  je validarMedioBlancaIzq1

  validarMedioNegraIzq1:
  inc di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraAbajo1
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml1
  validarMedioNegraAbajo1:
  inc di
  mov al,linea1[di]
  cmp al,001b
  je validarMedioNegraDer1
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml1
  validarMedioNegraDer1:
  dec di
  mov linea1[di],001b
  escribirEnArchivo etCirculo,SIZEOF etCirculo
  pop di
  jmp rehtml1

  validarMedioBlancaIzq1:
  inc di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaAbajo1
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml1
  validarMedioBlancaAbajo1:
  inc di
  mov al,linea1[di]
  cmp al,010b
  je validarMedioBlancaDer1
  escribirEnArchivo etTriangulo,SIZEOF etTriangulo
  pop di
  jmp rehtml1
  validarMedioBlancaDer1:
  dec di
  mov linea1[di],010b
  escribirEnArchivo etCuadrado,SIZEOF etCuadrado
  pop di
  jmp rehtml1

  fnhtml1:
  escribirEnArchivo etFn,SIZEOF etFn
  jmp rehtml1

  fbhtml1:
  escribirEnArchivo etFb,SIZEOF etFb
  jmp rehtml1

  rehtml1:
  dec cx
cmp cx,0
jne html1
escribirEnArchivo cerrarTr,SIZEOF cerrarTr

escribirEnArchivo abrirTr,SIZEOF abrirTr

escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cerrarTd,SIZEOF cerrarTd

escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo aHTML,SIZEOF aHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo bHTML,SIZEOF bHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo cHTML,SIZEOF cHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo dHTML,SIZEOF dHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo eHTML,SIZEOF eHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo fHTML,SIZEOF fHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo gHTML,SIZEOF gHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd
escribirEnArchivo abrirTd,SIZEOF abrirTd
escribirEnArchivo hHTML,SIZEOF hHTML
escribirEnArchivo cerrarTd,SIZEOF cerrarTd

escribirEnArchivo cerrarTr,SIZEOF cerrarTr
escribirEnArchivo cerrarTabla,SIZEOF cerrarTabla

escribirEnArchivo fechaHora,SIZEOF fechaHora

call contarPuntos

cmp winner,001b
je ganadorNegro
escribirEnArchivo winBlanco,SIZEOF winBlanco
jmp cerrar

ganadorNegro:
escribirEnArchivo winNegro,SIZEOF winNegro
jmp cerrar

cerrar:
escribirEnArchivo cerrarHtml,SIZEOF cerrarHtml

;imprime msjescr
cmp cx,ax
;jne salir ;error salir
mov ah,3eh  ;Cierre de archivo
int 21h

popear
ret
reporteFinal endp
;===============================================================================
;===============================================================================
;===============================================================================

;===============================================================================
;=Eliminar fichas===============================================================
;===============================================================================

eliminarFicha proc near
pushear

editar:
;abrir el archivo

;FIla 8----------------------------------------------------
mov cx,8
mov di,-1
html8:
  inc di
  mov al,linea8[di]
  cmp al,000b
    jne vahtml8
    je rehtml8

  vahtml8:;secciones para imprimir
  push di
    cmp di,0
    je validar0h8
    cmp di,7
    je validar7h8
    jne validarMedioh8

  validar0h8:
  pop di
  jmp rehtml8
  validar7h8:
  pop di
  jmp rehtml8
  validarMedioh8:
  dec di
  mov al,linea8[di]
  cmp al,001b
  je validarMedioNegraIzq8

  cmp al,010b
  je validarMedioBlancaIzq8

  validarMedioNegraIzq8:
  inc di
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraAbajo8
  pop di
  jmp rehtml8
  validarMedioNegraAbajo8:
  inc di
  mov al,linea8[di]
  cmp al,001b
  je validarMedioNegraDer8
  pop di
  jmp rehtml8
  validarMedioNegraDer8:
  dec di
  mov linea8[di],000b
  pop di
  jmp rehtml8

  validarMedioBlancaIzq8:
  inc di
  mov al,linea7[di]
  cmp al,010b
  je validarMedioBlancaAbajo8
  pop di
  jmp rehtml8
  validarMedioBlancaAbajo8:
  inc di
  mov al,linea8[di]
  cmp al,010b
  je validarMedioBlancaDer8
  pop di
  jmp rehtml8
  validarMedioBlancaDer8:
  dec di
  mov linea8[di],000b
  pop di
  jmp rehtml8

  rehtml8:
  dec cx
cmp cx,0
jne html8

;FIla 7----------------------------------------------------
mov cx,8
mov di,-1
html7:
  inc di
  mov al,linea7[di]
  cmp al,000b
    jne vahtml7
    je rehtml7

  vahtml7:;secciones para imprimir
  push di
    cmp di,0
    je validar0h7
    cmp di,7
    je validar7h7
    jne validarMedioh7

  validar0h7:
  pop di
  jmp rehtml7
  validar7h7:
  pop di
  jmp rehtml7
  validarMedioh7:
  mov al,linea8[di]
  cmp al,001b
  je validarMedioNegraArriba7

  cmp al,010b
  je validarMedioBlancaArriba7

  validarMedioNegraArriba7:
  dec di
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraIzq7
  pop di
  jmp rehtml7
  validarMedioNegraIzq7:
  inc di
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraAbajo7
  pop di
  jmp rehtml7
  validarMedioNegraAbajo7:
  inc di
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraDer7
  pop di
  jmp rehtml7
  validarMedioNegraDer7:
  dec di
  mov linea7[di],000b
  pop di
  jmp rehtml7

  validarMedioBlancaArriba7:
  dec di
  mov al,linea7[di]
  cmp al,010b
  je validarMedioBlancaIzq7
  pop di
  jmp rehtml7
  validarMedioBlancaIzq7:
  inc di
  mov al,linea6[di]
  cmp al,010b
  je validarMedioBlancaAbajo7
  pop di
  jmp rehtml7
  validarMedioBlancaAbajo7:
  inc di
  mov al,linea7[di]
  cmp al,010b
  je validarMedioBlancaDer7
  pop di
  jmp rehtml7
  validarMedioBlancaDer7:
  dec di
  mov linea7[di],000b
  pop di
  jmp rehtml7

  rehtml7:
  dec cx
cmp cx,0
jne html7

;FIla 6----------------------------------------------------
mov cx,8
mov di,-1
html6:
  inc di
  mov al,linea6[di]
  cmp al,000b
    jne vahtml6
    je rehtml6

  vahtml6:;secciones para imprimir
  push di
    cmp di,0
    je validar0h6
    cmp di,6
    je validar6h6
    jne validarMedioh6

  validar0h6:
  pop di
  jmp rehtml6
  validar6h6:
  pop di
  jmp rehtml6
  validarMedioh6:
  mov al,linea7[di]
  cmp al,001b
  je validarMedioNegraArriba6

  cmp al,010b
  je validarMedioBlancaArriba6

  validarMedioNegraArriba6:
  dec di
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraIzq6
  pop di
  jmp rehtml6
  validarMedioNegraIzq6:
  inc di
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraAbajo6
  pop di
  jmp rehtml6
  validarMedioNegraAbajo6:
  inc di
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraDer6
  pop di
  jmp rehtml6
  validarMedioNegraDer6:
  dec di
  mov linea6[di],000b
  pop di
  jmp rehtml6

  validarMedioBlancaArriba6:
  dec di
  mov al,linea6[di]
  cmp al,010b
  je validarMedioBlancaIzq6
  pop di
  jmp rehtml6
  validarMedioBlancaIzq6:
  inc di
  mov al,linea5[di]
  cmp al,010b
  je validarMedioBlancaAbajo6
  pop di
  jmp rehtml6
  validarMedioBlancaAbajo6:
  inc di
  mov al,linea6[di]
  cmp al,010b
  je validarMedioBlancaDer6
  pop di
  jmp rehtml6
  validarMedioBlancaDer6:
  dec di
  mov linea6[di],000b
  pop di
  jmp rehtml6

  rehtml6:
  dec cx
cmp cx,0
jne html6

;FIla 5----------------------------------------------------
mov cx,8
mov di,-1
html5:
  inc di
  mov al,linea5[di]
  cmp al,000b
    jne vahtml5
    je rehtml5

  vahtml5:;secciones para imprimir
  push di
    cmp di,0
    je validar0h5
    cmp di,5
    je validar5h5
    jne validarMedioh5

  validar0h5:
  pop di
  jmp rehtml5
  validar5h5:
  pop di
  jmp rehtml5
  validarMedioh5:
  mov al,linea6[di]
  cmp al,001b
  je validarMedioNegraArriba5

  cmp al,010b
  je validarMedioBlancaArriba5

  validarMedioNegraArriba5:
  dec di
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraIzq5
  pop di
  jmp rehtml5
  validarMedioNegraIzq5:
  inc di
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraAbajo5
  pop di
  jmp rehtml5
  validarMedioNegraAbajo5:
  inc di
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraDer5
  pop di
  jmp rehtml5
  validarMedioNegraDer5:
  dec di
  mov linea5[di],000b
  pop di
  jmp rehtml5

  validarMedioBlancaArriba5:
  dec di
  mov al,linea5[di]
  cmp al,010b
  je validarMedioBlancaIzq5
  pop di
  jmp rehtml5
  validarMedioBlancaIzq5:
  inc di
  mov al,linea4[di]
  cmp al,010b
  je validarMedioBlancaAbajo5
  pop di
  jmp rehtml5
  validarMedioBlancaAbajo5:
  inc di
  mov al,linea5[di]
  cmp al,010b
  je validarMedioBlancaDer5
  pop di
  jmp rehtml5
  validarMedioBlancaDer5:
  dec di
  mov linea5[di],000b
  pop di
  jmp rehtml5

  rehtml5:
  dec cx
cmp cx,0
jne html5

;FIla 4----------------------------------------------------
mov cx,8
mov di,-1
html4:
  inc di
  mov al,linea4[di]
  cmp al,000b
    jne vahtml4
    je rehtml4

  vahtml4:;secciones para imprimir
  push di
    cmp di,0
    je validar0h4
    cmp di,4
    je validar4h4
    jne validarMedioh4

  validar0h4:
  pop di
  jmp rehtml4
  validar4h4:
  pop di
  jmp rehtml4
  validarMedioh4:
  mov al,linea5[di]
  cmp al,001b
  je validarMedioNegraArriba4

  cmp al,010b
  je validarMedioBlancaArriba4

  validarMedioNegraArriba4:
  dec di
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraIzq4
  pop di
  jmp rehtml4
  validarMedioNegraIzq4:
  inc di
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraAbajo4
  pop di
  jmp rehtml4
  validarMedioNegraAbajo4:
  inc di
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraDer4
  pop di
  jmp rehtml4
  validarMedioNegraDer4:
  dec di
  mov linea4[di],000b
  pop di
  jmp rehtml4

  validarMedioBlancaArriba4:
  dec di
  mov al,linea4[di]
  cmp al,010b
  je validarMedioBlancaIzq4
  pop di
  jmp rehtml4
  validarMedioBlancaIzq4:
  inc di
  mov al,linea3[di]
  cmp al,010b
  je validarMedioBlancaAbajo4
  pop di
  jmp rehtml4
  validarMedioBlancaAbajo4:
  inc di
  mov al,linea4[di]
  cmp al,010b
  je validarMedioBlancaDer4
  pop di
  jmp rehtml4
  validarMedioBlancaDer4:
  dec di
  mov linea4[di],000b
  pop di
  jmp rehtml4

  rehtml4:
  dec cx
cmp cx,0
jne html4

;FIla 3----------------------------------------------------
mov cx,8
mov di,-1
html3:
  inc di
  mov al,linea3[di]
  cmp al,000b
    jne vahtml3
    je rehtml3

  vahtml3:;secciones para imprimir
  push di
    cmp di,0
    je validar0h3
    cmp di,3
    je validar3h3
    jne validarMedioh3

  validar0h3:
  pop di
  jmp rehtml3
  validar3h3:
  pop di
  jmp rehtml3
  validarMedioh3:
  mov al,linea4[di]
  cmp al,001b
  je validarMedioNegraArriba3

  cmp al,010b
  je validarMedioBlancaArriba3

  validarMedioNegraArriba3:
  dec di
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraIzq3
  pop di
  jmp rehtml3
  validarMedioNegraIzq3:
  inc di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraAbajo3
  pop di
  jmp rehtml3
  validarMedioNegraAbajo3:
  inc di
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraDer3
  pop di
  jmp rehtml3
  validarMedioNegraDer3:
  dec di
  mov linea3[di],000b
  pop di
  jmp rehtml3

  validarMedioBlancaArriba3:
  dec di
  mov al,linea3[di]
  cmp al,010b
  je validarMedioBlancaIzq3
  pop di
  jmp rehtml3
  validarMedioBlancaIzq3:
  inc di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaAbajo3
  pop di
  jmp rehtml3
  validarMedioBlancaAbajo3:
  inc di
  mov al,linea3[di]
  cmp al,010b
  je validarMedioBlancaDer3
  pop di
  jmp rehtml3
  validarMedioBlancaDer3:
  dec di
  mov linea3[di],000b
  pop di
  jmp rehtml3

  rehtml3:
  dec cx
cmp cx,0
jne html3

;FIla 2----------------------------------------------------
mov cx,8
mov di,-1
html2:
  inc di
  mov al,linea2[di]
  cmp al,000b
    jne vahtml2
    je rehtml2

  vahtml2:;secciones para imprimir
  push di
    cmp di,0
    je validar0h2
    cmp di,2
    je validar2h2
    jne validarMedioh2

  validar0h2:
  pop di
  jmp rehtml2
  validar2h2:
  pop di
  jmp rehtml2
  validarMedioh2:
  mov al,linea3[di]
  cmp al,001b
  je validarMedioNegraArriba2

  cmp al,010b
  je validarMedioBlancaArriba2

  validarMedioNegraArriba2:
  dec di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraIzq2
  pop di
  jmp rehtml2
  validarMedioNegraIzq2:
  inc di
  mov al,linea1[di]
  cmp al,001b
  je validarMedioNegraAbajo2
  pop di
  jmp rehtml2
  validarMedioNegraAbajo2:
  inc di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraDer2
  pop di
  jmp rehtml2
  validarMedioNegraDer2:
  dec di
  mov linea2[di],000b
  pop di
  jmp rehtml2

  validarMedioBlancaArriba2:
  dec di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaIzq2
  pop di
  jmp rehtml2
  validarMedioBlancaIzq2:
  inc di
  mov al,linea1[di]
  cmp al,010b
  je validarMedioBlancaAbajo2
  pop di
  jmp rehtml2
  validarMedioBlancaAbajo2:
  inc di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaDer2
  pop di
  jmp rehtml2
  validarMedioBlancaDer2:
  dec di
  mov linea2[di],000b
  pop di
  jmp rehtml2

  rehtml2:
  dec cx
cmp cx,0
jne html2

;Fila 1-----------------------------------------------------------
mov cx,8
mov di,-1
html1:
  inc di
  mov al,linea1[di]
  cmp al,000b
    je vahtml1

  vahtml1:;secciones para imprimir
  push di
    cmp di,0
    je validar0h1
    cmp di,7
    je validar7h1
    jne validarMedioh1

  validar0h1:
  pop di
  jmp rehtml1
  validar7h1:
  pop di
  jmp rehtml1
  validarMedioh1:
  dec di
  mov al,linea1[di]
  cmp al,001b
  je validarMedioNegraIzq1

  cmp al,010b
  je validarMedioBlancaIzq1

  validarMedioNegraIzq1:
  inc di
  mov al,linea2[di]
  cmp al,001b
  je validarMedioNegraAbajo1
  pop di
  jmp rehtml1
  validarMedioNegraAbajo1:
  inc di
  mov al,linea1[di]
  cmp al,001b
  je validarMedioNegraDer1
  pop di
  jmp rehtml1
  validarMedioNegraDer1:
  dec di
  mov linea2[di],000b
  pop di
  jmp rehtml1

  validarMedioBlancaIzq1:
  inc di
  mov al,linea2[di]
  cmp al,010b
  je validarMedioBlancaAbajo1
  pop di
  jmp rehtml1
  validarMedioBlancaAbajo1:
  inc di
  mov al,linea1[di]
  cmp al,010b
  je validarMedioBlancaDer1
  pop di
  jmp rehtml1
  validarMedioBlancaDer1:
  dec di
  mov linea1[di],000b
  pop di
  jmp rehtml1

  rehtml1:
  dec cx
cmp cx,0
jne html1

popear
ret
eliminarFicha endp

;===============================================================================
;===============================================================================
;===============================================================================

;===================Guardar Partida=============================================
guardarPartida proc near
pushear

editar:
;abrir el archivo
mov ah,3dh
mov al,1h ;Abrimos el archivo en solo escritura.
mov dx,offset pathArchivoG
int 21h
;jc salir ;Si hubo error
mov bx,ax ; mover hadfile

;FIla 8----------------------------------------------------
mov cx,8
mov di,-1
html8:
  inc di
  mov al,linea8[di]
  cmp al,000b
    je vahtml8

  cmp al,001b
    je fnhtml8

  cmp al,010b
    je fbhtml8

  vahtml8:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml8

  fnhtml8:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml8

  fbhtml8:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml8

  rehtml8:
Loop html8

;FIla 7----------------------------------------------------
mov cx,8
mov di,-1
html7:
  inc di
  mov al,linea7[di]
  cmp al,000b
    je vahtml7

  cmp al,001b
    je fnhtml7

  cmp al,010b
    je fbhtml7

  vahtml7:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml7

  fnhtml7:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml7

  fbhtml7:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml7

  rehtml7:
Loop html7

;FIla 6----------------------------------------------------
mov cx,8
mov di,-1
html6:
  inc di
  mov al,linea6[di]
  cmp al,000b
    je vahtml6

  cmp al,001b
    je fnhtml6

  cmp al,010b
    je fbhtml6

  vahtml6:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml6

  fnhtml6:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml6

  fbhtml6:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml6

  rehtml6:
Loop html6

;FIla 5----------------------------------------------------
mov cx,8
mov di,-1
html5:
  inc di
  mov al,linea5[di]
  cmp al,000b
    je vahtml5

  cmp al,001b
    je fnhtml5

  cmp al,010b
    je fbhtml5

  vahtml5:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml5

  fnhtml5:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml5

  fbhtml5:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml5

  rehtml5:
Loop html5

;FIla 4----------------------------------------------------
mov cx,8
mov di,-1
html4:
  inc di
  mov al,linea4[di]
  cmp al,000b
    je vahtml4

  cmp al,001b
    je fnhtml4

  cmp al,010b
    je fbhtml4

  vahtml4:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml4

  fnhtml4:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml4

  fbhtml4:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml4

  rehtml4:
Loop html4

;FIla 3----------------------------------------------------
mov cx,8
mov di,-1
html3:
  inc di
  mov al,linea3[di]
  cmp al,000b
    je vahtml3

  cmp al,001b
    je fnhtml3

  cmp al,010b
    je fbhtml3

  vahtml3:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml3

  fnhtml3:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml3

  fbhtml3:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml3

  rehtml3:
Loop html3

;FIla 2----------------------------------------------------
mov cx,8
mov di,-1
html2:
  inc di
  mov al,linea2[di]
  cmp al,000b
    je vahtml2

  cmp al,001b
    je fnhtml2

  cmp al,010b
    je fbhtml2

  vahtml2:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml2

  fnhtml2:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml2

  fbhtml2:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml2

  rehtml2:
Loop html2

;FIla 1----------------------------------------------------
mov cx,8
mov di,-1
html1:
  inc di
  mov al,linea1[di]
  cmp al,000b
    je vahtml1

  cmp al,001b
    je fnhtml1

  cmp al,010b
    je fbhtml1

  vahtml1:;secciones para imprimir
  escribirEnArchivo ceroHTML,SIZEOF ceroHTML
  jmp rehtml1

  fnhtml1:
  escribirEnArchivo unoHTML,SIZEOF unoHTML
  jmp rehtml1

  fbhtml1:
  escribirEnArchivo dosHTML,SIZEOF dosHTML
  jmp rehtml1

  rehtml1:
Loop html1

;imprime msjescr
cmp cx,ax
;jne salir ;error salir
mov ah,3eh  ;Cierre de archivo
int 21h

popear
ret
guardarPartida endp
;==========================================================================
;==========================================================================
;==========================================================================

;===================Cargar Partida=============================================
cargarPartida proc near
pushear

editar:
;FIla 8----------------------------------------------------
mov cx,8
mov di,-1
mov bx,-1
html8:
  inc di
  inc bx
  mov al,texto[bx]
  cmp al,30h
    je vahtml8

  cmp al,31h
    je fnhtml8

  cmp al,32h
    je fbhtml8

  vahtml8:;secciones para imprimir
  mov linea8[di],000b
  jmp rehtml8

  fnhtml8:
  mov linea8[di],001b
  jmp rehtml8

  fbhtml8:
  mov linea8[di],010b
  jmp rehtml8

  rehtml8:
Loop html8

;FIla 7----------------------------------------------------
mov cx,8
mov di,-1
html7:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml7

  cmp al,31h
    je fnhtml7

  cmp al,32h
    je fbhtml7

  vahtml7:;secciones para imprimir
  mov linea7[di],000b
  jmp rehtml7

  fnhtml7:
  mov linea7[di],001b
  jmp rehtml7

  fbhtml7:
  mov linea7[di],010b
  jmp rehtml7

  rehtml7:
Loop html7

;FIla 6----------------------------------------------------
mov cx,8
mov di,-1
html6:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml6

  cmp al,31h
    je fnhtml6

  cmp al,32h
    je fbhtml6

  vahtml6:;secciones para imprimir
  mov linea6[di],000b
  jmp rehtml6

  fnhtml6:
  mov linea6[di],001b
  jmp rehtml6

  fbhtml6:
  mov linea6[di],010b
  jmp rehtml6

  rehtml6:
Loop html6

;FIla 5----------------------------------------------------
mov cx,8
mov di,-1
html5:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml5

  cmp al,31h
    je fnhtml5

  cmp al,32h
    je fbhtml5

  vahtml5:;secciones para imprimir
  mov linea5[di],000b
  jmp rehtml5

  fnhtml5:
  mov linea5[di],001b
  jmp rehtml5

  fbhtml5:
  mov linea5[di],010b
  jmp rehtml5

  rehtml5:
Loop html5

;FIla 4----------------------------------------------------
mov cx,8
mov di,-1
html4:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml4

  cmp al,31h
    je fnhtml4

  cmp al,32h
    je fbhtml4

  vahtml4:;secciones para imprimir
  mov linea4[di],000b
  jmp rehtml4

  fnhtml4:
  mov linea4[di],001b
  jmp rehtml4

  fbhtml4:
  mov linea4[di],010b
  jmp rehtml4

  rehtml4:
Loop html4

;FIla 3----------------------------------------------------
mov cx,8
mov di,-1
html3:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml3

  cmp al,31h
    je fnhtml3

  cmp al,32h
    je fbhtml3

  vahtml3:;secciones para imprimir
  mov linea3[di],000b
  jmp rehtml3

  fnhtml3:
  mov linea3[di],001b
  jmp rehtml3

  fbhtml3:
  mov linea3[di],010b
  jmp rehtml3

  rehtml3:
Loop html3

;FIla 2----------------------------------------------------
mov cx,8
mov di,-1
html2:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml2

  cmp al,31h
    je fnhtml2

  cmp al,32h
    je fbhtml2

  vahtml2:;secciones para imprimir
  mov linea2[di],000b
  jmp rehtml2

  fnhtml2:
  mov linea2[di],001b
  jmp rehtml2

  fbhtml2:
  mov linea2[di],010b
  jmp rehtml2

  rehtml2:
Loop html2

;FIla 1----------------------------------------------------
mov cx,8
mov di,-1
html1:
inc bx
  inc di
  mov al,texto[bx]
  cmp al,30h
    je vahtml1

  cmp al,31h
    je fnhtml1

  cmp al,32h
    je fbhtml1

  vahtml1:;secciones para imprimir
  mov linea1[di],000b
  jmp rehtml1

  fnhtml1:
  mov linea1[di],001b
  jmp rehtml1

  fbhtml1:
  mov linea1[di],010b
  jmp rehtml1

  rehtml1:
Loop html1

popear
ret
cargarPartida endp
;==========================================================================
;==========================================================================
;==========================================================================

;===================Contar Puntos=============================================
contarPuntos proc near
pushear

;FIla 8----------------------------------------------------
mov cx,8
mov di,-1
mov bl,0
mov bh,0
html8:
  inc di
  mov al,linea8[di]
  cmp al,000b
    je vahtml8

  cmp al,001b
    je fnhtml8

  cmp al,010b
    je fbhtml8

  vahtml8:;secciones para imprimir
  jmp rehtml8

  fnhtml8:
  inc bl
  jmp rehtml8

  fbhtml8:
  inc bh
  jmp rehtml8

  rehtml8:
Loop html8

;FIla 7----------------------------------------------------
mov cx,8
mov di,-1
html7:
  inc di
  mov al,linea7[di]
  cmp al,000b
    je vahtml7

  cmp al,001b
    je fnhtml7

  cmp al,010b
    je fbhtml7

  vahtml7:;secciones para imprimir
  jmp rehtml7

  fnhtml7:
  inc bl
  jmp rehtml7

  fbhtml7:
  inc bh
  jmp rehtml7

  rehtml7:
Loop html7

;FIla 6----------------------------------------------------
mov cx,8
mov di,-1
html6:
  inc di
  mov al,linea6[di]
  cmp al,000b
    je vahtml6

  cmp al,001b
    je fnhtml6

  cmp al,010b
    je fbhtml6

  vahtml6:;secciones para imprimir
  jmp rehtml6

  fnhtml6:
  inc bl
  jmp rehtml6

  fbhtml6:
  inc bh
  jmp rehtml6

  rehtml6:
Loop html6

;FIla 5----------------------------------------------------
mov cx,8
mov di,-1
html5:
  inc di
  mov al,linea5[di]
  cmp al,000b
    je vahtml5

  cmp al,001b
    je fnhtml5

  cmp al,010b
    je fbhtml5

  vahtml5:;secciones para imprimir
  jmp rehtml5

  fnhtml5:
  inc bl
  jmp rehtml5

  fbhtml5:
  inc bh
  jmp rehtml5

  rehtml5:
Loop html5

;FIla 4----------------------------------------------------
mov cx,8
mov di,-1
html4:
  inc di
  mov al,linea4[di]
  cmp al,000b
    je vahtml4

  cmp al,001b
    je fnhtml4

  cmp al,010b
    je fbhtml4

  vahtml4:;secciones para imprimir
  jmp rehtml4

  fnhtml4:
  inc bl
  jmp rehtml4

  fbhtml4:
  inc bh
  jmp rehtml4

  rehtml4:
Loop html4

;FIla 3----------------------------------------------------
mov cx,8
mov di,-1
html3:
  inc di
  mov al,linea3[di]
  cmp al,000b
    je vahtml3

  cmp al,001b
    je fnhtml3

  cmp al,010b
    je fbhtml3

  vahtml3:;secciones para imprimir
  jmp rehtml3

  fnhtml3:
  inc bl
  jmp rehtml3

  fbhtml3:
  inc bh
  jmp rehtml3

  rehtml3:
Loop html3

;FIla 2----------------------------------------------------
mov cx,8
mov di,-1
html2:
  inc di
  mov al,linea2[di]
  cmp al,000b
    je vahtml2

  cmp al,001b
    je fnhtml2

  cmp al,010b
    je fbhtml2

  vahtml2:;secciones para imprimir
  jmp rehtml2

  fnhtml2:
  inc bl
  jmp rehtml2

  fbhtml2:
  inc bh
  jmp rehtml2

  rehtml2:
Loop html2

;FIla 1----------------------------------------------------
mov cx,8
mov di,-1
html1:
  inc di
  mov al,linea1[di]
  cmp al,000b
    je vahtml1

  cmp al,001b
    je fnhtml1

  cmp al,010b
    je fbhtml1

  vahtml1:;secciones para imprimir
  jmp rehtml1

  fnhtml1:
  inc bl
  jmp rehtml1

  fbhtml1:
  inc bh
  jmp rehtml1

  rehtml1:
Loop html1

cmp bl,bh
je ganadorBlanco
jb ganadorBlanco
ja ganadorNegro

ganadorNegro:
mov winner,001b
jmp finish

ganadorBlanco:
mov winner,010b
jmp finish

finish:
popear
ret
contarPuntos endp

;============================================================0

analizarEntrada proc near
pushear

mov bx,0
mov al,entrada[bx]

s0:
cmp al,41h;si es A
  je escribirA

cmp al,42h;si es B
  je escribirB

cmp al,43h;si es C
  je escribirC

cmp al,44h;si es D
  je escribirD

cmp al,45h;si es E
  je s1

cmp al,46h;si es F
  je escribirF

cmp al,47h;si es G
  je escribirG

cmp al,72;si es H
  je escribirH

  cmp al,50h;si es P
    je s2

  cmp al,53h;si es S
    je s7

s1:
mov bx,1
mov al,entrada[bx]

cmp al,058h;si es X
  jne escribirE
  je s14

escribirA:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirA1

cmp al,32h;si es 2
  je escribirA2

cmp al,33h;si es 3
  je escribirA3

cmp al,34h;si es 4
  je escribirA4

cmp al,35h;si es 5
  je escribirA5

cmp al,36h;si es 6
  je escribirA6

cmp al,37h;si es 7
  je escribirA7

cmp al,38h;si es 8
  je escribirA8


escribirB:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirB1

cmp al,32h;si es 2
  je escribirB2

cmp al,33h;si es 3
  je escribirB3

cmp al,34h;si es 4
  je escribirB4

cmp al,35h;si es 5
  je escribirB5

cmp al,36h;si es 6
  je escribirB6

cmp al,37h;si es 7
  je escribirB7

cmp al,38h;si es 8
  je escribirB8


escribirC:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirC1

cmp al,32h;si es 2
  je escribirC2

cmp al,33h;si es 3
  je escribirC3

cmp al,34h;si es 4
  je escribirC4

cmp al,35h;si es 5
  je escribirC5

cmp al,36h;si es 6
  je escribirC6

cmp al,37h;si es 7
  je escribirC7

cmp al,38h;si es 8
  je escribirC8


escribirD:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirD1

cmp al,32h;si es 2
  je escribirD2

cmp al,33h;si es 3
  je escribirD3

cmp al,34h;si es 4
  je escribirD4

cmp al,35h;si es 5
  je escribirD5

cmp al,36h;si es 6
  je escribirD6

cmp al,37h;si es 7
  je escribirD7

cmp al,38h;si es 8
  je escribirD8


escribirE:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirE1

cmp al,32h;si es 2
  je escribirE2

cmp al,33h;si es 3
  je escribirE3

cmp al,34h;si es 4
  je escribirE4

cmp al,35h;si es 5
  je escribirE5

cmp al,36h;si es 6
  je escribirE6

cmp al,37h;si es 7
  je escribirE7

cmp al,38h;si es 8
  je escribirE8

escribirF:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirF1

cmp al,32h;si es 2
  je escribirF2

cmp al,33h;si es 3
  je escribirF3

cmp al,34h;si es 4
  je escribirF4

cmp al,35h;si es 5
  je escribirF5

cmp al,36h;si es 6
  je escribirF6

cmp al,37h;si es 7
  je escribirF7

cmp al,38h;si es 8
  je escribirF8


escribirG:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirG1

cmp al,32h;si es 2
  je escribirG2

cmp al,33h;si es 3
  je escribirG3

cmp al,34h;si es 4
  je escribirG4

cmp al,35h;si es 5
  je escribirG5

cmp al,36h;si es 6
  je escribirG6

cmp al,37h;si es 7
  je escribirG7

cmp al,38h;si es 8
  je escribirG8


escribirH:
mov detPass, 000b
mov bx,1
mov al, entrada[bx]

cmp al,31h;si es 1
  je escribirH1

cmp al,32h;si es 2
  je escribirH2

cmp al,33h;si es 3
  je escribirH3

cmp al,34h;si es 4
  je escribirH4

cmp al,35h;si es 5
  je escribirH5

cmp al,36h;si es 6
  je escribirH6

cmp al,37h;si es 7
  je escribirH7

cmp al,38h;si es 8
  je escribirH8


escribirA1:
mov bx,0
mov linea1[bx],ah
jmp salirAnalizador
escribirA2:
mov bx,0
mov linea2[bx],ah
jmp salirAnalizador
escribirA3:
mov bx,0
mov linea3[bx],ah
jmp salirAnalizador
escribirA4:
mov bx,0
mov linea4[bx],ah
jmp salirAnalizador
escribirA5:
mov bx,0
mov linea5[bx],ah
jmp salirAnalizador
escribirA6:
mov bx,0
mov linea6[bx],ah
jmp salirAnalizador
escribirA7:
mov bx,0
mov linea7[bx],ah
jmp salirAnalizador
escribirA8:
mov bx,0
mov linea8[bx],ah
jmp salirAnalizador

escribirB1:
mov bx,1
mov linea1[bx],ah
jmp salirAnalizador
escribirB2:
mov bx,1
mov linea2[bx],ah
jmp salirAnalizador
escribirB3:
mov bx,1
mov linea3[bx],ah
jmp salirAnalizador
escribirB4:
mov bx,1
mov linea4[bx],ah
jmp salirAnalizador
escribirB5:
mov bx,1
mov linea5[bx],ah
jmp salirAnalizador
escribirB6:
mov bx,1
mov linea6[bx],ah
jmp salirAnalizador
escribirB7:
mov bx,1
mov linea7[bx],ah
jmp salirAnalizador
escribirB8:
mov bx,1
mov linea8[bx],ah
jmp salirAnalizador

escribirC1:
mov bx,2
mov linea1[bx],ah
jmp salirAnalizador
escribirC2:
mov bx,2
mov linea2[bx],ah
jmp salirAnalizador
escribirC3:
mov bx,2
mov linea3[bx],ah
jmp salirAnalizador
escribirC4:
mov bx,2
mov linea4[bx],ah
jmp salirAnalizador
escribirC5:
mov bx,2
mov linea5[bx],ah
jmp salirAnalizador
escribirC6:
mov bx,2
mov linea6[bx],ah
jmp salirAnalizador
escribirC7:
mov bx,2
mov linea7[bx],ah
jmp salirAnalizador
escribirC8:
mov bx,2
mov linea8[bx],ah
jmp salirAnalizador

escribirD1:
mov bx,3
mov linea1[bx],ah
jmp salirAnalizador
escribirD2:
mov bx,3
mov linea2[bx],ah
jmp salirAnalizador
escribirD3:
mov bx,3
mov linea3[bx],ah
jmp salirAnalizador
escribirD4:
mov bx,3
mov linea4[bx],ah
jmp salirAnalizador
escribirD5:
mov bx,3
mov linea5[bx],ah
jmp salirAnalizador
escribirD6:
mov bx,3
mov linea6[bx],ah
jmp salirAnalizador
escribirD7:
mov bx,3
mov linea7[bx],ah
jmp salirAnalizador
escribirD8:
mov bx,3
mov linea8[bx],ah
jmp salirAnalizador

escribirE1:
mov bx,4
mov linea1[bx],ah
jmp salirAnalizador
escribirE2:
mov bx,4
mov linea2[bx],ah
jmp salirAnalizador
escribirE3:
mov bx,4
mov linea3[bx],ah
jmp salirAnalizador
escribirE4:
mov bx,4
mov linea4[bx],ah
jmp salirAnalizador
escribirE5:
mov bx,4
mov linea5[bx],ah
jmp salirAnalizador
escribirE6:
mov bx,4
mov linea6[bx],ah
jmp salirAnalizador
escribirE7:
mov bx,4
mov linea7[bx],ah
jmp salirAnalizador
escribirE8:
mov bx,4
mov linea8[bx],ah
jmp salirAnalizador

escribirF1:
mov bx,5
mov linea1[bx],ah
jmp salirAnalizador
escribirF2:
mov bx,5
mov linea2[bx],ah
jmp salirAnalizador
escribirF3:
mov bx,5
mov linea3[bx],ah
jmp salirAnalizador
escribirF4:
mov bx,5
mov linea4[bx],ah
jmp salirAnalizador
escribirF5:
mov bx,5
mov linea5[bx],ah
jmp salirAnalizador
escribirF6:
mov bx,5
mov linea6[bx],ah
jmp salirAnalizador
escribirF7:
mov bx,5
mov linea7[bx],ah
jmp salirAnalizador
escribirF8:
mov bx,5
mov linea8[bx],ah
jmp salirAnalizador

escribirG1:
mov bx,6
mov linea1[bx],ah
jmp salirAnalizador
escribirG2:
mov bx,6
mov linea2[bx],ah
jmp salirAnalizador
escribirG3:
mov bx,6
mov linea3[bx],ah
jmp salirAnalizador
escribirG4:
mov bx,6
mov linea4[bx],ah
jmp salirAnalizador
escribirG5:
mov bx,6
mov linea5[bx],ah
jmp salirAnalizador
escribirG6:
mov bx,6
mov linea6[bx],ah
jmp salirAnalizador
escribirG7:
mov bx,6
mov linea7[bx],ah
jmp salirAnalizador
escribirG8:
mov bx,6
mov linea8[bx],ah
jmp salirAnalizador

escribirH1:
mov bx,7
mov linea1[bx],ah
jmp salirAnalizador
escribirH2:
mov bx,7
mov linea2[bx],ah
jmp salirAnalizador
escribirH3:
mov bx,7
mov linea3[bx],ah
jmp salirAnalizador
escribirH4:
mov bx,7
mov linea4[bx],ah
jmp salirAnalizador
escribirH5:
mov bx,7
mov linea5[bx],ah
jmp salirAnalizador
escribirH6:
mov bx,7
mov linea6[bx],ah
jmp salirAnalizador
escribirH7:
mov bx,7
mov linea7[bx],ah
jmp salirAnalizador
escribirH8:
mov bx,7
mov linea8[bx],ah
jmp salirAnalizador

s2:
mov bx,1
mov al, entrada[bx]

cmp al,41h
je s4

s4:
mov bx,2
mov al, entrada[bx]

cmp al,53h
je s5

s5:
mov bx,3
mov al, entrada[bx]

cmp al,53h
je passGame

s7:
mov bx,1
mov al, entrada[bx]

cmp al,41h
je s11

cmp al,48h
je s8

s8:
mov bx,2
mov al, entrada[bx]

cmp al,4fh
je s9

s9:
mov bx,1
mov al, entrada[bx]

cmp al,57h
je showReporte

s11:
mov bx,2
mov al, entrada[bx]

cmp al,56h
je s12

s12:
mov bx,3
mov al, entrada[bx]

cmp al,45h
je saveGame

s14:
mov bx,2
mov al, entrada[bx]

cmp al,49h
je s15

s15:
mov bx,3
mov al, entrada[bx]

cmp al,54h
je exitGame

showReporte:
lea bx,fechaHora
call GetDate
call GetTime

call reporteActualTablero
mov detExit,001b
mov detPass, 000b
jmp salirAnalizador

saveGame:
call guardarPartida
mov detExit,001b
mov detPass, 000b
jmp salirAnalizador

exitGame:
mov detExit,100b
mov detPass, 000b
jmp salirAnalizador

passGame:
mov al,detPass
cmp al,101b
je finishPass1
jne finishPass2

finishPass1:
mov detExit,100b
mov detPass, 000b
lea bx,fechaHora
call GetDate
call GetTime
call reporteFinal
jmp salirAnalizador

finishPass2:
mov detPass,101b
jmp salirAnalizador


salirAnalizador:

popear
ret
analizarEntrada endp

end
