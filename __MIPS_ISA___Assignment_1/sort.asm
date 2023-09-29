.data
	next_line:         .asciiz   "\n"
	inp_statement:     .asciiz   "Enter No. of integers to be taken as input: "
	inp_int_statement: .asciiz   "Enter starting address of inputs(in decimal format): "
	out_int_statement: .asciiz   "Enter starting address of outputs (in decimal format): "
	enter_int:         .asciiz   "Enter the integer: "


.text

# conventions being followed 
# N ( number of inputs )         -> t0 
# input start address            -> t1
# output start address           -> t2







#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra

#print integer(prints the value of $t6 )
print_int: li $v0,1	
	   move $a0,$t4
	   syscall
	   jr $ra

#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra

#print number of inputs statement
print_inp_statement: li $v0,4
		la $a0,inp_statement
		syscall 
		jr $ra
#print input address statement
print_inp_int_statement: li $v0,4
		la $a0,inp_int_statement
		syscall 
		jr $ra
#print output address statement
print_out_int_statement: li $v0,4
		la $a0,out_int_statement
		syscall 
		jr $ra
#print enter integer statement
print_enter_int: li $v0,4
		la $a0,enter_int
		syscall 
		jr $ra








