	org 0x7c00

	cli
	mov	ax,cs
	mov	ds,ax
	mov	ss,ax
	mov	sp,0
	mov	es,ax
	sti

	mov	ax,0x0201
	mov	cx,0x02
	mov	dh,ch
	xor	dl,dl
	mov bx,buffer
	int 0x13
	jc	_err

	mov	si,buffer	
	mov	di,stroka1
_copy:
	lodsb
	stosb
	test	al,al
	jnz	_copy

	mov	si,stroka1
	jmp	_print

_err:
	mov	si,error
	jmp	_print

_print: 
	mov	bp,stroka1
	mov	ax,1301h
	mov	bx,3
	mov	cx,4
	xor	dx,dx
	int	10h

_end:
	cli
	hlt
	ret

error	db	'Error.',0
stroka1 db	0
	times	510-($-$$)	db 0
	db	0x55,0xaa
stroka	db	'Ola!',0
	times	507	db 0
buffer	db	?