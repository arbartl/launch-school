# Understand the Problem

Write a program that will take a string of digits and return all the possible consecutive number series of a specified length in that string.

# Examples

For example, the string "01234" has the following 3-digit series:

012
123
234

Likewise, here are the 4-digit series:

0123
1234

Finally, if you ask for a 6-digit series from a 5-digit string, you should throw an error.

# Data Structure

Input: a string representation of an integer, and a number x which represents the length of slices

Ouput: an array of all slices of the series of x length

# Algorithm

class Series

Constructor
- One parameter
  - String to slice - validate all characters are numeric

Instance methods
- `slices` which accepts one argument, the size of each slice
  - Raise ArgumentError if argument is larger than size of the string
  - Initialize return array
  - Iterate through string and push slices of x size to the return array
  - Return the array

