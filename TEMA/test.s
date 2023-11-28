.data
g: .space 4
a: .space 4
b: .space 4
s: .space 4
zece: .long 10
format: .asciz "%d"
.text

citire:
pushl %ebp
mov %esp, %ebp

xor %eax, %eax
movb 8(%ebp), %bl
cmp $'\n', %bl
je solved
sub $'0', %bl
add %ebx, %eax


movb 9(%ebp), %bl
cmp $'\n', %bl
je solved
sub $'0', %bl
xor %edx, %edx
mull zece
addl %ebx, %eax

solved:
mov 12(%ebp), %ebx
movl %eax, (%ebx)

popl %ebp
ret
.global main
main:

movl $3, %eax
movl $2, %ebx
movl $g, %ecx
movl $4, %edx
int $0x80

pusha
pushl $a
pushl g
call citire
popl %ebx
popl %ebx
popa


movl $3, %eax
movl $2, %ebx
movl $g, %ecx
movl $4, %edx
int $0x80


pusha
pushl $b
pushl g
call citire
popl %ebx
popl %ebx
popa

start:
movl a, %eax
movl b, %ebx
addl %ebx, %eax

movl %eax, s


movl $4, %eax
movl $1, %ebx
movl $s, %ecx
movl $4, %edx
int $0x80

exit:
movl $1, %eax
xor %ebx, %ebx
int $0x80
