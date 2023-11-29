.data
	g: .space 4
	gg: .space 4
	ma: .space 2000
	mb: .space 2000
	p: .space 4
	i: .space 4
	j: .space 4
	n: .space 4
	m: .space 4
	nn: .space 4
	mm: .space 4
	cnt: .space 4
	x: .space 4
	y: .space 4
	k: .space 4
	q: .space 4
	zece: .long 10
	zero: .asciz "0 "
	unu: .asciz "1 "
	formatSpace: .asciz "\n"
	filei: .asciz "in.txt"
	fileo: .asciz "out.txt"
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

afisare_0:

mov $4, %eax
mov %eax, %ebx
mov $zero, %ecx
mov $2, %edx
int $0x80

ret

afisare_1:

mov $4, %eax
mov %eax, %ebx
mov $unu, %ecx
mov $2, %edx
int $0x80

ret

enter:

mov $4, %eax
mov %eax, %ebx
mov $formatSpace, %ecx
mov $1, %edx
int $0x80

ret

.global main
main:
	#deschid fisieru

	mov $5, %eax
	mov $filei, %ebx
	mov $0, %ecx
	int $0x80

	mov $5, %eax
	mov $fileo, %ebx
	mov $2, %ecx
	int $0x80

	start:
	mov %eax, %ebx

	#citesc n si m
	pusha
	push $n
	call citire
	pop %ebx
	popa

	pusha
	push $m
	call citire
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
	call citire
	pop %ebx
	popa

	#for ul pt citirea celulelor

	movl $0, i


et_for:
	movl i, %ecx
	cmp %ecx, p
	je gata_for

	pusha
	push $x
	call citire
	pop %ebx
	popa

	pusha
	push $y
	call citire
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

gata_for:

	pusha
	pushl $k
	call citire
	pop %ebx
	popa

	# modificare matrice
	movl $0, q

for_k:

	movl q, %ecx
	cmp %ecx, k
	je gata_k


	movl $1, i
	for_lin:

	movl i, %ecx
	cmp %ecx, n
	je gata_lin
	movl $1, j

		for_col:
		movl j, %ecx
		cmp %ecx, m
		je gata_col

		movl i, %eax
		xor %edx, %edx
		mull mm
		addl j, %eax

		lea ma, %edi
		movl $0, cnt


		subl mm, %eax
		subl $1, %eax

		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt

		addl $1, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt

		addl $1, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt

		addl mm, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt

		addl mm, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt


		subl $1, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt


		subl $1, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt


		subl mm, %eax
		movl (%edi, %eax, 4), %ebx
		addl %ebx, cnt

		addl $1, %eax
		movl (%edi, %eax, 4), %ebx

		## if daca e celula
		lea mb, %edi

		movl $0, (%edi, %eax, 4)


		xor %edx, %edx
		cmp %ebx, %edx
		jne e_celula

		nu_e_celula:
		movl $3, %edx
		cmp %edx, cnt
		jne continua

		movl $1, (%edi, %eax, 4)

		jmp continua
		e_celula:

		movl $2, %edx
		cmp %edx, cnt
		jb continua
		movl $3, %edx
		cmp %edx, cnt
		jg continua

		movl $1, (%edi, %eax, 4)

		continua:

		incl j
		jmp for_col

		gata_col:
		incl i
		jmp for_lin


	gata_lin:



	# copiez matricea b in matricea a


	movl $1, i
	for_linie1:

	movl i, %ecx
	cmp %ecx, n
	je gata_lin1
	movl $1, j

		for_coloana1:
		movl j, %ecx
		cmp %ecx, m
		je gata_col1

		movl i, %eax
		xor %edx, %edx
		mull mm
		addl j, %eax

		lea mb, %edi
		movl (%edi, %eax, 4), %edx
		lea ma, %edi
		movl %edx, (%edi, %eax, 4)


		incl j
		jmp for_coloana1

	gata_col1:

	incl i

	jmp for_linie1

	gata_lin1:


	incl q
	jmp for_k


gata_k:


# for afisare matrice

movl $1, i
for_linie:

	movl i, %ecx
	cmp %ecx, n
	je gata_linie
	movl $1, j

	for_coloana:
		movl j, %ecx
		cmp %ecx, m
		je gata_coloana

		movl i, %eax
		xor %edx, %edx
		mull mm
		addl j, %eax

		lea ma, %edi
		movl (%edi, %eax, 4), %edx

		xor %eax, %eax
		cmp %edx, %eax
		je e_zero

		call afisare_1

		jmp e_unu
		e_zero:

		call afisare_0
		e_unu:

	incl j
	jmp for_coloana

	gata_coloana:

	call enter


incl i
jmp for_linie
gata_linie:



#inchid fisieru de citire

mov $6, %eax
mov %eax, %ebx
int $0x80


exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

