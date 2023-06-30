'''Create a function in Python that accepts two parameters. The first will be a list of numbers.
The second parameter will be a string that can be one of the following values: asc, desc, and none.

If the second parameter is “asc,” then the function should return a list with the numbers in ascending order. If it’s “desc,”
then the list should be in descending order, and if it’s “none,” it should return the original list unaltered.
'''


def choice(random_list, user_input):
    if user_input == "asc":
        random_list.sort()
        return random_list

    elif user_input == "desc":
        random_list.sort(reverse=True)
        return random_list

    elif user_input == "none":
        return random_list


sorted_list = choice(
    [41, 5, 34, 1, 66, 15, 8],
    "none"
)

print(sorted_list)
