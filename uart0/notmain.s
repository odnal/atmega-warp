
.equ UDR    , 0xCE  ; USART Data Reg
.equ UBRRH  , 0xCD  ; USART Baud Rate High Byte
.equ UBRRL  , 0xCC  ; USART Baud Rate Low Byte
.equ UCSRB  , 0xC9  ; USART Control and Status Reg
.equ UCSRA  , 0xC8  ; USART Control and Status Reg

.equ F_CPU  , 16000000            ; cpu freq
.equ baud   , 19200               ; baud
.equ bps    , (F_CPU/16/baud) -1  ; bps formula

.globl notmain
notmain:
  
uart_init:
  # set baud rate
  ldi r17, (bps)
  ldi r18, (bps>>8)
  sts UBRRL, r17
  sts UBRRH, r18
  
  # enable transmitter
  ldi r16, 0x09   ; TXen bit 
  sts UCSRB, r16  ; write set bit to register
  
  #set frame format - (skipped)

  ldi r17, UCSRA 
transmit:
  sbrs r17, 0x5 ; skip if bit is set - transmitter is ready to be written
  ldi r16, 0x55 ; load r16 with 0x55
  sts UDR, r16  ; write r16 into UDR

  sbrs r17, 0x5
  ldi r18, 0x0D ; return char
  sts UDR, r18  

  sbrs r17, 0x5
  ldi r19, 0x0A ; new line
  sts UDR, r19  

  jmp transmit

