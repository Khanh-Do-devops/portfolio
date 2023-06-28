"""Write a function in Python that accepts a list of any length that contains a mix of non-negative integers and
strings. The function should return a list with only the integers in the original list in the same order."""


def mixed_inputs(user_input):
    modified_list = []
    for i in user_input:
        if isinstance(i, int):
            modified_list.append(i)
    return modified_list


output = mixed_inputs([
    563,"ulyuss", "khanh", "pinoy", 8
])

print(output)