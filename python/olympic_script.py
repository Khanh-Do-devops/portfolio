result = []

usr_input = input().split()

for i in range(len(usr_input)):
    usr_input[i] = int(usr_input[i])
    result.append(usr_input[i])
result.sort()
print(result)
print("Gold:", result[-1])
print("Silver:", result[-2])
print("Bronze:", result[-3])