
N = 10

M = 21

output = []

for x in range(N, M + 1):

    if x % 3 == 0 and x % 5 == 0:
        x = "BuzzFizz"

    elif x % 3 == 0:
        x = "Fizz"

    elif x % 5 == 0:
        x = "Buzz"

    output.append(x)

for i in output:
    print(i, end=" , ")