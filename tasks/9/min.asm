format	elf

public	min as '_min'

min:
	push	ebp
	mov	ebp, esp
	mov	eax, [ ebp + 8 ]
	cmp	eax, [ ebp + 12 ]
	mov	eax, [ ebp + 12 ]
	cmovc	eax, [ ebp + 8 ]
	pop	ebp
	ret