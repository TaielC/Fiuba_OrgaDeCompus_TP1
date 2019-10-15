	.file	1 "matrix.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.text
	.align	2
	.globl	create_matrix
	.ent	create_matrix
create_matrix:
	.frame	$fp,56,$ra		# vars= 16, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,52($sp)
	sw	$fp,48($sp)
	sw	$gp,44($sp)
	sw	$s0,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	lw	$v0,56($fp)
	bne	$v0,$zero,$L18
	lw	$v0,60($fp)
	bne	$v0,$zero,$L18
	sw	$zero,32($fp)
	b	$L17
$L18:
	li	$a0,12			# 0xc
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	bne	$v0,$zero,$L19
	sw	$zero,32($fp)
	b	$L17
$L19:
	lw	$s0,28($fp)
	lw	$v1,56($fp)
	lw	$v0,60($fp)
	mult	$v1,$v0
	mflo	$v0
	sll	$v0,$v0,3
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,8($s0)
	lw	$v0,28($fp)
	lw	$v0,8($v0)
	bne	$v0,$zero,$L20
	lw	$a0,28($fp)
	la	$t9,free
	jal	$ra,$t9
	sw	$zero,32($fp)
	b	$L17
$L20:
	sw	$zero,24($fp)
$L21:
	lw	$v1,56($fp)
	lw	$v0,60($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,24($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L24
	b	$L22
$L24:
	lw	$a0,28($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	sw	$zero,0($v0)
	sw	$zero,4($v0)
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L21
$L22:
	lw	$v1,28($fp)
	lw	$v0,56($fp)
	sw	$v0,0($v1)
	lw	$v1,28($fp)
	lw	$v0,60($fp)
	sw	$v0,4($v1)
	lw	$v0,28($fp)
	sw	$v0,32($fp)
$L17:
	lw	$v0,32($fp)
	move	$sp,$fp
	lw	$ra,52($sp)
	lw	$fp,48($sp)
	lw	$s0,40($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	create_matrix
	.size	create_matrix, .-create_matrix
	.align	2
	.globl	destroy_matrix
	.ent	destroy_matrix
destroy_matrix:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v0,40($fp)
	lw	$v0,8($v0)
	beq	$v0,$zero,$L26
	lw	$v0,40($fp)
	lw	$a0,8($v0)
	la	$t9,free
	jal	$ra,$t9
$L26:
	lw	$v0,40($fp)
	beq	$v0,$zero,$L25
	lw	$a0,40($fp)
	la	$t9,free
	jal	$ra,$t9
$L25:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	destroy_matrix
	.size	destroy_matrix, .-destroy_matrix
	.rdata
	.align	2
$LC0:
	.ascii	"%zu \000"
	.align	2
$LC1:
	.ascii	"%lg \000"
	.align	2
$LC2:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	print_matrix
	.ent	print_matrix
print_matrix:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$v0,52($fp)
	lw	$a0,48($fp)
	la	$a1,$LC0
	lw	$a2,4($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	sw	$zero,24($fp)
$L29:
	lw	$v0,52($fp)
	lw	$v1,52($fp)
	lw	$a0,0($v0)
	lw	$v0,4($v1)
	mult	$a0,$v0
	mflo	$v1
	lw	$v0,24($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L32
	b	$L30
$L32:
	lw	$a0,52($fp)
	lw	$v0,24($fp)
	sll	$v1,$v0,3
	lw	$v0,8($a0)
	addu	$v0,$v1,$v0
	lw	$a0,48($fp)
	la	$a1,$LC1
	lw	$a2,0($v0)
	lw	$a3,4($v0)
	la	$t9,fprintf
	jal	$ra,$t9
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L29
$L30:
	lw	$a0,48($fp)
	la	$a1,$LC2
	la	$t9,fprintf
	jal	$ra,$t9
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	print_matrix
	.size	print_matrix, .-print_matrix
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
