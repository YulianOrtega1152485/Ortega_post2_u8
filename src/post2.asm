org 100h

section .data
  ; A = 0x0001FFFF
  aLo dw 0FFFFh
  aHi dw 0001h

  ; B = 0x00010001
  bLo dw 0001h
  bHi dw 0001h

  resLo dw 0
  resHi dw 0

  msgSum db "Suma OK: 0003:0000",0Dh,0Ah,"$"
  msgRes db "Resta OK: 0001:FFFF",0Dh,0Ah,"$"
  msgErr db "Error.$"

section .text
start:
  mov ax, ds
  mov es, ax

  ; -------- SUMA --------
  mov ax, [aLo]
  mov dx, [aHi]
  mov bx, [bLo]
  mov cx, [bHi]

  add ax, bx
  adc dx, cx

  mov [resLo], ax
  mov [resHi], dx

  cmp ax, 0000h
  jne error
  cmp dx, 0003h
  jne error

  mov ah, 09h
  mov dx, msgSum
  int 21h

  ; -------- RESTA --------
  mov ax, 0000h
  mov dx, 0003h
  mov bx, 0001h
  mov cx, 0001h

  sub ax, bx
  sbb dx, cx

  cmp ax, 0FFFFh
  jne error
  cmp dx, 0001h
  jne error

  mov ah, 09h
  mov dx, msgRes
  int 21h
  jmp fin

error:
  mov ah, 09h
  mov dx, msgErr
  int 21h

fin:
  mov ah, 4Ch
  int 21h