format	elf

public	min as '_min'

min:
	push	ebp
	mov	ebp, esp
	mov	eax, [ ebp + 8 ]
	sub	eax, [ ebp + 12 ]
	jc	_ret_a
	mov	eax, [ ebp + 12 ]
	pop	ebp
	ret
_ret_a:
	mov	eax, [ ebp + 8 ]
	pop	ebp
	ret