Write a method that takes a string argument and returns a new string that contains the value of the original string with all consecutive duplicate characters collapsed into a single character. You may not use String#squeeze or String#squeeze!.

## PEDAC

### P: Understand the Problem

- Explicit Requirements:
  - Input: String object consisting of one or more alpha-numeric words
  - Output: **NEW** String object with consecutive duplicate characters collapsed to a single instance of the character
  - May not use the `String#squeeze` or `String#squeeze!` built-in methods.

- Implicit Requirements:
  - More than two consecutive characters are still reduced to a single character, so we can't only compare a character with the next one in sequence.
  - Can assume there is no punctuation in the input string.
  - Cannot use `String#uniq` as that would remove all duplicates, not just consecutive duplicates

### E: Examples & Test Cases

crunch('ddaaiillyy ddoouubbllee') == 'daily double'
crunch('4444abcabccba') == '4abcabcba'
crunch('ggggggggggggggg') == 'g'
crunch('a') == 'a'
crunch('') == ''

### D: Data Structures

- Input is a string of one or more words of alphanumeric characters
- Split the string into individual characters in order to iterate by index
- Output is a string of one or more words of alphanumeric characters

### A: Algorithms

- A logical sequence of steps for accomplishing a task or objective
  - Closely linked to data structures
  - Series of steps to structure data to produce the required output
- Stay abstract and high level
  - Avoid implementation detail
  - Don't worry about efficiency of the algorithm at this time
- Write out the solution using Pseudocode or Flowchart

1. Initialize an empty string to contain the non-duplicated characters
2. Initialize a variable to track the index of the current character
3. Initialize a variable to track the index of the character being compared to
4. Compare the character with the character at index + 1
  a. If the two characters are the same, increment the comparison index and repeat Step 4
  b. If the characters are different, add the character to the string initialized in step 1 and set the current index to the comparison index
5. Repeat step 4 until the comparison index == the strength length
6. Return the string of unique values

### C: Implement a Solution in Code

- Translating the solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features / constraints
  - Characteristics of the data structures
  - Built in functions / methods
  - Syntax and coding patterns
- Create any test cases that are necessary
- **Code with intent**