N = int(input("Enter N:"))   

print("Enter A : ", end ='')
A = list(map(int, input().split(" ")))


print("Enter B : ", end ='')
B = list(map(int, input().split(' ')))


print(A)
print(B)
C = [0] * (N*N)

i1 = 0; i2 = 0

# k -> [0 N*N -1]
for k in range(0, N*N):

    if k and not k%N: 
        i2+=1

    # j -> [0 N -1]
    for j in range(0, N):
        print(f'C[{k}] += A[{i2*N + j}]*B[{i1+j*N}]')

        C[k] += A[i2*N + j]*B[j + i1*N]

    print(f'C[{k}] = {C[k]}')
    i1+=1


print(C)