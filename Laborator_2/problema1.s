.data
	a: .long 23
	b: .long 12
	c: .long 8
	minim: .space 4
.text
.global main
main:
	mov a, %eax
	mov b, %ebx
	cmp %eax, %ebx
	jb mai_mic
mai_mare:
	mov %eax, minim
	jmp sari
mai_mic:
	mov %ebx, minim
sari:
	mov c, %eax
	mov minim, %ebx
	cmp %eax, %ebx
	jb sarit
mai_micut:
	mov %eax, minim
sarit:
exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80

