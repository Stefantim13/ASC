.data
format_int: .asciz "%d"
afisare_int: .asciz "%d "
v: .space 416
n: .space 4
x: .space 4
.text
.global main
main:

#citesc numar de nr
pusha

pushl $n
pushl $format_int
call scanf
popl %ebx
popl %ebx

popa

lea v, %edi
mov n, %ecx


#citesc vectorul
etloop_1:
mov n, %eax
subl %ecx, %eax

pusha

pushl $x
pushl $format_int
call scanf
popl %ebx
popl %ebx

popa

mov x, %edx
mov %edx, (%edi, %eax, 4)

loop etloop_1

lea v, %edi
mov n, %ecx

etloop_2:

movl n, %eax
subl %ecx, %eax
movl (%edi, %eax, 4), %ebx

movl %ebx, %eax
xor %edx, %edx

movl $2, %ebp
divl %ebp
xor %eax, %eax
cmp %edx, %eax
jne div_2

pusha

pushl %ebx
pushl $afisare_int
call printf
popl %ebx
popl %ebx

pushl $0
call fflush
pop %ebx

popa


div_2:
loop etloop_2

final:
mov $1, %eax
mov $0, %ebx
int $0x80
