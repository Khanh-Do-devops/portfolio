"""
Define a function named convert that takes a list of numbers as its only parameter and returns a list of each number
converted to a string.
For example, the call convert([1, 2, 3]) should return ["1", "2", "3"].

"""

def convert(user_input):
    word_list = []
    for i in user_input:
        word_list.append(str(i))
    return (word_list)

new_list = (convert)

print(convert([1, 2, 3]))