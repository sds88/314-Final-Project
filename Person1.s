# EECS 314 Final Project
# Sam Schneider
	.globl main
main:		# Start of code section
	addu $s7, $zero, $ra

.data	# Data declaration section

str1: .asciiz "\nInput the prime number: "
str2: .asciiz "\nInput the root a: "
str3: .asciiz "\nInput k1: "
str5: .asciiz "\na^k1 % p = "
str7: .asciiz "\n(a^k1)^k2 % p = "

# $s0 = p
# $s1 = a
# $s2 = k1
# $t0 = a^k1
# $s3 = $t0 % p
# $t2 = k1 = n for loop
.text
	#Print str1, read an integer (p), store it into $s0
	li $v0, 4	# 4 = print_string
	la $a0, str1
	syscall
	li $v0, 5	# 5 = read_int
	syscall
	add $s0, $v0, $zero
	
	#print str2, read an integer (a), store it into $s1
	li $v0, 4
	la $a0, str2
	syscall
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	
	#print str3, read an integer (k1), store it into $s2
	li $v0, 4
	la $a0, str3
	syscall
	li $v0, 5
	syscall
	add $s2, $v0, $zero
	
	#compute "a^k1", store into $t0, compute $t0 % p, store into $s3, print str5, print $s3
	#code to compute a^k1 = $t0 here
	
	#mul $t0, $s0, $s1	#temp code
	#addi $t0, $t0, 69	#to test $t0 % p
	
	div $t0, $s0	#stores the remander into HI ($t0 % $s0 = HI)
	mfhi $s3
	li $v0, 4
	la $a0, str5
	syscall
	li $v0, 1
	add $a0, $s3, $zero
	syscall
	#compute "$t0^k2", store into $t2, compute $t2 % p, store into $s3, print str7, print $s3
	
	
	#Crap that is needed to end main
	addu $ra, $zero, $s7
	jr $ra
	add $zero, $zero, $zero
.end
# END OF PROGRAM