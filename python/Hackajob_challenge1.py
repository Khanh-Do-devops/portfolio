"""
Write a program that prints the numbers from 1 to 100. But for multiples of three print “Fizz” instead of the number
and for the multiples of five print “Buzz”. For numbers which are multiples of both three and five print "FizzBuzz"
"""

N = 1

M = 100

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
