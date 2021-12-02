The Fibonacci series is a series of numbers (1, 1, 2, 3, 5, 8, 13, 21, ...) such that the first 2 numbers are 1 by definition, and each subsequent number is the sum of the two previous numbers. This series appears throughout the natural world.

Computationally, the Fibonacci series is a very simple series, but the results grow at an incredibly rapid rate. For example, the 100th Fibonacci number is 354,224,848,179,261,915,075 -- that's enormous, especially considering that it takes 6 iterations before it generates the first 2 digit number.

Write a method that calculates and returns the index of the first Fibonacci number that has the number of digits specified as an argument. (The first Fibonacci number has index 1.)

## PEDAC

### P: Understand the Problem

- Explicit Requirements:
  - Input: Integer
  - Output: Integer representing index of first Fibonacci number with the number of digits of the Input integer
  - The first number in the sequence will have an index of 1

- Implicit Requirements:
  - Input will be a positive number greater than or equal to 2
  - Should be able to calculate at least to 10000 digits

- Assume the digits of the sequence will need to be calculated every time the method is invoked

### E: Examples & Test Cases

find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
find_fibonacci_index_by_length(10) == 45
find_fibonacci_index_by_length(100) == 476
find_fibonacci_index_by_length(1000) == 4782
find_fibonacci_index_by_length(10000) == 47847

### D: Data Structures

- Input will be a positive integer greater than 1
- Output will be a positive integer representing the index of the first number with digits numbering the input
- Will need two placeholder integer variables indicating the current Fibonnaci number as well as its index in the sequence

### A: Algorithms

- A logical sequence of steps for accomplishing a task or objective
  - Closely linked to data structures
  - Series of steps to structure data to producte the required output
- Stay abstract and high level
  - Avoid implementation detail
  - Don't worry about efficiency of the algorithm at this time
- Write out the solution using Pseudocode or Flowchart

1. Initialize two variables `first_num` & `second_num` representing the two numbers to be added to generate the next number in the sequence
2. Initialize a variable representing an Integer representation of the current sequence index `second_num_index`
3. While the digits in the `second_num` variable are less than the input integer
  a. Add the two integer variables to determine the next number in the sequence ( `first_num`, `second_num` = `second_num`, `first_num` + `second_num`)
  b. increment index variable
4. Return the index variable

### C: Implement a Solution in Code

- Translating the solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features / constraints
  - Characteristics of the data structures
  - Built in functions / methods
  - Syntax and coding patterns
- Create any test cases that are necessary
- **Code with intent**