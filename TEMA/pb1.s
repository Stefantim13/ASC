.data
	ma: .space 2000
	mb: .space 2000
	w: .space 2000
	r: .space 2000
	o: .space 2000
	s: .space 30
	caz: .space 4
	l: .space 4
	u: .space 4
	a: .space 4
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
	st: .long -1
	formatString: .asciz "%s"
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d"
	formatHexa: .asciz "%X"
	formatScanfH: .asciz "%1X"
	formatSpace: .asciz "\n"
	format0x: .asciz "0x"
	formatGarbage: .asciz "\n0x"
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
	je gata_for

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

gata_for:

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


## if pt cazuri --------------------------------------------------------------------------------------------------------------------------------

pusha
push $caz
push $formatScanf
call scanf
pop %ebx
pop %ebx
popa

xor %eax, %eax
cmp caz, %eax
jne caz2


caz1:


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
je gata_r

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

for_codif:
mov u, %ecx
cmp %ecx, i
je gata_codif

xor %edx, %edx
mov nn, %eax
mull mm
mov %eax, %ebx

xor %edx, %edx
mov i, %eax
divl %ebx

lea ma, %edi
movl (%edi, %edx, 4), %ebx

lea w, %edi
movl i, %ecx
movl (%edi, %ecx, 4), %eax
xorl %ebx, %eax
movl %eax, (%edi, %ecx, 4)


incl i
jmp for_codif

gata_codif:

pusha
pusha
push $format0x
call printf
pop %ebx

push $0
call fflush
pop %ebx

popa


movl $0, i
for_hexa:
mov u, %ecx
cmp %ecx, i
je gata_hexa

xor %eax, %eax

lea w, %edi
movl i, %ecx
movl (%edi, %ecx, 4), %ebx
shl $3, %ebx
addl %ebx, %eax
incl i

movl i, %ecx
movl (%edi, %ecx, 4), %ebx
shl $2, %ebx
addl %ebx, %eax
incl i

movl i, %ecx
movl (%edi, %ecx, 4), %ebx
shl $1, %ebx
addl %ebx, %eax
incl i

movl i, %ecx
movl (%edi, %ecx, 4), %ebx
addl %ebx, %eax
incl i

pusha
push %eax
push $formatHexa
call printf
pop %ebx
pop %ebx

push $0
call fflush
pop %ebx

popa

jmp for_hexa
gata_hexa:

###########################################################################################################################################################################
caz2:



pusha
pushl $formatGarbage
call scanf
popl %ebx
popa


movl $0, q
for_cit:

movl $-1, %eax
mov %eax, x

pusha
pushl $x
pushl $formatScanfH
call scanf
popl %ebx
popl %ebx

aici:

movl x, %eax
cmp st, %eax
je gata_cit


lea w, %edi
mov q, %ecx
addl $3, %ecx

mov x, %eax
xor %edx, %edx
cmp %eax, %edx
je continue

movl $2, %ebx
divl %ebx
movl %edx, (%edi,%ecx,4)

decl %ecx

xor %edx, %edx
cmp %eax, %edx
je continue

movl $2, %ebx
divl %ebx
movl %edx, (%edi,%ecx,4)

decl %ecx

xor %edx, %edx
cmp %eax, %edx
je continue

movl $2, %ebx
divl %ebx
movl %edx, (%edi,%ecx,4)

decl %ecx

xor %edx, %edx
cmp %eax, %edx
je continue

movl $2, %ebx
divl %ebx
movl %edx, (%edi,%ecx,4)


continue:


mov q, %eax
addl $4, %eax
mov %eax, q
jmp for_cit
gata_cit:



movl $0, i

for_afis:
mov i, %eax
cmp q, %eax
je gata_afis

lea w, %edi
mov i, %ecx
mov (%edi, %ecx, 4), %eax

pusha
push %eax
push $formatPrintf
call printf
pop %ebx
pop %ebx

push $0
call fflush
pop %ebx
popa

incl i
jmp for_afis
gata_afis:



exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

