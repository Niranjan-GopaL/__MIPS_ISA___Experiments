N = int(input("Enter N:"))   

print("Enter A : ", end ='')
A = list(map(int, input().split(" ")))


print("Enter B : ", end ='')
B = list(map(int, input().split(' ')))


print(A)
print(B)





# # UNCOMMENT TO PAY AROUND WITH  ACTUAL CODE

C = [0] * (N*N)

i1 = 0; i2 = 0

# k -> [0 N*N -1]
for k in range(0, N*N):

    if k and not k%N: 
        i2+=1
        i1=0

    # j -> [0 N -1]
    for j in range(0, N):
        C[k] += A[i2*N + j]*B[i1 + j*N]
        print(f'C[{k}] += A[{i2*N + j}]*B[{i1+j*N}] = {A[i2*N + j]}*{B[N + i1*j]} = {C[k]}')


    print(f'C[{k}] = {C[k]}')
    i1+=1

print(C)





# Basically :-

# C = [0]*(N*N)
# row_offset = 0
# clm_offset = 0


# for k in range(N*N):

#     if k and k%N == 0:
#         row_offset += 1
#         clm_offset = 0
    
#     for j in range(N):
#         C[k] = A[row_offset*N + j] * B[clm_offset + j*N]

#     clm_offset +=1