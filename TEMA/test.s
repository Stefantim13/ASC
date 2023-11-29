.data


fileo: .asciz "out.txt"
prop: .asciz "1 "
alt: .asciz "0 "
.text

.global main
main:

mov $5, %eax
mov $fileo, %ebx
mov $2, %ecx
int $0x80

mov $4, %eax
mov $3, %ebx
mov $prop, %ecx
mov $2, %edx
int $0x80

mov $4, %eax
mov $3, %ebx
mov $alt, %ecx
mov $2, %edx
int $0x80

exit:
movl $1, %eax
xor %ebx, %ebx
int $0x80

