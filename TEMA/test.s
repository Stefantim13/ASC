.data
g: .space 4
gg: .space 4
a: .space 4
b: .space 4
s: .space 4
d: .space 4
zece: .long 10
format: .asciz "%d"
file: .asciz "in.txt"
.text

citire:
pushl %ebp
mov %esp, %ebp

mov $3, %eax
mov %eax, %ebx
mov $g, %ecx
mov $1, %edx
int $0x80

movb g, %bl
cmp $'\n', %bl
je solved
sub $'0', %bl
movl %ebx, gg

mov $3, %eax
mov %eax, %ebx
mov $g, %ecx
mov $1, %edx
int $0x80

movl gg, %eax
movb g, %bl
cmp $'\n', %bl
je solved
sub $'0', %bl
xor %edx, %edx
mull zece
addl %ebx, %eax
movl %eax, gg

mov $3, %eax
mov %eax, %ebx
mov $g, %ecx
mov $1, %edx
int $0x80


solved:
mov 8(%ebp), %ebx
movl gg, %eax
movl %eax, (%ebx)

popl %ebp
ret
.global main
main:

mov $5, %eax
mov $file, %ebx
mov $0, %ecx
int $0x80

start:

pusha
pushl $a
call citire
popl %ebx
popa


pusha
pushl $b
call citire
popl %ebx
popa

movl a, %eax
movl b, %ebx
addl %ebx, %eax

movl %eax, s


pusha

pushl s
pushl $format
call printf
popl %ebx
popl %ebx

push $0
call fflush
pop %ebx

popa


mov $6, %eax
mov %eax, %ebx
int $0x80
exit:
movl $1, %eax
xor %ebx, %ebx
int $0x80
