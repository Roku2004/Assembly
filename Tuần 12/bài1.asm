.eqv SEVENSEG_LEFT 0xFFFF0010 # ð?a ch? c?a ðèn led 7 doan trai. # Bit 0 = ?o?n a; # Bit 1 = ?o?n b; ... # Bit 7 = d?u .
.eqv SEVENSEG_RIGHT 0xFFFF0011 # ð?a ch? c?a ðèn led 7 doan ph?i
.data
arr: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
.text
main:
    # l?p t? 0 ð?n 15 
    la $t7, arr
    add $t8, $0, $t7
    add $t9, $0, $t7
    li $t1, 0 
loop:
    subi $t3, $t1, 10
    slt $t4, $t3, $0
    beq $t4, 0, exit
SO_TRUOC_9:
    lw $t2, 0($t8)
    addi $a0, $0, 0x06
    jal SHOW_7SEG_RIGHT # hi?n th?
   
    add $a0, $0, $t2
    jal SHOW_7SEG_LEFT 
    addi $t8, $t8, 4
    addi $t1, $t1, 1
    
    li $v0, 32
    li $a0, 1000
    syscall
    j loop

 
exit: 
    li $v0, 10
    syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT: 
# param[in] $a0 giá tr? c?n hi?n th? 
# remark $t0 thay ð?i
#---------------------------------------------------------------
SHOW_7SEG_LEFT:
    li $t0, SEVENSEG_LEFT # Gán ð?a ch? c?ng
    sb $a0, 0($t0) # Gán giá tr? m?i
    jr $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT:
# param[in] $a0 
# remark $t0 
#---------------------------------------------------------------
SHOW_7SEG_RIGHT:
    li $t0, SEVENSEG_RIGHT 
    sb $a0, 0($t0)
    jr $ra
