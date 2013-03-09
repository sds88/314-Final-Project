# EECS 314 Final Project
# Sam Schneider
	.globl main
main:		# Start of code section
	addu $s7, $zero, $ra

.data	# Data declaration section

str1: .asciiz "\nInput the prime number: "
str2: .asciiz "\nInput the root a: "
str3: .asciiz "\nInput k1: "
str6: .asciiz "\nGive this number to person 1: "
str7: .asciiz "\nInput the number given to you by person 1: "
str8: .asciiz "\nKey = "

# $s0 = p = $f2
# $s1 = a = $f1
# $s2 = k1
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
	mtc1 $s0, $f2
	cvt.s.w $f2, $f2
	mtc1 $s1, $f1
	cvt.s.w $f1, $f1
	
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
	div.s $f4, $f3, $f2
	cvt.w.s $f5, $f4	#Converting $f5 to an integer, than back to a float
	mfc1 $t0,$f5		#inorder to get rid of decimal
	mtc1 $t0, $f5
	cvt.s.w $f5, $f5	#$f5 = floor($f3/p)
	
	mul.s $f6, $f2, $f5
	sub.s $f7, $f3, $f6	#$f7 = a^k1 % p
	
	li $v0, 4
	la $a0, str6
	syscall
	li $v0, 2
	mov.s $f12, $f7
	syscall
	
	#get a^k2 % p from second person
	li $v0, 4
	la $a0, str7
	syscall
	li $v0, 6
	syscall			#$f0 is now a^k2 % p
	
	#compute $f0^k1
	addi $t0, $s2, -2
	mul.s $f14, $f0, $f0
powerLoop2:
	beqz $t0 powerComplete2
	mul.s $f14, $f0, $f14
	addi $t0, $t0, -1
	b powerLoop2
powerComplete2:
	#compute $f14 % p by doing $f14 - p * floor($f14/p), store it into $f18, print str8 and $f18
	div.s $f15, $f14, $f2
	cvt.w.s $f16, $f15
	mfc1 $t0, $f16
	mtc1 $t0, $f15
	cvt.s.w $f16, $f16
	
	mul.s $f17, $f2, $f16
	sub.s $f18, $f14, $f17	#f18 is now the key!
	
	li $v0, 4
	la $a0, str8
	syscall
	li $v0, 2
	mov.s $f12, $f18
	syscall

	#Crap that is needed to end main
	addu $ra, $zero, $s7
	jr $ra
	add $zero, $zero, $zero
.end
# END OF PROGRAM