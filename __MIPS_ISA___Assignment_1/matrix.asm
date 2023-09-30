# data that we need to have in random access memory
.data
	next_line:              .asciiz   "\n"
	inp_statement:          .asciiz   "Enter No. of integers to be taken as input: "
	inp_int_statement:      .asciiz   "Enter starting address of inputs(in decimal format): "
	out_int_statement:      .asciiz   "Enter starting address of outputs (in decimal format): "
	enter_int:              .asciiz   "Enter the integer: "


.text


# conventions being followed :-
# N ( Order of matrix  )         -> t0
# t0 = t0 * t0 * t0   

# input start address            -> t1
# output start address           -> t2


jal		print_no_of_inputs  
jal     get_input_int
mult	$t0, $t1			# $t0 * $t1 = Hi and Lo registers
mflo	$t2					# copy Lo to $t2

move 	$t0, $t4		# $t0 <- $t4


jal		print_input_starting_address  
jal     get_input_int
move 	$t1, $t4		# $t1 <- $t4



jal		print_output_starting_adress 
jal     get_input_int
move 	$t2, $t4		# $t2 <- $t4



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






