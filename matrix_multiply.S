#include <mips/regdef.h>

	.text			# segmento de texto del programa
	.abicalls
	.align 2		# alineacion 2^2 (4 bytes)
	.globl	matrix_multiply
	.ent	matrix_multiply	

matrix_multiply:
	
	.frame	$fp, 32, ra

	# bloque para codigo PIC
	.set	noreorder	# apaga reordenamiento de instrucciones
	.cpload t9		# directiva usada para codigo PIC
	.set	reorder		# enciende reordenamiento de instrucciones

	# creación del stack frame
	subu	sp, sp, 32	# 2*8 (SRA) + 0 (FRA) + 0 (LTA) + 2*8 (ABA)
	
	.cprestore 16 		# Guardado de gp en SRA después de cada jal
	sw	$fp, 20(sp)	# Guardado de fp en SRA
	sw	ra, 24(sp)	# Guardado de ra en SRA ya que se llamará a create_matrix

	# Usamos $ft6 en lugar de sp
	move	$fp, sp	

	# Guardamos los argumentos en el ABA
	sw 	a0, 32($fp) 	# *m1
	sw 	a1, 36($fp) 	# *m2
	
	# Revisamos que las matrices sean válidas
	sub 	v0, v0, v0	
	# si (!m1 || !m2) return
	beqz 	a0, return
	beqz 	a1, return	
	lw 	t0, 4(a0)	# t0 = m1->cols
	lw 	t1, 0(a1)	# t1 = m2->rows
	bne 	t0, t1, return	# si (m1->cols != m2->rows) return

	# Creamos la matriz a devolver 
	lw 	t0, 0(a0)	# t0 <- m1->rows
	lw 	t1, 4(a1)	# t1 <- m2->cols
	multu	t0, t1		# acc = t0 * t1 (tamanio de m_return)
	mflo	a0		# a0 = acc
	addiu	a0, a0, 12	# a0 = a0 + 12 (struct matrix_t + tamanio)
	la 	t9, malloc	# cargamos mymalloc
	jal 	ra, t9		# llamamos a mymalloc
	beq	v0, $0, return	# verificamos que el valor de retorno sea válido

	lw 	a0, 32($fp)
	lw 	a1, 36($fp)
	# tenemos
	## v0 <-> m_return
	## a0 <-> m1
	## a1 <-> m2
	lw 	t0, 0(a0)	# t0 <- m1->rows
	lw 	t1, 4(a0)	# t1 <- m1->cols (igual a m2->rows)
	lw 	t2, 4(a1)	# t2 <- m2->cols

	# llenamos los datos de m_result
	addiu 	t3, v0, 12	# t3 será la posición de *array de m_result
	sw	t3, 8(v0)	# m_result->array <- t3
	sw	t0, 0(v0)	# m_result->rows <- t0
	sw	t2, 4(v0)	# m_result->cols <- t2

	# inicialización para iterar
	move 	t3, $0		# t3 = 0 (i = 0)

	# obtenemos posiciones de memoria de los arrays
	lw t7, 8(a0)	# t7 <- ptr de m1->array
	lw t8, 8(a1)	# t8 <- ptr de m1->array
	lw t9, 8(v0)	# t9 <- ptr de m_result->array

for_m1:
	# recorremos filas de m1
	beq 	t3, t0, return	# si  (i == m1->rows) return
	move 	t4, $0		# t4 = 0 (j = 0)

for_m2:
	# recorremos columnas de m2	
	beq 	t4, t2, fin_for_m2	# si (j == m2->cols) fin_for_m2
	move 	t5, $0		# t5 = 0 (k = 0)
	mtc1 	zero, $f0	# $f0 = 0 (suma = 0)
	mtc1 	zero, $f1	

for_suma:
	# suma acumulatoria de m1[i*m1->cols+k] * m2[k*m2->cols+j]
	beq 	t5, t1, fin_for_suma	# si (k == m1->cols) fin_for_suma
	multu 	t3, t1		# acc = i * m1->cols
	mflo 	t6		# t6 = acc 
	addu 	t6, t6, t5	# t6 = t6 + k
	sll 	t6, t6, 3	# t6 = 8 * p
	addu 	t6, t6, t7	# t6 = *m1->array[p]
	l.d 	$f2, 0(t6)	# $f2 <- p
	multu 	t5, t2		# acc = k * m2->cols
	mflo 	t6		# t6 = acc
	addu 	t6, t6, t4	# t6 = t6 + j
	sll 	t6, t6, 3	# t6 = 8 * p
	addu 	t6, t6, t8	# t6 = *m2->array[p]
	l.d 	$f4, 0(t6)	# $f4 <- p
	mul.d 	$f2, $f2, $f4 	# $f2 = $f2 * $f4
	add.d 	$f0, $f0, $f2 	# suma += $f2
	addiu 	t5, t5, 1	# k++
	bal 	for_suma

fin_for_suma:
	multu 	t3, t0		# t6 = i * m1->rows
	mflo 	t6		# t6 = acc
	addu 	t6, t6, t4	# t6 = t6 + j
	sll	t6, t6, 3	# t6 = 8 * p
	addu 	t6, t6, t9	# t6 = *m_result[p]
	s.d 	$f0, 0(t6)	# m_result[p] <- $f0
	addiu 	t4, t4, 1	# j++
	bal 	for_m2

fin_for_m2:
	addiu 	t3, t3, 1	# i++
	bal 	for_m1

return:
	# restauramos callee-saved regs
	lw	gp, 16(sp)
	lw	$fp, 20(sp)
	lw	ra, 24(sp)
	# destruimos stack frame
	addu	sp, sp, 32
	# vuelvemos a funcion llamante
	jr	ra
	.end	matrix_multiply
	.size matrix_multiply,.-matrix_multiply
