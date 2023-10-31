ENTRY(_start)

MEMORY {
  rom : ORIGIN = 0x0000, LENGTH = 32K
}

SECTIONS {
  .text : { *(.text) } > rom
}
