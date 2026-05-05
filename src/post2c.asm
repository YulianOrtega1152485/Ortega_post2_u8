org 100h

section .data
  pA db "Primer operando (0-9): $"
  pB db 0Dh,0Ah,"Segundo operando (0-9): $"
  pp db 0Dh,0Ah,"Operacion (* o /): $"
  msgR db 0Dh,0Ah,"Resultado: $"
  msgErr db 0Dh,0Ah,"Division por cero.$"
  crlf db 0Dh,0Ah,"$"

section .text
start:
  ; ---- leer A ----
  mov ah, 09h
  mov dx, pA
  int 21h

  mov ah, 01h
  int 21h
  sub al, 30h
  mov bl, al

  ; ---- leer B ----
  mov ah, 09h
  mov dx, pB
  int 21h

  mov ah, 01h
  int 21h
  sub al, 30h
  mov cl, al

  ; ---- leer operador ----
  mov ah, 09h
  mov dx, pp
  int 21h

  mov ah, 01h
  int 21h
  mov bh, al

  mov ah, 09h
  mov dx, msgR
  int 21h

  ; ---- MULTIPLICACION ----
  cmp bh, '*'
  je mul_op

  ; ---- DIVISION ----
  cmp bh, '/'
  je div_op

  jmp fin

mul_op:
  mov al, bl
  mul cl          ; AX = resultado
  call printNum
  jmp fin

div_op:
  cmp cl, 0
  je errorDiv

  xor ah, ah
  mov al, bl
  div cl          ; AL = cociente

  xor ah, ah
  call printNum
  jmp fin

errorDiv:
  mov ah, 09h
  mov dx, msgErr
  int 21h

fin:
  mov ah, 09h
  mov dx, crlf
  int 21h

  mov ah, 4Ch
  int 21h

; ---- imprimir AX en decimal ----
printNum:
  mov bx, 10
  xor cx, cx

convert:
  xor dx, dx
  div bx
  push dx
  inc cx
  cmp ax, 0
  jne convert

print:
  pop dx
  add dl, 30h
  mov ah, 02h
  int 21h
  loop print

  ret