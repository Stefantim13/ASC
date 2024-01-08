.data

x: .long 1, 3, 6, 7, 9
n1: .long 5
n2: .long 10
c: .long 0x64636261
s: .space 11
.text
.global main
main:
xor %eax, %eax
mov $s, %edi
mov $x, %esi
movb c, %al
mov $0, %ecx

et_loop1:
cmp n2, %ecx
je et_exit_loop1
mov %al, (%edi, %ecx, 1)
inc %ecx
jmp et_loop1

et_exit_loop1:
mov $c, %eax
movb 1(%eax), %al
mov $0, %ecx

et_loop2:
cmp n1, %ecx
je et_exit
mov (%esi, %ecx,4), %ebx
mov %al, (%edi, %ebx, 1)
inc %ecx
jmp et_loop2

et_exit:
mov $10, %ecx
movb $0, (%edi, %ecx, 1)
mov $4, %eax
mov $1, %ebx
mov $s, %ecx
mov $11, %edx
int $0x80

mov $1, %eax
xor %ebx, %ebx
int $0x80
