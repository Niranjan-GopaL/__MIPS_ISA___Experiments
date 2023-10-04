# data that we need to have in random access memory
.data
	next_line:              .asciiz   "\n"
	inp_statement:          .asciiz   "Enter No. of integers to be taken as input: "
	inp_int_statement:      .asciiz   "Enter starting address of inputs(in decimal format): "
	out_int_statement:      .asciiz   "Enter starting address of outputs (in decimal format): "
	enter_int:              .asciiz   "Enter the integer: "

.text



# conventions being followed :-
# N ( number of inputs )         -> t0 
# input start address            -> t1
# output start address           -> t2


jal		print_no_of_inputs  
jal     get_input_int
move 	$t0, $t4		        # $t0 <- $t4


jal		print_input_starting_address  
jal     get_input_int
move 	$t1, $t4		        # $t1 <- $t4


jal		print_output_starting_adress 
jal     get_input_int
move 	$t2, $t4		        # $t2 <- $t4



move    $t8, $t1                # temporily store t1 -> t8
move    $t7, $t2                # temporily store t2 -> t7
move    $s0, $zero	            # loop vairable (i)  -> s0

loop1:  
        beq $s0, $t0, loop1end # 

	    jal print_enter_int_from_user
	    jal get_input_int
        # store user inputs to an array starting from t1
	    sw $t4, 0($t1)
	    sw $t4, 0($t2)

	    addi $t1, $t1, 4        # updating t1 to have t1 + 4 value
	    addi $t2, $t2, 4        # updating t2 to have t2 + 4 value
      	addi $s0, $s0, 1        # s0++
        j loop1                 # jump to top

loop1end: 
        move $t1, $t8           # t1'    value restored from t8  
        move $t2, $t7           # t1's value restored from t8  






#     for i: 1 -> n-1
#         for j: 0 -> (n-1)-i
#             if( A[j] > A[j+1] ) swap( A[j], A[j+1] )
#     
#     
#     after every i iteration of outer loop;
#     (i+1)th  largest number will be at its proper position




# Bubble sort

# s0 <- outer_loop variable
# s1 <- inner_loop variable

# outer loop initialisation
li      $s0,  0		
addi	$t5, $t2, 0			        # t5  <- temp_t2 

outer_loop:
    addi    $s0, $s0, 1             # i++
    addi    $t2, $t5, 0             # restoring t2 back to start of array

    # this is used rather loosely in-order to help in print_sorted_loop
    li	    $s1, 0		            # j = 0

    beq     $s0, $t0, print_sorted_loop

    # inner loop initialisation
    li	    $s1, 0		            # j = 0
    sub		$t3, $t0, $s0		    # $t3 <- N - i    ( you can do this using one register)

    inner_loop:
    beq     $s1, $t3, outer_loop    # j == N - i go to outer lopp

    lw      $s3, 0($t2)             # s3 <- M[ t2 ]
    lw      $s4, 4($t2)             # s4 <- M[t2+4]

    ble		$s3, $s4, no_swap       # Only if A[j] > A[j+1] we'll swap

    # swapping
    sw		$s3, 4($t2)		        # s3 -> M[t2+4]
    sw		$s4, 0($t2)		        # s4 -> M[ t2 ] 

    no_swap:
    addi     $s1, $s1, 1            # j++
    addi     $t2, $t2, 4            # t2 += 4
    j		inner_loop				# next iteration of inner loop


print_sorted_loop:
        beq     $s1, $t0, done      # If i == N, exit

        # Load and print the integer at address $t1
        lw      $t4, 0($t2)
        jal     print_int
        jal     print_line

        addi    $t2, $t2, 4         # t2 += 4
        addi    $s1, $s1, 1         # i++
        j       print_sorted_loop   

done:
        # Exit the program
        li      $v0, 10
        syscall
















#input from command line(takes input and stores it in $t6)
get_input_int: 
        li $v0,5
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
print_no_of_inputs: li $v0,4
		la $a0,inp_statement
		syscall 
		jr $ra

print_input_starting_address: li $v0,4
		la $a0,inp_int_statement
		syscall 
		jr $ra

print_output_starting_adress: li $v0,4
		la $a0,out_int_statement
		syscall 
		jr $ra

#print enter integer statement
print_enter_int_from_user: li $v0,4
		la $a0,enter_int
		syscall 
		jr $ra

