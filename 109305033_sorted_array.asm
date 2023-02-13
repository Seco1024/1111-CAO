.data
	array1: .space 20
	array2: .space 20
	array3: .space 40
	input1: .asciiz "Input sorted array 1 one by one:"
	input2: .asciiz "Input sorted array 2 one by one:"
	output: .asciiz "New sorted array:"
	space: .asciiz " "

.text
main:
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	la $a0, input1
	
inputArray1:  #使用者輸入第一個陣列
	beq $t0, 20, inputArray2  #若輸入完成，跳至輸入第二個陣列
	li $v0, 4
	syscall   #輸出指示
	li $v0, 5
	syscall   #輸入整數
	sw $v0, array1($t0)  #將輸入的整數存入memory的陣列中
	addi $t0, $t0, 4  
	j inputArray1  #繼續迴圈
	
inputArray2:
	la $a0, input2  #設定指示字串
	beq $t1, 20, end1  #若輸入完成，跳出迴圈
	li $v0, 4
	syscall   #輸出指示
	li $v0, 5
	syscall   #輸入整數
	sw $v0, array2($t1)  #將輸入的整數存入memory的陣列中
	addi $t1, $t1, 4
	j inputArray2  #繼續迴圈
	
end1:
	li $t0, 0
	li $t1, 0
	li $t2, 0

loop:  #比較兩陣列大小
	beq $t2, 40, end2   #若目標陣列滿了，離開迴圈
	beq $t0, 20, copy2  #若第一個陣列的指標先掃完整個陣列了，跳到copy2
	beq $t1, 20, copy1  #若第一個陣列的指標先掃完整個陣列了，跳到copy1
	lw $s0, array1($t0)  #把第一個陣列指標指向的數值載入暫存器
	lw $s1, array2($t1)  #把第二個陣列指標指向的數值載入暫存器
	slt $t3, $s0, $s1  #比較指標
	beq $t3, 1, store1  #若第一個陣列指標指向的數值較小就跳至 store1。若非，繼續
	
	sw $s1, array3($t2)  #將第二個指標指向的數值存到新陣列
	addi $t1, $t1, 4  #往後移動第二個陣列的指標
	addi $t2, $t2, 4  #往後移動目標陣列的指標
	j loop  #繼續迴圈
	
store1:
	sw $s0, array3($t2)  #將第一個指標指向的數值存到新陣列
	addi $t0, $t0, 4  #往後移動第一個陣列的指標
	addi $t2, $t2, 4  #往後移動目標陣列的指標
	j loop  #繼續迴圈
	
copy1:
	lw $s0, array1($t0)  #把第一個陣列指標指向的數值載入暫存器
	sw $s0, array3($t2)  #將第一個指標指向的數值存到新陣列
	addi $t0, $t0, 4  #往後移動第一個陣列的指標
	addi $t2, $t2, 4  #往後移動目標陣列的指標
	bne $t0, 20, copy1  #若還沒填滿，繼續迴圈
	j end2
	
copy2:
	lw $s1, array2($t1)  #把第一個陣列指標指向的數值載入暫存器
	sw $s1, array3($t2)  #將第一個指標指向的數值存到新陣列
	addi $t1, $t1, 4  #往後移動第一個陣列的指標
	addi $t2, $t2, 4  #往後移動目標陣列的指標
	bne $t1, 20, copy2  #若還沒填滿，繼續迴圈
	j end2
	
end2:
	la $a0, output  
	li $v0, 4  
	syscall   #輸出指示
	li $t0, 0
	
outputFunc:
	beq $t0, 40, exit  #若掃完目標陣列，結束迴圈
	lw $t4, array3($t0)   #以下就是依序輸出目標陣列的數值
	addu $a0, $zero, $t4
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	  
	addi $t0, $t0, 4  #移動指標往下掃
	j outputFunc  #繼續迴圈

exit:
	li $v0, 10
	syscall  #結束程式
