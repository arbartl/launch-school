# Understand the Problem

Given a number, determine if the number is perfect, abundant, or deficient.

The sum of the number's positive divisors is known as the Aliquot sum.

- Perfect - Aliquot sum is equal to the original number - 6 -> 1 + 2 + 3 == 6
- Deficient - Aliquot sum is less than the original number - 15 -> 1 + 3 + 5 == 9
- Abundant - Aliquot sum is greater than the origianl number - 24 -> 1 + 2 + 3 + 4 + 6 + 8 + 12 == 36

# Examples

See test cases

# Data Structure

Input: an integer
Output: a string representing whether the number is 'abundant', 'deficient', or 'perfect'

# Algorithm

A Class - `PerfectNumber`


Class Methods
- `self.classify` which will do the following:
  - Raise StandardError if number < 2
  - Determine the sum of the number's positive divisors
    - Can abstract this to a helper method (`sum_of_divisors`)
  - Compare the sum of the divisors to the original number
  - Return a string representation of the classification

- `self.sum_of_divisors`
  - Iterate from 1 to the number-1 (to not include the original number) and select the divisors
  - Return the sum of the divisors
