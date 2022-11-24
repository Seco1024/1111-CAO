.data
	array: .space 40
	input: .asciiz "Input:"
	output: .asciiz "Reverse Order:"
	min: .asciiz "Min:"
	max: .asciiz "Max:"
	sum: .asciiz "Sum:"
	space: .asciiz " "
	
.text
main: #主程式開始
	addi $t0, $zero, 0
	la $a0, input
	
inputArray:
	beq $t0, 40, end1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, array($t0)
	addi $t0, $t0, 4
	j inputArray
	
end1:
	la $a0, output
	li $v0, 4
	syscall
	li $s0, 0
	li $s1, 2147483647
	li $s2, -2147483648
	
outputReversed:
	beq $t0, 0, end2
	subi $t0, $t0, 4
	lw $t1 array($t0)  #取得數字
	
	addu $a0,$zero, $t1  #列印數字
	li $v0, 1 
	syscall
	
	add $s0, $s0, $t1  # 加總
	
	addi $sp, $sp, -8  
	sw $t0, 0($sp) # caller 存取 $t0
	sw $t1, 4($sp) # caller 存取 $t1

	move $a1, $s1 # 傳入目前最小值參數
	jal minFunction # call Min
	move $s1, $v0 # 取得此輪最小值結果
	lw $a0, 4($sp) # restore $a0
	move $a1, $s2 # 傳入目前最大值參數
	jal maxFunction # call Max
	move $s2, $v0 #取得此輪最大值參數
	
	lw $t0, 0($sp) # caller restore $t0
	addi $sp, $sp, 8
	
	li $v0, 4
	la $a0, space
	syscall
	j outputReversed
	
end2:
	la $a0, sum 
	li $v0, 4
	syscall
	
	add $a0, $s0, $zero  # 列印加總
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, space 
	syscall
	la $a0, min
	syscall
	
	add $a0, $s1, $zero
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, space 
	syscall
	la $a0, max
	syscall
	
	add $a0, $s2, $zero
	li $v0, 1
	syscall
	
	li $v0,10  # 結束
	syscall
	
minFunction:
	slt $t0, $a0, $a1
	beq $t0, 1, functionExit
	move $a0, $a1
	j functionExit
	
maxFunction:
	slt $t0, $a1, $a0
	beq $t0, 1, functionExit
	move $a0, $a1
	j functionExit
	
functionExit:
	move $v0, $a0
	jr $ra
	

	  


	

	
	
	
	
	
		
	
		
	
