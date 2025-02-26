.text
li $s0, 0x12345678 #load test value for these function
andi $t0, $s0, 0xff000000 #Extract the MSB of $s0
andi $t1, $s0, 0xffffff00 #clear the LSB of $s0
or $t3, $s0, 0x000000ff #Set LSB of $s0 (bits 7 to 0 are set to 1)
xor $s0,$s0,$s0  #Clear $s0 ($s0=0, must use logical instructions)