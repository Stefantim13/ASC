#afla maximul dintr-un vector si nr de aparitii ale acestuia
#dai gdb la eticheta exit si print (long) maxim , print (long) ap
.data
v: .long 4, 1, 8, 7, 8, 7, 7
n: .long 7
maxim: .long -1
ap: .long 0
.text
.global main
main:

mov n, %ecx
mov $v, %edi

begin:
mov -4(%edi,%ecx,4), %eax
cmp maxim, %eax
je egal
jl final
jg mai_mare
egal:
mov ap, %ebx
add $1, %ebx
mov %ebx, ap
jmp final

mai_mare:
mov $1, %ebx
mov %ebx, ap
mov %eax, maxim

final:
loop begin

exit:
mov $1, %eax
mov $0, %ebx
int $0x80
