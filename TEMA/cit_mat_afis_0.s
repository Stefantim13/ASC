.data
ma: .space 2000
mb: .space 2000
p: .space 4
i: .space 4
j: .space 4
n: .space 4
m: .space 4
nn: .space 4
mm: .space 4
x: .space 4
y: .space 4
k: .space 4
q: .space 4
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d "
formatSpace: .asciz "\n"
.text

.global main
main:

#citesc n si m
pusha
push $n
push $formatScanf
call scanf
pop %ebx
pop %ebx
popa

pusha
push $m
push $formatScanf
call scanf
pop %ebx
pop %ebx
popa

# nn si mm sunt coordonatele matricii mari

movl n, %eax
addl $2, %eax
movl %eax, nn
incl n

movl m, %eax
addl $2, %eax
movl %eax, mm
incl m

pusha
push $p
push $formatScanf
call scanf
pop %ebx
pop %ebx
popa

#for ul pt citirea celulelor

movl $0, i
et_for:
movl i, %ecx
cmp %ecx, p
je gata

pusha
push $x
push $formatScanf
call scanf
pop %ebx
pop %ebx
popa

pusha
push $y
push $formatScanf
call scanf
pop %ebx
pop %ebx
popa

incl x
incl y

lea ma, %edi
movl x, %eax
xor %edx, %edx
mull mm
addl y, %eax

movl $1, (%edi, %eax, 4)

incl i
jmp et_for
gata:

pusha
pushl $k
pushl $formatScanf
call scanf
pop %ebx
pop %ebx
popa

# modificare matrice
mov $0, q

for_k:

movl q, %ecx
cmp %ecx, k
je contk


movl $1, i
for_lin:

movl i, %ecx
cmp %ecx, n
je gata_for
movl $1, j

for_col:
movl j, %ecx
cmp %ecx, m
je cont

movl i, %eax
xor %edx, %edx
mull mm
addl j, %eax

lea ma, %edi
movl (%edi, %eax, 4), %eax




incl j
jmp for_col

contp:
incl i
jmp for_lin

contk:
jmp for_k


gata_for:


# for afisare matrice

movl $1, i
for_linie:

movl i, %ecx
cmp %ecx, n
je exit
movl $1, j

for_coloana:
movl j, %ecx
cmp %ecx, m
je cont

movl i, %eax
xor %edx, %edx
mull mm
addl j, %eax

lea ma, %edi
movl (%edi, %eax, 4), %edx

pusha

push %edx
push $formatPrintf
call printf
pop %ebx
pop %ebx

pushl $0
call fflush
pop %ebx
popa

incl j
jmp for_coloana

cont:

pusha
push $formatSpace
call printf
pop %ebx

push $0
call fflush
pop %ebx
popa

incl i

jmp for_linie


exit:
mov $1, %eax
xor %ebx, %ebx
int $0x80

