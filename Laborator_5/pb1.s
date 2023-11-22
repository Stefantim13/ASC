#Toti divizorii unui nr citit de la tastatura
#Pt a pastra valorile din registri trebuie pus pusha si popa!!!!! ft important
#trebuie facut si pt fflush pusha si popa
.data
x: .space 4

format_int: .asciz "%d"
afisare: .asciz "%d "
.text
.global main
main:

#am citit numarul
pusha
push $x
push $format_int
call scanf
pop %ebx
pop %ebx
popa

start:

#am facut un loop cu ecx pornind de la x pana la 1 si am verificat daca restul impartirii la ecx e 0


movl x, %ecx
etloop:
movl $0, %edx
movl x, %eax

divl %ecx
mov $0, %eax

cmp %edx, %eax
jne gata
bine:

pusha

push %ecx
push $afisare
call printf
pop %ebx
pop %ebx

push $0
call fflush
pop %ebx

popa

gata:
loop etloop

final:
mov $1, %eax
mov $0, %ebx
int $0x80
