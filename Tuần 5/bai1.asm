.data
	runtest: .asciiz "ohaiyo"
.text
	li $v0 , 4
	la $a0 , runtest
	syscall
