.data
    # Define the matrices A, B, and C
    matrixA:        .space 36   # 3x3 matrix, 9 words
    matrixB:        .space 36   # 3x3 matrix, 9 words
    matrixC:        .space 36   # 3x3 matrix, 9 words
    input_prompt_A: .asciiz "Enter values for matrix A (3x3):\n"
    input_prompt_B: .asciiz "Enter values for matrix B (3x3):\n"
    output_prompt:  .asciiz "Result matrix C (3x3):\n"
    space:          .asciiz " "

.text
    .globl main

main:
    # Initialize matrix C to zeros
    li $t3, 0   # Initialize loop counter for initialization
    la $a2, matrixC   # Load address of matrixC into $a2

init_loop:
    sw $t3, 0($a2)    # Store 0 in the next element of matrix C
    addi $a2, $a2, 4  # Move to the next element
    addi $t3, $t3, 1  # Increment loop counter
    bne $t3, 9, init_loop

    # Prompt the user to input matrix A
    li $v0, 4
    la $a0, input_prompt_A
    syscall

    # Read values for matrix A from the user
    la $a0, matrixA
    li $a1, 36  # Number of bytes to read (3x3 matrix)
    li $v0, 8   # Read string
    syscall

    # Prompt the user to input matrix B
    li $v0, 4
    la $a0, input_prompt_B
    syscall

    # Read values for matrix B from the user
    la $a0, matrixB
    li $a1, 36  # Number of bytes to read (3x3 matrix)
    li $v0, 8   # Read string
    syscall

    # Initialize registers
    la $a0, matrixA   # Load address of matrixA into $a0
    la $a1, matrixB   # Load address of matrixB into $a1
    la $a2, matrixC   # Load address of matrixC into $a2

    # Initialize loop counters for matrix multiplication
    li $t0, 3   # Outer loop counter (rows of A)
    li $t1, 3   # Middle loop counter (columns of B)
    li $t2, 3   # Inner loop counter (columns of A and rows of B)

    # Matrix multiplication loop
    outer_loop:
        # Middle loop (j-loop): Loop over columns of B
        move $t1, $t2   # Reset j-loop counter to initial value of inner loop
        j middle_loop_check

        middle_loop:
            # Inner loop (k-loop): Loop over columns of A and rows of B
            li $t4, 0   # Initialize the k-loop counter

            # Load A[i][k] and B[k][j]
            lw $t5, 0($a0)  # Load A[i][k]
            lw $t6, 0($a1)  # Load B[k][j]

            # Multiply A[i][k] by B[k][j] and accumulate
            mult $t5, $t6
            mflo $t7         # Get the low 32 bits of the result
            add $t3, $t3, $t7

            # Update pointers
            addi $a0, $a0, 4  # Move to the next column of A
            addi $a1, $a1, 4  # Move to the next row of B

            # Check if k-loop is done
            addi $t4, $t4, 1  # Increment k-loop counter
            bne $t4, $t2, middle_loop

            # Store the result in C[i][j]
            sw $t3, 0($a2)

            # Update pointers and counters
            addi $a2, $a2, 4  # Move to the next column of C
            addi $t1, $t1, 1  # Increment j-loop counter

        middle_loop_check:
            # Check if j-loop is done
            bne $t1, $t2, middle_loop

        # Update pointers and counters for outer loop
        addi $a0, $a0, -12  # Move back to the first column of A in the current row
        addi $a1, $a1, 12   # Move to the next row of B
        addi $a2, $a2, -12  # Move back to the first column of C in the current row
        addi $t0, $t0, -1   # Decrement i-loop counter

        # Check if i-loop is done
        bnez $t0, outer_loop

    # Display the result matrix C
    li $v0, 4
    la $a0, output_prompt
    syscall

    # Loop to print the elements of matrix C
    la $a0, matrixC
    li $t0, 9   # Number of elements in the matrix
    li $t1, 0   # Loop counter

    print_loop:
        lw $a1, 0($a0)  # Load the next element of matrix C
        li $v0, 1       # Print integer
        move $a0, $a1
        syscall

        addi $a0, $a0, 4  # Move to the next element
        addi $t1, $t1, 1  # Increment loop counter

        # Check if we've printed all elements
        beq $t1, $t0, print_done

        # Print a space between elements
        li $v0, 4
        la $a0, space
        syscall

        j print_loop

    print_done:
        # Exit the program
        li $v0, 10   # Exit code
        syscall
