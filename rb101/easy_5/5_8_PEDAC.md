Write a method that takes an Array of Integers between 0 and 19, and returns an Array of those Integers sorted based on the English words for each number:

zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen

## PEDAC

### P: Understand the Problem

- Explicit Requirements:
  - Input: An array of integers from 0 to 19
  - Output: An array of the input integers sorted alphabetically based on their English translations

### E: Examples & Test Cases

    alphabetic_number_sort((0..19).to_a) == [
      8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
      6, 16, 10, 13, 3, 12, 2, 0
    ]

### D: Data Structures

- Input is an array of integers
- Output is an array of integers
- Will need a CONSTANT defined with the integer able to be linked to it's English representation
  - Could use a hash with the Integer as a key and the English word as a value
  - Could also use an array of the words from 'zero' to 'nineteen' as the index would be equivalent to its Integer value

### A: Algorithms

1. Create a Hash or Array with the Integer to String translation
  a. **Choosing an Array for simplicity** `int_to_str`
2. Create an empty array to hold the translated strings
3. Map each value in the input array to its translated string value from the `int_to_str` array.
4. Sort this array alphabetically using the `Array#sort` method.
5. Covert the array back into integers
  a. Can use the `Array#index()` method to lookup an index based on a value. 
6. Return the array

### C: Implement a Solution in Code

- Translating the solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features / constraints
  - Characteristics of the data structures
  - Built in functions / methods
  - Syntax and coding patterns
- Create any test cases that are necessary
- **Code with intent**