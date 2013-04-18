# UNTITLED PROGRAM

	.data	# Data declaration section
fin: .asciiz "decoded.txt"
wr: .asciiz "encoded.txt"
key:   .asciiz "\nEnter a key :"
sWord: .space 5000
	.text

main:		# Start of code section

getWord:
li $v0, 13
	la $a0, fin
	li $a1, 0
	li $a2, 0
	syscall
	move $s6, $v0

li $v0, 14
move $a0, $s6
la $a1, sWord
li $a2, 4900
syscall
add $t3, $v0, $zero
li $v0, 16
move $a0, $s6
syscall
#la $a0, sWord
#li $v0,4
#syscall
add $t4, $zero,$zero
#calcSize:
#lb $t2, sWord($t4)
#beq $t2, $zero, getKey
#addi $t3, $t3, 1
#addi $t4,$t4,1
#b calcSize
getKey:
add $t9, $zero, $zero
add $t4, $zero,$zero
li $v0,4
la $a0, key
syscall
li $v0, 5
syscall
add $s0, $v0, $zero
calculateBitAdd:
li $s1,7
div $s0, $s1
mfhi $t5
add $s7, $t5, $zero
initPowerloop:
li $s2, 2
li $s3, 2
beq $s7, $zero, resetCount
add $t5, $s7,$zero
powerloop:
beq $t5, $zero, addBits
mult $s2,$s3
mflo $s2
addi $t5,$t5, -1
b powerloop
addBits:
beq $t9,$t3,write
lb $s4, sWord($t4)
xor $s5, $s2, $s4
sb $s5, sWord($t4)
addi $t9, $t9, 1
addi $t4, $t4, 1
addi $s7, $s7, -1
b initPowerloop

write:
li $v0, 13
la $a0, wr
li $a1, 1
li $a2, 0
syscall
move $s6, $v0
li $v0, 15
move $a0, $s6
la $a1, sWord
add $a2, $zero, $t3
syscall
li $v0, 16
move $a0, $s6
syscall
#printInit:
#add $t4, $zero,$zero
#li $v0, 11
#print:
#beq $t4, $t3, e
#lb $a0, sWord($t4)
#syscall
#addi $t4,$t4,1
#b print
e:
li $v0, 10
syscall
resetCount:
li $s7, 7
b initPowerloop
# END OF PROGRAM