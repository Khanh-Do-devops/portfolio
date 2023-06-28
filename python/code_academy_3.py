"""Write a function in Python that accepts a decimal number and returns the equivalent binary number. To make this
simple, the decimal number will always be less than 1,024, so the binary number returned will always be less than ten
digits long."""


def decimal_converter(decimal_number):
    return bin(decimal_number).replace("0b", "")


final_conversion = decimal_converter(1)
print(final_conversion)