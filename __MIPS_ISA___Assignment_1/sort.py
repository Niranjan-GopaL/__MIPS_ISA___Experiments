l = [4,3,2]

N= len(l)


# # [0,N-1]
# for i in range(N):

#     # [0,N-2-i]
#     for j in range(N-i-1):
#         if l[j] > l[j+1]:
#             l[j], l[j+1] = l[j+1], l[j]
# print(l)

# i : 1 -> N-1
for i in range(1,N):
    # j : 0 -> N-1 -i
    for j in range(0,N-i):
        if l[j] > l[j+1]: l[j], l[j+1] = l[j+1], l[j]

print(l)