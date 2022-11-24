.data 
	array: .space 20
	input: .asciiz "Input:"
	output: .asciiz  "Output:"
	space: .asciiz " "
	
.text
	addi $t0,$zero,0 # offset added on the address/index of while loop
	la $a0,input 
	
	firstWhile:
		beq $t0,20,firstExit
		li $v0,4
		syscall
		li $v0,5 # read integer
		syscall
		move $t2,$v0 # move the data from user input o register
		sw $t2,array($t0) # array--RAM address offset  
		addi $t0,$t0,4 # update offset added on the address for the next round/index of while loop
		j firstWhile   

	firstExit:
		addi $t0,$zero,0 
		la $a0,output
		li $v0,4
		syscall
		
		secondWhile:
			beq $t0,20,secondExit
			lw $t2,array($t0) # load array[index($t0)] to register
			addi $t0,$t0,4
			
			li $v0,1
			move $a0,$t2
			syscall
			
			li $v0,4
			la $a0,space
			syscall
			
			j secondWhile	
		
	secondExit:
		li $v0,10
		syscall
	
	
	
