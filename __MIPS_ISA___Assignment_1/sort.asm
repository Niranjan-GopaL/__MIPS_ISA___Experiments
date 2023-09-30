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
move    $s0, $zero	            # loop vairable (i)  -> s0

loop1:  
        beq $s0, $t0, loop1end

	    jal print_enter_int_from_user
	    jal get_input_int
        # store user inputs to an array starting from t1
	    sw $t4, 0($t1)

	    addi $t1, $t1, 4        # updating t1 to have t1 + 4 value
      	addi $s0, $s0, 1        # s0++
        j loop1                 # jump to top

loop1end: 
        move $t1, $t8           # t1's value restored from t8  






#     for i: 0 -> n
#         for j: 0 -> (n-i)-1
#             if( A[j] > A[j+1] ) swap( A[j], A[j+1] )
#     
#     
#     after every iteration of inner loop;
#     (i+1)th  largest number will be at its proper position



#    $t1 <----- stores StartingAddress for input
#    
#    M[t1  ] = first  input
#    M[t1+4] = second input
#    M[t1+8] = third  input
#    
#    M[26850128] = 4
#    M[26850132] = 1
#    M[26850136] = 2
#    and so on ...
#    
#    
#    => EVERYTHING IS ZERO INDEXED 







# Bubble sort

# just code; debug later

# i <- s0 <- outer_loop variable
# j <- s1 <- inner_loop variable



# outer loop initialisation
li      $s0,  -1		
addi	$t6, $t0, -1			    # $t6 <- N - 1


outer_loop:
    addi    $s0, $s0, 1             # i++
    beq     $s0, $t6, loop_to_populate_output

    # inner loop initialisation
    li	    $s1, 0		            # j = 0
    sub		$t3, $t6, $s0		    # $t3 <- N-1 - i    ( you can do this using one register)

    inner_loop:
    beq     $s1, $t3, outer_loop    # j == N - i go to outer lopp


    lw      $s3, 0($t1)             # A[j]
    lw      $s4, 4($t1)             # A[j+1]


    ble		$s3, $s4, no_swap       # Only if A[j] > A[j+1] we'll swap

    # swapping
    move    $t7, $s4
    move    $s4, $s3
    move    $s3, $t7

    no_swap:
    addi     $s1, $s1, 1            # j++
    j		inner_loop				# next iteration of inner loop


loop_to_populate_output:  
        beq $s0, $t0, print_sorted_loop

	    sw   $t1, 0($t2)

	    addi $t1, $t1, 4            # updating t1 to have t1 + 4 value
	    addi $t2, $t2, 4            # updating t2 to have t2 + 4 value
      	addi $s0, $s0, 1            # s0++
        j loop_to_populate_output   # jump to top



print_sorted_loop:
        li		$s0, 0		 
        beq     $s0, $t0, done  # If i == N, exit

        # Load and print the integer at address $t1
        lw      $t4, 0($t2)
        jal     print_int
        jal     print_line

        addi    $t2, $t2, 4         # Move to the next element
        addi    $s0, $s0, 1         # Increment loop counter
        j       print_sorted_loop   # Repeat print loop

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

