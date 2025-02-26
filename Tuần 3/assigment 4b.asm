.data
	I: .word 3
	J: .word 14
.text
	#Load i and j
	la $t8, I
	la $t9, J
	lw $s1, 0($t8)
	lw $s2, 0($t9)
start:
	slt $t0, $s1, $s2 # I < J
	beq $t0, $zero, else
	addi $t1, $t1, 1 # x = x + 1
	addi $t3, $zero, 1 # z = 1
	j endif
else:
	addi $t2, $t2, -1 # y = y - 1
	add $t3, $t3, $t3 # z = 2*z
endif: