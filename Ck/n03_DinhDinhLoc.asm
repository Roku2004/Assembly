.eqv left_segs 0xFFFF0011 # Dia chi cua den led 7 doan trai.
.eqv right_segs 0xFFFF0010 # Dia chi cua den led 7 doan phai.

.eqv counter 0xFFFF0013 #time counter
.eqv mask_cause_counter 0x00000400 #Counter interrupt

.eqv key_code 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv key_read 0xFFFF0000 # =1 if has a new keycode ?

.data
	arr: .byte 63, 6, 91, 79, 102, 109, 125, 7, 127, 111 #mang chua so 0-9 de hien thi ra 7 seg led(moi so 1 byte)
	str1: .asciiz "bo mon ky thuat may tinh"  # 24 ki tu
	str2: .asciiz "toc do go phim: "
	str3: .asciiz " tu/phut\n "
	str4: .asciiz "thoi gian chay chuong trinh "
	str5: .asciiz "(s)"
.text
	li $t0 , counter
	sb $t0 , 0($t0) #kich hoat counter
	
	li $k0 , key_code
	li $k1 , key_read
	
	la $a1 , str1 # luu add str1
	la $a2 , arr  # luu add mang arr
	
	li $t8 , left_segs
	li $t9 , right_segs
	
	li $s1 , 0 # so ki tu dung
	li $s3 , 0 # thoi gian chay chuong trinh
	li $s4 , 0 # tong so lan ngat counter
	li $s5 , 0 # chua ki tu dung truoc ki tu dang check
	li $s6 , 0 # so tu 
	
wait_key:
	lb $t1 , 0($k1)
	bne $t1 , 0 , keyboardinter # check key read
	nop
	li $v0 , 32 #sleep
	li $a0 , 5 #sleep 5ms
	syscall 
	
	nop
	b wait_key
	nop
	
keyboardinter:
	teqi $t1 , 1 # check de nhay ngat .ktext
	nop
	b wait_key # check ki tu tiep khi return chg trinh ngat
	nop
.ktext 0x80000180
	li $t0 , counter
	sb $t0 , 0($t0) # stop ngat counter de khong anh huong chg trinh ngat
	
checkcause_inter:
	li $t1 , mask_cause_counter
	mfc0 $t2 , $13 # t2 chua thong tin ngat
	bne $t1 , $t2 , check_str # check ko do counter thi check str
	nop

counterinter:
	blt $s4 , 40 , tangsolanngat # 40 lan ngat tuong duong 40 lan ngu 5ms => 200 ms sleep
	nop # 40 lan ngat tuong duong 1s chuong trinh
	jal show_7led
	nop 
	addi $s4 , $0 , 0 #reset so lan ngat
	addi $s3 , $s3 , 1 # tang time run
	j end_inter
	nop

tangsolanngat:
	addi $s4 , $s4 , 1 # tang so lan ngat
	j end_inter
	nop

check_str:
	lb $t3 , 0($a1) # get char str test case
	beq $t3 , 0 , end #check string toi NULL thi dung
	nop
	lb $t4 , 0($k0) # get key code
	bne $t3 , $t4 , continue1 # if key code sai thi check tiep
	nop
	addi $s1 , $s1 , 1 # ki tu dung +1

continue1:
# trc space la 1 tu -> tinh +1 tu
# trc space vua nhap la 1 space->ve main	
	bne $t4 , ' ' , continue2
	nop
	beq $s5 , ' ' , continue2
	nop
	addi $s6 , $s6 , 1 #tang so tu +1

continue2:
	addi $s5 , $t4 , 0 #save lai char cua check
	addi $a1 , $a1 , 1 #tang con tro str them 1 byte
	
end_inter: #ket thuc chg trinh ngat quay lai main can tang epc cho dung vs chuong trinh main	
# va kich hoat tro lai ngat counter
	li $t0 , counter
	sb $t0 , 0($t0)
	
	mtc0 $0 , $13 # reset cause reg
			
next_pc:
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14

return: eret # Return from exception

show_7led:
	addi $t5 , $s1 , 0
	addi $t6 , $0 , 10
	div  $t5 , $t6
	
	mflo $t5 #lay hang chuc
	mfhi $t6 #lay hang don vi
	
	#show left light
	add $t5 , $t5 ,$a2 #t5 chua hang chuc cua mang
	lb $t5 , 0($t5)
	sb $t5 , 0($t8) #hien so hang chuc
	
	#show right light
	add $t6 , $t6 , $a2 # t6 chua hang don vi cua mang
	lb $t6 , 0($t6)
	sb $t6 , 0($t9) #hien so hang don vi
	
	jr $ra #return ve ngat
	nop

end:	# in "toc do ban phim"
	li $v0 , 4
	la $a0 , str2 
	syscall
	
	li $v0 , 1 
	addi $s6 , $s6 , 1
	addi $t2 , $0 , 60
	mult $s6 , $t2  #so tu x 60(s)
	mflo $s6
	div $s6 , $s3 #(so tu x 60)/ thoi gian chg trinh(s)
	mflo $a0  
	syscall
	
	#in tu/phut
	li $v0 , 4
	la $a0 , str3 
	syscall 
	
	#in tgian chg trinh
	li $v0 , 4
	la $a0 , str4
	syscall
	
	li $v0 , 1
	addi $a0 , $s3 , 0
	syscall
	
	#in (s)
	li $v0 , 4
	la $a0 , str5
	syscall
	
	li $v0 , 10
	syscall
