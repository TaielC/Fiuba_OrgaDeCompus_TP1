	.file	1 "tp1.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"-h\000"
	.align	2
$LC1:
	.ascii	"--help\000"
	.align	2
$LC2:
	.ascii	"Usage: \n"
	.ascii	"  tp0 -h \n"
	.ascii	"  tp0 -V \n"
	.ascii	"  tp0 < in_file > out_file \n"
	.ascii	"Options: \n"
	.ascii	"  -V, --version \n"
	.ascii	"  Print version and quit.\n"
	.ascii	"  -h, --help\tPrint this information and quit.\n"
	.ascii	"Examples:\n"
	.ascii	"  tp0 < in.txt > out.txt\n"
	.ascii	"  cat in.txt | tp0 > out.txt\n\000"
	.align	2
$LC3:
	.ascii	"-V\000"
	.align	2
$LC4:
	.ascii	"--version\000"
	.align	2
$LC5:
	.ascii	"Matrix Multiplier \n"
	.ascii	"Version 1.0 \n\000"
	.align	2
$LC6:
	.ascii	"Parametros invalidos. Terminando ejecuci\303\263n.\n\000"
	.align	2
$LC7:
	.ascii	" %li\000"
	.align	2
$LC8:
	.ascii	"La dimension leida no es valida.\n\000"
	.align	2
$LC9:
	.ascii	"Hubo un error al crear una matriz para operar. \n\000"
	.align	2
$LC10:
	.ascii	" %lg\000"
	.align	2
$LC11:
	.ascii	"Hubo un error al leer los valores para la primer matriz."
	.ascii	" \n\000"
	.align	2
$LC12:
	.ascii	"Hubo un error al leer los valores para la segunda matriz"
	.ascii	". \n\000"
	.align	2
$LC13:
	.ascii	"Se hall\303\263 un caracter inv\303\241lido al final de "
	.ascii	"la linea: %c\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	lw	$v0,72($fp)
	slt	$v0,$v0,2
	bne	$v0,$zero,$L18
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC0
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L20
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC1
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L19
$L20:
	la	$a0,$LC2
	la	$t9,printf
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L19:
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC3
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L23
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC4
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L22
$L23:
	la	$a0,$LC5
	la	$t9,printf
	jal	$ra,$t9
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L22:
	la	$a0,__sF+176
	la	$a1,$LC6
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L18:
	sw	$zero,24($fp)
$L25:
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L27
	b	$L26
$L27:
	sw	$zero,32($fp)
	addu	$v0,$fp,28
	la	$a0,__sF
	la	$a1,$LC7
	move	$a2,$v0
	la	$t9,fscanf
	jal	$ra,$t9
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L28
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L28:
	lw	$v0,28($fp)
	bgtz	$v0,$L29
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L29
	la	$a0,__sF+176
	la	$a1,$LC8
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L29:
	lw	$v0,28($fp)
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	lw	$a1,32($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,36($fp)
	lw	$v0,36($fp)
	bne	$v0,$zero,$L31
	la	$a0,__sF+176
	la	$a1,$LC9
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L31:
	lw	$a0,32($fp)
	lw	$a1,32($fp)
	la	$t9,create_matrix
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	bne	$v0,$zero,$L32
	lw	$a0,36($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	la	$a0,__sF+176
	la	$a1,$LC9
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L32:
	sw	$zero,24($fp)
$L33:
	lw	$v0,36($fp)
	lw	$v1,36($fp)
	lw	$a0,4($v0)
	lw	$v0,0($v1)
	mult	$a0,$v0
	mflo	$v1
	lw	$v0,24($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L36
	b	$L34
$L36:
	lw	$a0,36($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	la	$a0,__sF
	la	$a1,$LC10
	move	$a2,$v0
	la	$t9,fscanf
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,1			# 0x1
	beq	$v1,$v0,$L35
	lw	$a0,36($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	la	$a0,__sF+176
	la	$a1,$LC11
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L35:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L33
$L34:
	sw	$zero,24($fp)
$L38:
	lw	$v0,36($fp)
	lw	$v1,40($fp)
	lw	$a0,4($v0)
	lw	$v0,0($v1)
	mult	$a0,$v0
	mflo	$v1
	lw	$v0,24($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L41
	b	$L39
$L41:
	lw	$a0,40($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	la	$a0,__sF
	la	$a1,$LC10
	move	$a2,$v0
	la	$t9,fscanf
	jal	$ra,$t9
	move	$v1,$v0
	li	$v0,1			# 0x1
	beq	$v1,$v0,$L40
	lw	$a0,36($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	la	$a0,__sF+176
	la	$a1,$LC12
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L40:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L38
$L39:
	lw	$v0,__sF+4
	addu	$v0,$v0,-1
	sw	$v0,__sF+4
	bgez	$v0,$L43
	la	$a0,__sF
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,49($fp)
	b	$L44
$L43:
	la	$v0,__sF
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,49($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L44:
	lbu	$v0,49($fp)
	sb	$v0,48($fp)
$L45:
	lhu	$v0,__sF+12
	srl	$v0,$v0,5
	andi	$v0,$v0,0x1
	bne	$v0,$zero,$L46
	lb	$v1,48($fp)
	li	$v0,32			# 0x20
	beq	$v1,$v0,$L47
	b	$L46
$L47:
	lw	$v0,__sF+4
	addu	$v0,$v0,-1
	sw	$v0,__sF+4
	bgez	$v0,$L49
	la	$a0,__sF
	la	$t9,__srget
	jal	$ra,$t9
	sb	$v0,50($fp)
	b	$L50
$L49:
	la	$v0,__sF
	lw	$v1,0($v0)
	move	$a0,$v1
	lbu	$a0,0($a0)
	sb	$a0,50($fp)
	addu	$v1,$v1,1
	sw	$v1,0($v0)
$L50:
	lbu	$v0,50($fp)
	sb	$v0,48($fp)
	b	$L45
$L46:
	lb	$v1,48($fp)
	li	$v0,10			# 0xa
	beq	$v1,$v0,$L51
	lw	$a0,36($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lb	$v0,48($fp)
	la	$a0,__sF+176
	la	$a1,$LC13
	move	$a2,$v0
	la	$t9,fprintf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L51:
	lw	$a0,36($fp)
	lw	$a1,40($fp)
	la	$t9,matrix_multiply
	jal	$ra,$t9
	sw	$v0,44($fp)
	la	$a0,__sF+88
	lw	$a1,44($fp)
	la	$t9,print_matrix
	jal	$ra,$t9
	lw	$a0,36($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	lw	$a0,44($fp)
	la	$t9,destroy_matrix
	jal	$ra,$t9
	b	$L25
$L26:
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
