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
move 	$t0, $t4		# $t0 <- $t4


jal		print_input_starting_address  
jal     get_input_int
move 	$t0, $t4		# $t1 <- $t4



jal		print_output_starting_adress 
jal     get_input_int
move 	$t0, $t4		# $t2 <- $t4



move    $t8, $t1     # temporily store t1 -> t8
move    $s0, $zero	# loop vairable (i)  -> s0

loop1:  beq $s0, $t0, loop1end

	    jal print_enter_int_from_user
	    jal get_input_int
        # store user inputs to an array starting from t2
	    sw $t4, 0($t1)

	    addi $t1, $t1, 4      # updating t1 to have t1+4 value
      	addi $s0, $s0, 1      # s0 ++
        j loop1               # jump to top

loop1end: move $t1, $t8  # t1's value restored from t8  



# Bubble Sort
        move    $s1, $t0  # $s1 <- N (number of elements)
        move    $t8, $t1
        li      $s2, 1    # $s2 <- swap flag is 1

sort_loop:
        # If swap flag is 0, the array is sorted
        # s2 == 0 --> jump to sorted
        beqz    $s2, sorted  

        li      $s2, 0       # Reset swap flag to 0 (false)
        move    $s0, $zero   # Reset loop variable (i) to 0

inner_loop:
    beq     $s0, $s1, sort_loop  # If i == N, go to the outer loop

    # Load A[i] and A[i+1]
    lw      $t3, 0($t1)
    lw      $t4, 4($t1)

    # A[i] <= A[i+1] => no swap
    ble     $t3, $t4, no_swap

    # Swap A[i] and A[i+1]
    sw      $t4, 0($t1)
    sw      $t3, 4($t1)

    # Set swap flag to 1 => Not Sorted
    li      $s2, 1

no_swap:
    addi    $t1, $t1, 4  # Move to the next element
    addi    $s0, $s0, 1  # Increment loop counter
    j       inner_loop    # Repeat inner loop



sorted:
    # Print the sorted integers
    move    $t1, $t8  # Restore $t1's value from $t8
    li      $s0, 0    # Reset loop variable (i) to 0

print_sorted_loop:
    beq     $s0, $t0, done  # If i == N, exit

    # Load and print the integer at address $t1
    lw      $t4, 0($t1)
    jal     print_int
    jal     print_line

    addi    $t1, $t1, 4  # Move to the next element
    addi    $s0, $s0, 1  # Increment loop counter
    j       print_sorted_loop  # Repeat print loop

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








