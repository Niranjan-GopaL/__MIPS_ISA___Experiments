# Using dictionary for encoding instructions to opcode (binary)
instruction_encoding = {
    'addi': '001000',
    'beq': '000100',
    'ble': '000110',
    'jal': '000011',
    'jr': '001000',
    'li': '001001',
    'lw': '100011',
    'move': '000000',
    'sub': '000000',
    'sw': '101011',
    'syscall': '000000'
}


# Using dictionary to map registers to binary code
register_encoding = {
    '$zero': '00000',
    '$t0': '01000',
    '$t1': '01001',
    '$t2': '01010',
    '$t3': '01011',
    '$t4': '01100',
    '$t7': '01111',
    '$s0': '10000',
    '$s1': '10001',
    '$s3': '10011',
    '$s4': '10100',
    '$v0': '00010',
    '$a0': '00100'
}

# Open the sort.asm
with open('sort.asm', 'r') as f:
    assembly_code = f.readlines()

# Using an array to store the machine code and write the machine code in a file
machine_code = []

# Going through each line in assembly_code
for line in assembly_code:
    parts = line.split()

    # If the line is empty, ignore it
    if not parts:
        continue

    # If the line is a comment (i.e., it starts with #), ignore it
    elif parts[0] == "#":
        continue

    # For handling instructions
    else:
        # Converting parts into binary codes according to the instruction encoding dictionary


        try:
            

            # R format
            binary_opcode = instruction_encoding.get(parts[0])
            rd = register_encoding.get(parts[1])
            rs = register_encoding.get(parts[2])
            rt = register_encoding.get(parts[3])
            # if the instruction is not shift => SHAMT = 0 
            shamt = ""
            func = ""
            line_binary = binary_opcode + rd + rs + rt + shamt + func
            

            # J-type instructions:
            binary_opcode = instruction_encoding.get(parts[0])
            # if first j encountered => address = 4234234
            # if second j encountered => address = 4234234
            # if third j encountered => address = 4234234
            adress = " "



            # I-type instructions
            

            machine_code.append(binary_instruction)

        except Exception as e:
            print(f"Unknown instruction: {e}")

# Print the machine code
for i, binary_instruction in enumerate(machine_code):
    print(f"Instruction {i + 1}: {binary_instruction}")