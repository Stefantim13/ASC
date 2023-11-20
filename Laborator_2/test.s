.data
	s: .long 0
.text
.global main
main:
	mov $1, %edx
	mov $0, %eax
	movl $0xffffffff, %ebx
 	divl %ebx
 	mov %eax, %ecx
et_loop:
	add %ecx, s
	loop et_loop
exit:
	mov $0, %eax
	mov $1, %ebx
	int $0x80
