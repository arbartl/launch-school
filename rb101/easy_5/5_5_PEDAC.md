## PEDAC

Given a string that consists of some words (all lowercased) and an assortment of non-alphabetic characters, write a method that returns that string with all of the non-alphabetic characters replaced by spaces. If one or more non-alphabetic characters occur in a row, you should only have one space in the result (the result should never have consecutive spaces).

### P: Understand the Problem

- Explicit Requirements:
  - Input: string of lowercased words mixed with an assortment of non-alphabetic characters
  - Output: same string with any non-alphabetic characters replaced by spaces, and any consecutive spaces reduced to one space.
  - Alphabetic characters will all be lowercased
  - One or more non-alphabetic characters

- Implicit Requirements:
  - Non-alphabetic characters can appear anywhere in the string
  - Punctuation appropriate to the string should also be removed ("that's" --> "that s")

### E: Examples & Test Cases

    cleanup("---what's my +*& line?") == ' what s my line '
    cleanup("$2-thi==s is4  a&&test!") == ' thi s is a test '

### D: Data Structures

- A string object of alphabetic characters intermixed with non-alphabetic characters
- Output will be a string object of only the alphabetic characters and any non-alphabetic characters replaced with spaces.

### A: Algorithms

1. Substitute any non-alphabetic characters in string with spaces
2. Condense spaces into a single space
3. Return substitued string

**Questions:**
- Are there any built-in string methods to indicate non-alphabetic lowercase characters?
  - **YES** Not a string method, but RegEx can be used in this case: `/[a-z]/` would select only a - z. `/[^a-z]/` would select non-alphabetic characters.
- Are there any built-in string methods to replace multiple characters with a single character?
  - **YES** `String#gsub(pattern, replacement)` can be used to replace a `pattern` of characters with a `replacement` character - a space in our instance.
- Are there any built-in string methods to condense multiple spaces into one space?
  - **YES** `String#squeeze(str)` will replace multiple instances of `str` in sequence in the String object with a single instance.

### C: Implement a Solution in Code

- Translating the solution algorithm into code
- Think about the algorithm in the context of the programming language
  - Language features / constraints
  - Characteristics of the data structures
  - Built in functions / methods
  - Syntax and coding patterns
- Create any test cases that are necessary
- **Code with intent**