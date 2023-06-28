"""Create a function in Python that accepts a single word and returns the number of vowels in that word. In this
function, only a, e, i, o, and u will be counted as vowels — not y."""


def vowel_counter(word):
    count = 0
    for i in word:
        if i in ["a", "e", "i", "o", "u"]:
            count += 1
    return count


counter = vowel_counter("aehbgioo")

print(counter)