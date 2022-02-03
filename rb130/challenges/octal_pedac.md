Implement octal to decimal conversion. Given an octal input string, your program should produce a decimal output. Treat invalid input as octal 0.

# Understand the Problem

We will be converting a given octal number to its decimal counterpart.

An octal number is in base 8, and can be understood as a linear combination of powers of 8:

233 in octal
= 2 * 8^2 + 3 * 8^1 + 3 * 8^0
= 2 * 64 + 3 * 8 + 3 * 1
= 128 + 24 + 3
= 155 in decimal

# Examples

See test cases

# Data Struture

Input: a string representation of an octal number
Output: an integer representation of the input in decimal (base 10)

# Algorithm

Class `Octal`

Constructor
- A single parameter, num, which will represent the octal number in string format
- Input is not validated in the constructor

Instance Methods
- `to_decimal` converts the @num instance variable to its decimal counterpart
  - Should return `0` if the given input is not valid
    - Invalid characters: any non-integer character, any integer character greater than 7
  - Convert string to integer
  - Create an array of the digits using the `digits` method
  - Map the digits to their decimal counterpart
  - Return the sum of the converted numbers