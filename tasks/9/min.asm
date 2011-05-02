format	elf

public	min as '_min'

min:
	push	ebp
	mov	ebp, esp
	mov	eax, [ ebp + 8 ]
	cmp	eax, [ ebp + 12 ]
	jc	_ret_a
	mov	eax, [ ebp + 12 ]
	jmp	_ret
_ret_a:
	mov	eax, [ ebp + 8 ]
_ret:
	pop	ebp
	ret