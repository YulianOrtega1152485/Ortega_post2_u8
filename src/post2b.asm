org 100h

section .data
  msg1 db "BCD suma: $"
  msg2 db 0Dh,0Ah,"DAS OK: $"
  crlf db 0Dh,0Ah,"$"

section .text
start:
  ; -------- SUMA BCD --------
  mov al, 47h
  add al, 38h
  daa              ; -> 85h

  mov ah, 09h
  mov dx, msg1
  int 21h

  call printBCD

  ; -------- RESTA BCD --------
  mov al, 73h
  sub al, 28h
  das              ; -> 45h

  mov ah, 09h
  mov dx, msg2
  int 21h

  call printBCD

  mov ah, 09h
  mov dx, crlf
  int 21h

  mov ah, 4Ch
  int 21h

; ---- imprime AL como BCD ----
printBCD:
  push ax

  mov bl, al

  ; decenas
  mov al, bl
  shr al, 4
  add al, 30h
  mov dl, al
  mov ah, 02h
  int 21h

  ; unidades
  mov al, bl
  and al, 0Fh
  add al, 30h
  mov dl, al
  int 21h

  pop ax
  ret