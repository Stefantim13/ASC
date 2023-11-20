.data
s: .ascii "ana are mere"
t: .space 12
n: .long 12
.text
.global main
main:
mov n, %ecx
mov $0, %edx

mov $s, %edi
mov $t, %esi
begin:
movb -1(%edi,%ecx,1), %ah
movb %ah, (%esi,%edx,1)
add $1, %edx
loop begin

afis:
mov $4, %eax
mov $1, %ebx
mov $t, %ecx
mov n, %edx
int $0x80

exit:
mov $1, %eax
mov $0, %ebx
int $0x80
