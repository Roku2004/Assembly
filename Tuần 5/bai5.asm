.data
	string: .space 20
	str1: .asciiz "Nhap ki tu thu "
	str2: .asciiz ": "
	str3: .asciiz "\n"
	str4: .asciiz "Chuoi vua nhap la "
.text
	li $s0, 20
	li $s1, 0
	la $s2, string
	li $s3, 10
read_char:	
	beq $s1, $s0, exit_char # neu i=N
	li $v0, 4 # in str1
	la $a0, str1
	syscall
	# in thu tu ki tu
	addi $t1,$s1,1
	li $v0, 1
	addu $a0,$zero, $t1
	syscall
	# in str2
	li $v0, 4
	la $a0, str2
	syscall
	# nhap ki tu
	li $v0, 12
	syscall
	
	addu $t0, $zero, $v0
	beq $t0 , $s3, exit_char
	# in str3
	li $v0, 4
	la $a0, str3
	syscall
	
	add $s5,$s2,$s1
	sb $t0, 0($s5)
	addi $s1,$s1,1
	j read_char	
exit_char:
	li $v0, 4
	la $a0,str4
	syscall
print_string:
	li $v0, 11
	lb $a0, 0($s5)
	syscall
	addi $s5, $s5, -1
	j print_string
