CC = avr
MCU_TARGET = atmega32u4
CFLAGS = -c -g -O2 -Wall -mmcu=$(MCU_TARGET)
AFLAGS = -g -mmcu=$(MCU_TARGET)
LDFLAGS = --no-fatal-warnings -T linker.ld

all: notmain.elf

notmain.o: notmain.s
	$(CC)-gcc $(CFLAGS) notmain.s -o notmain.o

boot.o: boot.s
	$(CC)-as $(AFLAGS) boot.s -o boot.o

notmain.elf: notmain.o boot.o
	$(CC)-ld $(LDFLAGS) notmain.o boot.o -o notmain.elf
	$(CC)-objdump -D notmain.elf > notmain.list
	$(CC)-objcopy -j .text -j .data -O ihex notmain.elf notmain.hex

load:
	avrdude -C avrdude.conf -v -p m32u4 -c stk500v1 -P /dev/ttyACM0 -b 19200 -U flash:w:notmain.hex:i -F

clean:
	rm -f *.o
	rm -f *.srec
	rm -f *.list
	rm -f *.elf
	rm -f *.hex
