.data
	input: .asciiz "Input a number:"
	output: .asciiz "The Quadribonacci sequence is  "
	
.text
main:
	li $v0, 4
	la $a0, input 
	syscall  #輸出指示
	li $v0, 5
	syscall  #讀取輸入
	add $a0, $v0, $zero  #將輸入存到暫存器
	li $v0, 0  #初始化$v0
	li $t2, 0  #初始化$t2
	jal qua  #跳到 qua function
	j exit #跳到exit

qua:
	addi $sp, $sp, -8  #移動$sp將下面的參數存到stack中
	sw $ra, 0($sp)     #將caller返回的位址存到stack中
	sw $a0, 4($sp)     #將caller傳入的引數存到stack中
	slti $t0, $a0, 4   #如果引數小於4，則$t0=1，反之則$t0=0
	beq $t0, $zero, L1 #如果引數大於4，跳到L1，如果沒有就繼續
	
	slt $t1, $t2, $a0   #如果引數大於0，設$t1=1，反之則$t1=0
	add $v0, $v0, $t1   #加總結果
	
	addi $sp, $sp, 8    #還原stack
	jr $ra   #返回caller位址
	

L1:
	addi $a0, $a0, -1  # n = n-1
	jal qua   # quadribonacci 函式 Q(n-1).
	addi $a0, $a0, -1  #n = n-2
	jal qua   # quadribonacci 函式 Q(n-2)
	addi $a0, $a0, -1  # n = n-3
	jal qua   # quadribonacci 函式 Q(n-3)
	addi $a0, $a0, -1  #n = n-4
	jal qua   # quadribonacci 函式 Q(n-4)
	lw $a0, 4($sp)  #取得原引數
	lw $ra, 0($sp)  #取得原caller返回位址
	addi $sp, $sp, 8  #還原stack
	jr $ra  #返回caller位址

exit:
	move $s1, $v0  
	li $v0, 4
	la $a0, output  
	syscall  #輸出提示
	li $v0, 1  
	move $a0, $s1  #將答案放入輸出引數暫存器
	syscall  #輸出答案
	li $v0, 10
	syscall  #結束程式
	
	
