include macro.asm

.model small
.stack 100
.data
   universidad db 0ah,0dh,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', '$'
   facultad db 0ah,0dh,'FACULTAD DE INGENIERIA', '$'
   carrera db 0ah,0dh,'CIENCIAS Y SISTEMAS', '$'
   curso db 0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', '$'
   miNombre db 0ah,0dh,'PABLO ROCA', '$'
   carnet db 0ah,0dh,'201700584', '$'
   sec db 0ah,0dh,'SECCION: A', '$'

   op1 db 0ah,0dh,'1) Iniciar Juego', '$'
   op2 db 0ah,0dh,'2) Cargar Juego', '$'
   op3 db 0ah,0dh,'3) Salir', '$'
.code

main  proc              ;Inicia proceso
print universidad
print facultad
print carrera
print curso
print miNombre
print carnet
print sec

menuPrincipal:
  print op1
  print op2
  print op3

  call getchar

  cmp al,31h
    je iniciar
  cmp al,32h
    je cargar
  cmp al,33h
    je salir

iniciar:
  print op1
  jmp menuPrincipal

cargar:
  print op2
  jmp menuPrincipal

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
end
