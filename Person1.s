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
str8: .asciiz "\n Floating point test:\n"

# $s0 = p = $f0
# $s1 = a = $f1
# $s2 = k1 = $f2
# $f3 = a^k1
# $f7 = a^k1 % p
# $t0 = k1 = n for loop
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
	
	#convert p, a, k1 to floating point numbers
	mtc1 $s0, $f0
	cvt.s.w $f0, $f0
	mtc1 $s1, $f1
	cvt.s.w $f1, $f1
	mtc1 $s2, $f2
	cvt.s.w $f2, $f2
	
	#compute "a^k1", store into $f3
	addi $t0, $s2, -2
	mul.s $f3, $f1, $f1
powerLoop:
	beqz $t0 powerComplete
	mul.s $f3, $f1, $f3
	addi $t0, $t0, -1
	b powerLoop
powerComplete:
	#compute $f3 % p by doing $f3 - p * floor($f3/p), store it into $f7, print str5 and $f7
	div.s $f4, $f3, $f0
	cvt.w.s $f5, $f4	#Converting $f5 to an integer, than back to a float
	mfc1 $t0,$f5		#inorder to get rid of decimal
	mtc1 $t0, $f5
	cvt.s.w $f5, $f5	#$f5 = floor($f3/p)
	
	mul.s $f6, $f0, $f5
	sub.s $f7, $f3, $f6	#$f7 = a^k1 % p
	
	li $v0, 4
	la $a0, str5
	syscall
	li $v0, 2
	mov.s $f12, $f7
	syscall
	
	
	#Crap that is needed to end main
	addu $ra, $zero, $s7
	jr $ra
	add $zero, $zero, $zero
.end
# END OF PROGRAM