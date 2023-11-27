.data
s: .space 30
l: .space 4
w: .space 2000
r: .space 2000
i: .space 4
j: .space 4
u: .space 4
a: .space 4
formatString: .asciz "%s"
formatInt: .asciz "%d"
.text

.global main
main:

pusha
push $s
push $formatString
call scanf
pop %ebx
pop %ebx
popa

movl $0, i
movl $0, u
for_s:

lea s, %edi
movl i, %ecx
movb (%edi, %ecx, 1), %ah
movb %ah, l
xorb %ah, %ah
cmp l, %ah
je gata_s

movl $0, j


for_b2:
mov l, %eax
xor %edx, %edx
cmp %edx, l
je gata_b2


mov $2, %ebx
divl %ebx
mov %eax, l

lea r, %edi
movl j, %ecx

movl %edx, (%edi,%ecx,4)


incl j
jmp for_b2
gata_b2:


movl j, %eax
movl %eax, a
for_adaug:
movl $8, %ecx
cmp a, %ecx
je gata_adaug

lea w, %edi
movl u, %ecx
mov $0, %eax
movl %eax, (%edi, %ecx, 4)


incl u
incl a
jmp for_adaug
gata_adaug:

decl j

for_r:
mov $-1, %eax
cmp j, %eax
je gata_r # modificaaaaaaaaaaaaaaaaaaa astaaaaaaaaaaaaaaaaaaaaaa daca nu mere

lea r, %edi
movl j, %ecx
movl (%edi, %ecx, 4), %eax

lea w, %edi
movl u, %ecx
movl %eax, (%edi, %ecx, 4)


incl u
decl j
jmp for_r
gata_r:

incl i
jmp for_s
gata_s:


movl $0, i

afis:
mov u, %ecx
cmp %ecx, i
je gata_afis

lea w, %edi
movl i, %ecx
movl (%edi, %ecx, 4), %eax
movl %eax, a

pusha
push a
push $formatInt
call printf
pop %ebx
pop %ebx

push $0
call fflush
pop %ebx
popa

incl i
jmp afis
gata_afis:


exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80


