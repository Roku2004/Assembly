.data
	str1: .asciiz "This is sum "
	str2: .asciiz " and "
	str3: .asciiz" is "
.text
	li $s0,5
	li $s1,8
	add $t0,$s0,$s1
	# In str1
	li $v0,4
	la $a0,str1
	syscall
	# In s0
	li $v0,1
	addu $a0,$zero,$s0
	syscall
	# In str2
	li $v0,4
	la $a0,str2
	syscall
	# In s1
	li $v0,1
	addu $a0,$zero,$s1
	syscall
	# In str3
	li $v0,4
	la $a0,str3
	syscall
	# In sum
	li $v0,1
	addu $a0,$zero,$t0
	syscall	

