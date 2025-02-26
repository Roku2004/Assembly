.data
	A:	.word	3, 6, -2, -5, 7, -3
	Aend:	.word
	message:.asciiz	"arrayChange = "
.text
main:
	la	$t0, A
	la	$t1, Aend
	li	$a1, 0		# step = 0
	jal	arrayChange
exit:
	nop
	la	$a0, message
	li	$v0, 4
	syscall
	addi	$a0, $a1, 0
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall
end_main:


arrayChange:
	addi	$s0, $t0, 0	# s0 = address of A[0]
loop:
	addi	$s0, $s0, 4	# s0 += 4 <=> i++ 
	slt	$s2, $s0, $t1	# if i > n then break
	beq	$s2, 0, end_loop
	lw	$s1, 0($s0)	# s1 = A[i]
	lw	$s3, -4($s0)	# s3 = A[i-1]
	slt	$s4, $s3, $s1	# if s1 > s3 then step = A[i-1] - A[i] + 1 
	bne	$s4, 0, loop	# else continue
	sub	$s5, $s3, $s1	# s5 = A[i-1] - A[i]
	add	$a1, $a1, $s5	# step += s5
	addi	$a1, $a1, 1	# step += 1
	addi	$s1, $s3, 1	# A[i] = A[i-1] + 1
	sw	$s1, 0($s0)
	j	loop
end_loop:
	jr	$ra
	