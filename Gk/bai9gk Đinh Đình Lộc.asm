.data
	so_hs:	       .word 3
	str1:          .asciiz "hoc sinh thu "
	str2:          .asciiz ": "
	student_name:  .space 256 # mang ten hoc sinh
	student_score: .space 256 # mang diem hoc sinh (4 bytes for each score)
	newline:       .asciiz"\n"
.text
main:	lw $s0 , so_hs
	
	# lap qua tung hoc sinh
	li $t0 , 0 # i = 0
	la $t1 , student_name
	la $t2 , student_score
loop:	beq $t0 , $s0 , end_loop # i = n jump end_loop

	li $v0 , 4
	la $a0 , str1
	syscall
	
	li $v0 , 1
	addu $a0 , $t0 , 1
	syscall
	
	li $v0 , 4
	la $a0 , str2
	syscall

	# doc ten hoc sinh
	li $v0 , 8 
	la $a0 , student_name
	li $a1 , 256
	syscall
	
	#doc diem mon toan cua hoc sinh
	li $v0 , 5
	syscall
	addu $t3 , $zero , $v0
	
	# kiem tra xem co truot ko
	sub $s1 , $t3 , 4  # s1 = t3 - 4
	slt $s2 , $s1 , $zero #ktra s1 co nho hon 0 ko
	bne $s2 , 0 , print
	
	# tien toi hoc sinh tiep theo
	addi $t0 , $t0 , 1 # i+=1
	addi $t1 , $t1 , 256  # Moi phan tu trong mang tên hoc sinh có do dài toi da 256 
	addi $t2 , $t2 , 4   # Moi phan tu trong mang diem là mot so nguyên (4 byte)
	
	j loop
	
print:	li $v0 , 4 # in ten hs truot
	la $a0 , student_name
	syscall
	
	li $v0 , 4
	la $a0 , newline
	syscall # xuong dong
	
	# tien toi hoc sinh tiep theo
	addi $t0 , $t0 , 1
	addi $t1 , $t1 , 256
	addi $t2 , $t2 , 4
	
	j loop
end_loop:
	li $v0 , 10
	syscall
