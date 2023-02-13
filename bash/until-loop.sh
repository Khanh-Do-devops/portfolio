#!/bin/bash

c=0

until [ $c = $2 ]
do
echo "$1"
(( c++ ))
done

# 	In the above, the first line is the initial count.
#	Then the line below (until) set's the condition for the loop to stop running. In this case, the count must equal the 2nd positional Argument
#	The 'do' function is as described - until the loop stops, do this......
#	The line after echo's the 1st PA
#	The next line increments the count after each script execution
#	Lastly, done = end of loop script


# When running the script (assuming your in the correct directory:)

# ./until-loop khanh 4

# khanh is the first PA, and 4 is the 2nd PA. The PA's are filled in by the person running the script.

# The output will be:
# khanh
# khanh
# khanh
# khanh


