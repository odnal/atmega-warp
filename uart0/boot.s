
.globl _start
_start:

.word 0x0AFF ; initialize stack
.word reset

jmp reset

reset:
  call notmain
  jmp loop

loop:
  jmp loop
