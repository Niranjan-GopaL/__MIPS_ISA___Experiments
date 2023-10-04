# data that we need to have in random access memory
.data
	next_line:                           .asciiz   "\n"
	matrix_order_inp_statement:          .asciiz   "Enter order of matrix: "
	inp_matrix_A_statement:              .asciiz   "Enter starting address of Matrix A (in decimal format)      : "
	inp_matrix_B_statement:              .asciiz   "Enter starting address of Matrix B (in decimal format)      : "
	inp_matrix_C_statement:              .asciiz   "Enter starting address of output matrix (in decimal format) : "
	enter_int:                           .asciiz   "Enter the integer: "
    inp_enter_matrix_A:                  .asciiz   "------ INPUTS FOR MATRIX A -----"
    inp_enter_matrix_B:                  .asciiz   "------ INPUTS FOR MATRIX B -----"
    inp_enter_matrix_output:             .asciiz   "------ OUTPUT MATRIX C  -----"


.text


# the conventions and logic used would be best understood 
# by comparing it with it's python counterpart



# conventions being followed :-
# N ( Order of matrix  )           -> t0
# N*N                              -> t1 

# Matrix A start address           -> t5
# Matrix B start address           -> t6
# Matrix C start address           -> t7


jal		print_order_of_square_matrix  
jal     get_input_int
move 	$t0, $t4		# $t0 (N)   <-- $t4
mul     $t1, $t0, $t0   # $t1 (N*N) <-- $t0 * $t0


jal		print_matrix_A_starting_address
jal     get_input_int
move 	$t5, $t4		# $t5 <- $t4


jal		print_matrix_B_starting_adress 
jal     get_input_int
move 	$t6, $t4		# $t6 <- $t4


jal		print_matrix_C_starting_adress 
jal     get_input_int
move 	$t7, $t4		# $t7 <- $t4




#jal     print_line
jal     print_line
jal     enter_matrix_A
jal     print_line
#jal     print_line

move    $t8, $t5       # temporily store t5 -> t8
move    $s0, $zero	   # loop vairable (i)  -> s0

# get N*N inputs for matrix A
loop1:  beq $s0, $t1, loop1end

	    jal print_enter_int_from_user
	    jal get_input_int
        # store user inputs to an array starting from t5
	    sw $t4, 0($t5)

	    addi $t5, $t5, 4      # updating t5 to have t5+4 value
      	addi $s0, $s0, 1      # s0 ++
        j loop1               # jump to top

loop1end: move $t5, $t8  # t5's value restored from t8  




#jal     print_line
jal     print_line
jal     enter_matrix_B
jal     print_line
#jal     print_line

move    $t8, $t6       # temporily store t6 -> t8
move    $s0, $zero	   # loop vairable (i)  -> s0

# get N*N inputs for matrix B
loop2:  beq $s0, $t1, loop2end

	    jal print_enter_int_from_user
	    jal get_input_int
        # store user inputs to an array starting from t6
	    sw $t4, 0($t6)

	    addi $t6, $t6, 4      # updating t6 to have t6+4 value
      	addi $s0, $s0, 1      # s0 ++
        j loop2               # jump to top

loop2end: move $t6, $t8  # t6's value restored from t8  







# matrix multiplication

# t0, t1, t4, t5,t6,t7   used 


# row_offset  -> s3 
# clm_offset  -> s4

li		$s0, -1		        # $s0 -> 0  ( k )
li		$s3, 0		        # $s3 -> 0  (row_offset)
li		$s4, 0		        # $s4 -> 0  (clm_offset)
addi	$t3, $zero, 4	    # $t3 = 4
move    $t8, $t7            # temporarily sotring matrix C's address



outer_loop: 

addi	$s0, $s0, 1			# k++

beq		$s0, $t1, FUCKING_DONE_init__


divu    $t2, $s0, $t0
mfhi    $t2                 # $t2 <- Remainder

beq		$s0, $zero, inner_loop_init__
bne     $t2, $zero, inner_loop_init__

addi	$s3, $s3, 1			# s3++ ( row offset++)
li		$s4, 0	            # resetting the column offset 


inner_loop_init__:
li		$s1, 0		        # $s1 <- 0 
li      $t2, 0              # accumulator C[k]

inner_loop:

beq		$s1, $t0, outside_inner_loop	# if j == N then go outside inner_loop


# generating offsets for matrix A and matrix B

mul     $s7, $s3, $t0
add     $s7, $s7, $s1       # s7 <- index of matrix A

mul     $s6, $s1, $t0
add     $s6, $s6, $s4       # s6 <- index of matrix B


# you have to multiply the index by 4 to get exact offsets 
mul     $s6, $s6, $t3
mul     $s7, $s7, $t3


add     $s7, $s7, $t5       # s7 <- mem address of exact number in matrix A
add     $s6, $s6, $t6       # s6 <- mem address of exact number in matrix B


# A[S7]   B[s6] 
lw		$s6, 0($s6)		    
lw		$s7, 0($s7)		    

# s6 is the result of their multiplication
mul     $s6, $s6, $s7

# Cumulatively summing up
add     $t2, $t2, $s6       # C[k] += s6
addi	$s1, $s1, 1			# j++ 


j		inner_loop			# jump to inner_loop



outside_inner_loop:

# C[k] = A[row_offset*N + j] * B[clm_offset + j*N]
sw		$t2, 0($t7)

addi	$t7, $t7, 4			# moving to next address of matrix C to fill
addi	$s4, $s4, 1			# s4++ ( column offset++)

j       outer_loop




FUCKING_DONE_init__:
li		$s1, 0		
move    $t7, $t8

#jal     print_line
jal     print_line
jal     enter_matrix_output
jal     print_line
#jal     print_line



FUCKING_DONE:
        beq     $s1, $t1, done      # If i == N, exit

        # Load and print the integer at address $t1
        lw      $t4, 0($t7)
        jal     print_int
        jal     print_line

        addi    $t7, $t7, 4         # t7 += 4
        addi    $s1, $s1, 1         # i++
        j       FUCKING_DONE   

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
print_order_of_square_matrix: li $v0,4
		la $a0,matrix_order_inp_statement
		syscall 
		jr $ra

print_matrix_A_starting_address: li $v0,4
		la $a0,inp_matrix_A_statement
		syscall 
		jr $ra

print_matrix_B_starting_adress: li $v0,4
		la $a0,inp_matrix_B_statement
		syscall 
		jr $ra

print_matrix_C_starting_adress: li $v0,4
		la $a0,inp_matrix_C_statement
		syscall 
		jr $ra

#print enter integer statement
print_enter_int_from_user: li $v0,4
		la $a0,enter_int
		syscall 
		jr $ra


enter_matrix_A: li $v0,4
		la $a0, inp_enter_matrix_A
		syscall 
		jr $ra

enter_matrix_B: li $v0,4
		la $a0, inp_enter_matrix_B
		syscall 
		jr $ra


enter_matrix_output: li $v0,4
		la $a0, inp_enter_matrix_output
		syscall 
		jr $ra