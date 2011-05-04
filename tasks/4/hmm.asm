org	07C00h		
		cli
		xor		ax, ax
		mov		ss, ax
		xor		sp, sp
		sti

		mov		ds, ax
		mov		es, ax

		jmp		00h:m1

m1:
		mov		ax, 0204h
		mov		cx, 0002h
		mov		dh, ch
		mov		bx, buffer
		int		013h
		jc		crash

		cli
		lgdt	[gdt_table]
		lidt	[idt_table]
		mov		eax, cr0
		or		al, 01h
		mov		cr0, eax
		jmp		08h:clear_label
clear_label:

		xor		ax, ax
		mov		ds, ax
		mov		es, ax
		mov		ax, 08h * 02h
		mov		ss, ax

		sti
		int		13
		cli
		hlt

error_string 		db 	'error'

crash:
		mov		ax, 01301h
		xor		bh, bh
		mov		bl, 04h
		mov		bp, error_string
		mov		cx, 05h
		xor		dx, dx
		int		010h
		cli
		hlt

int_string db 'my int'
int_all:
		push	cx
		push	si
		mov		cx, 06h 
		mov		si, int_string
		call	my_puts
		pop		si
		pop		cx
		iret

int13_string db 'hello, int13!'
int_13:
		push	cx
		push	si
		mov		cx, 0Dh
		mov		si, int13_string
		call	my_puts
		pop		si
		pop		cx
		iret

my_puts:
		push	ax
		push	cx
		push	si
		push	di
		push	ds
		push	es
		mov		ax, 08h * 03h
		mov		es, ax
		xor		di, di
		mov		ds, di
		mov		al, 02h
lp:
		movsb
		stosb
		loop	lp
		pop		es
		pop		ds
		pop		di
		pop		si
		pop		cx
		pop		ax
		ret


gdt_table:
		dw		32 - 1
		dd		GDT
idt_table:
		dw		256 * 8
		dd		buffer

GDT:
		times 8 db 00h
		db	0FFh, 0FFh, 	00h, 00h,  00h, 10011000b, 00000000b, 00h
		db	0FFh, 0FFh, 	00h, 00h,  00h, 10010110b, 00001111b, 00h
		db	00h,  010h, 	00h, 080h, 0Bh, 10010010b, 00000000b, 00h
buffer:
		times 510 - ($ - $$) db 00h
		db	055h, 0AAh

IDT:
		%rep 13
			dw	int_all
			dw	08h
			db 	00h, 10000110b, 00h, 00h

		%endrep

			dw int_13
			dw 08h
			db 00h, 10000110b, 00h, 00h

		%rep 256 - 14
			dw int_all
			dw 08h
			db 00h, 10000110b, 00h, 00h
		%endrep
