Write a program that, given a natural number and a set of one or more other numbers, can find the sum of all the multiples of the numbers in the set that are less than the first number. If the set of numbers is not given, use a default set of 3 and 5.

# Understand the Problem

Given a number and a set of one or more other numbers, determine all the multiples of the numbers in the set that are less than the first number.

Implicit - if no set of numbers is given, default to multiples of 3 and 5

# Examples

For instance, if we list all the natural numbers up to, but not including, 20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of these multiples is 78.

All natural numbers up to, but not including, 10 - multiples of 3 or 5 => 3, 5, 6, 9 == 23

# Data Structure

Inputs:
- An integer of numbers to count up to, but not include
- (Optional) an array of integers that will define multiples to include
  - Will default to `[3, 5]` if not given

Output:
- An integer representing the sum of the multiples of any of the numbers in the given set less than the first input

# Algorithm

class SumOfMultiples

Constructor:
One parameter
  - The set of numbers defining the multiples, given as a list and defined with the * operator to covert the arguments into an array

Class Methods:
- `to` accepts one mandatory argument, the number to count up to, but not include, and one optional argument of the multiples
  - Optional argument defaults to `[3, 5]` as multiples if invoked without an object as the caller
  - Iterate from lowest multiple to the argument-1
    - Select number if it is a multiple of any of the multiples
    - Return the sum of the selected multiples

Instance Methods:
- `to` accepts one argument, the number to count up to, but not include
  - Calls the class `self.to` method passing in the argument passed to it and the multiples stored in the instance variable