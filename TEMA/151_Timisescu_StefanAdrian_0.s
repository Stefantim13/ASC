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
	cnt: .space 4
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

