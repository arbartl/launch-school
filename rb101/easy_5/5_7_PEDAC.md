Write a method that takes a string with one or more space separated words and returns a hash that shows the number of words of different sizes.

Words consist of any string of characters that do not include a space.

**Do not include punctuation in the size calculation**

## PEDAC

### P: Understand the Problem

- Explicit Requirements:
  - Input: String object of one or more words separated by spaces
  - Output: Hash object with keys representing word length and values representing the frequency of that word length in the input
  - Words are any string of characters that don't include a space
  - The input will be iterated through and the length of each word calculated

- Implicit Requirements:
  - Punctuation should **NOT** be included in the word length
    - e.g., 'diddle,' == 6, 'fiddle!' == 6
  - An empty string should return an empty hash

### E: Examples & Test Cases

    word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
    word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
    word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
    word_sizes('') == {}

### D: Data Structures

- Input will be a String object of one or more words separated by spaces
- In order to work with each word in the string, the string will be broken up into an array of individual word strings
- Output will be a Hash object of word length: frequency pairs

### A: Algorithms

1. Initialize an empty Hash object with a default value of Zero
2. Separate the string into an array of individual words
3. For each word, determine the length of the word, less any punctuation
4. Add the length as a key of the hash, if it is not already in the hash. If it is already in the hash, increment the key value by 1.
5. Repeat steps 3 & 4 until the end of the array of strings is reached
6. Return the hash

### C: Implement a Solution in Code

- Translating the solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features / constraints
  - Characteristics of the data structures
  - Built in functions / methods
  - Syntax and coding patterns
- Create any test cases that are necessary
- **Code with intent**