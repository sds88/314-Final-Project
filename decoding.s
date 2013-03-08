# UNTITLED PROGRAM

	.data	# Data declaration section
	sWord: .space 200
wordString: .asciiz "Enter the string to be decoded: "
key:   .asciiz "\nEnter a key :"
	.text

main:		# Start of code section

getWord:
li $v0,4
la $a0, wordString
syscall
li $v0, 8
la $a0, sWord
li $a1, 201
syscall
move $t7, $a0
la $a0, sWord
li $v0,4
syscall

add $t4, $zero,$zero
calcSize:
lb $t2, sWord($t4)
beq $t2, $zero, getKey
addi $t3, $t3, 1
addi $t4,$t4,1
b calcSize

getKey:
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
li $s2, 2
li $s3, 2
powerloop:
beq $t5, $zero, initAddBits
mult $s2,$s3
mflo $s2
addi $t5,$t5, -1
b powerloop

initAddBits:
add $t4, $zero,$zero
addi $t3, $t3, -1
addBits:
beq $t5,$t3,printInit
lb $s4, sWord($t4)
xor $s5, $s2, $s4
sb $s5, sWord($t4)

addi $t5, $t5, 1
addi $t4, $t4, 1
b addBits

printInit:
add $t4, $zero,$zero
li $v0, 11
print:
beq $t4, $t3, e
lb $a0, sWord($t4)
syscall
addi $t4,$t4,1
b print
e:
li $v0, 10
syscall
# END OF PROGRAM