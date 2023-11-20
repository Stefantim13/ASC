.data
	a: .long 223
	b: .long 3
	p: .long 16
	sum: .space 4
	suma: .space 4
	mere: .asciz "PASS\n"
	nu_mere: .asciz "FAIL\n"
.text
.global main
main:
calculeaza:
	mov $0, %edx
	mov a, %eax
	divl p
	mov %eax, sum
	mov $0, %edx
	mov b, %eax
	mull p
	add %eax, sum

calculeaza2:
	mov $0, %edx
	mov a, %eax
	shr $4, %eax
	mov %eax, suma
	mov $0, %edx
	mov b, %eax
	shl $4, %eax
	add %eax, suma
compara:
	mov sum, %eax
	mov suma, %ebx
	cmp %eax, %ebx
	jne afiseaza1
afiseaza:
	mov $4, %eax
	mov $1, %ebx
	mov $mere, %ecx
	mov $6, %edx
	int $0x80
compara1:
	mov sum, %eax
	mov suma, %ebx
	cmp %eax, %ebx
	je exit

afiseaza1:
	mov $4, %eax
	mov $1, %ebx
	mov $nu_mere, %ecx
	mov $6, %edx
	int $0x80

exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
