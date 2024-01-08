.data
numein: .asciz "test.in"
numeout: .asciz "test.out"
read: .asciz "r"
write: .asciz "w"
citire: .asciz "%d"
nr: .space 4
.text
.global main
main:
	pusha
	push stdin
	push $read
	push $numein
	call freopen
	pop %ebx
	pop %ebx
	pop %ebx
	popa

	push stdout
	push $write
	push $numeout
	call freopen
	pop %ebx
	pop %ebx
	pop %ebx

	push $nr
	push $citire
	call scanf
	pop %ebx
	pop %ebx
	
	
	pusha
	push nr
	push $citire
	call printf
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx
	popa
	
exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80	
