instruction_encoding = {
    'li': '001001',
    'addi': '001000',
    'beq': '000100',
    'ble': '000110',
    'jal': '000011',
    'jr': '001000',
    'move': '000000',
    'sub': '000000',
}

load_store_encoding = {
    'lw': '100011',
    'sw': '101011',
}


i_instruction_encoding = {
    'addi': '001000',
    'beq': '000100',
}

r_instruction_encoding = {
    'sub': '000000',
    'mul': '',
}


register_encoding = {
    '$zero': '00000',
    '$0': '00000',
    '$t0': '01000',
    '$t1': '01001',
    '$t2': '01010',
    '$t3': '01011',
    '$t4': '01100',
    '$t5': '01101',
    '$t6': '01110',
    '$t7': '01111',
    '$t8': '11000',
    '$t9': '11001',
    '$s0': '10000',
    '$s1': '10001',
    '$s2': '10010',
    '$s3': '10011',
    '$s4': '10100',
}


branch_jump_addresses = [    
    "0000000000001100",
    "1111111111111010",
]


# Take care of these :-
'''
get() -> returns None if the key is not there in dict
'''


machine_code = []
i = 0

with open('sort_matrix_mult_CLEAN.asm', 'r') as f:
    assembly_code = f.readlines()

    for line in assembly_code:
        if line.strip():
            
            line = line.replace(',', ' ')
            line = line.replace('(',' ')
            line = line.replace(')',' ')

            word = line.split()
            if word[0] == '#' : continue
            try:




                # I-type instructions ( addi, beq )
                # op + rt + rs + imm value 
                if word[0] in i_instruction_encoding:
                    op = i_instruction_encoding[word[0]]
                    rs = register_encoding.get(word[1])
                    rt = register_encoding.get(word[2])

                    if word[0] != "beq":
                        iv = format(int(word[3]), f'0{16}b')
                    else: 
                        iv = branch_jump_addresses[i]
                        i+=1

                    if word[0] != "beq":
                        binary_instruction = op + rt + rs + iv
                    else :              
                        binary_instruction = op + rs + rt + iv

                    print(binary_instruction)
                    machine_code.append(binary_instruction)


                elif word[0] in load_store_encoding:
                    op = load_store_encoding[word[0]]
                    rs = register_encoding[word[1]]
                    iv = format(int(word[2]), f'0{16}b')
                    rt = register_encoding[word[3]]
                    binary_instruction = op + rt + rs + iv
                    print(binary_instruction)
                    machine_code.append(binary_instruction)

                # R-type instructions:
                elif word[0] in r_instruction_encoding:
                    op = r_instruction_encoding[word[0]]
                    rd = register_encoding.get(word[1])
                    rs = register_encoding.get(word[2])
                    rt = register_encoding.get(word[3])
                    shamt = "00000"
                    func  = "100010"
                    binary_instruction = op + rs + rt + rd + shamt + func
                    print(binary_instruction)
                    machine_code.append(binary_instruction)

                elif word[0] == "ble":
                    print("00000010100100110000100000101010")
                    machine_code.append("00000010100100110000100000101010")
                    print("00010000001000000000000000000010")
                    machine_code.append("00010000001000000000000000000010")


                elif word[0] == "j":
                    print("00001000000100000000000000000111")
                    machine_code.append("00001000000100000000000000000111")


            except Exception as e:
                print(f"Unknown instruction: {e}")

