.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text

	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
hang_doc:
	beq $t1, 256, end1
	nop
	add $t2 , $k0 , $t1
	li $t0, RED
	sw $t0, 0($t2)
	addi $t1, $t1 , 32
	j hang_doc
	nop
end1:


	li $t1, 228
hang_ngang:
	beq $t1, 256, end2
	nop 
	add $t3, $k0, $t1
	li $t0, RED
	sw $t0, 0($t3)
	addi $t1, $t1 ,4
	j hang_ngang
	nop
end2:
	