Write a method that rotates an array by moving the first element to the end of the array. The original array should not be modified.

Do not use the method Array#rotate or Array#rotate! for your implementation.

## PEDAC

### P: Understand the Problem

- Explicit Requirements:
  - Input: an array of unknown elements
  - Output: an array with the same elements, but the first element has been added to the end
  - **Original array cannot be modified**
  - **Cannot use the `Array#rotate` or `Array#rotate!` built-in methods
  - First element can possibly be shifted out of array and appended to the end

- Implicit Requirements:
  - Single element arrays should just return an array of the single element
  - No specific indicating if the array can be copied into a new variable inside the array

### E: Examples & Test Cases

rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true

### D: Data Structures

- Input is an array of unknown elements
- Output is an array of the same elements

### A: Algorithms

1. Initialize a local variable to the method and assign it a copy of the passed-in array (`Object#dup`)
2. Remove the first element of the local variable array
3. Add the removed elemen to the end of the array
4. Return the modified array - passed in array should be unchanged

### C: Implement a Solution in Code

- Translating the solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features / constraints
  - Characteristics of the data structures
  - Built in functions / methods
  - Syntax and coding patterns
- Create any test cases that are necessary
- **Code with intent**