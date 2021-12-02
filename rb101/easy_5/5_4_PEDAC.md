## PEDAC

### P: Understand the Problem

Given a string of words separated by spaces, write a method that takes this string of words and returns a string in which the first and last letters of every word are swapped.

You may assume that every word contains at least one letter, and that the string will always contain at least one word. You may also assume that each string contains nothing but words and spaces.

- Explicit Requirements:
  - Input: string of words separated by spaces
  - Output: new string with the first and last letter of the word swapped
  - Every word contains at least one letter
  - Every string contains at least one word
  - String is nothing but words and spaces

- Implicit Requirements:
  - Case matters, based on examples
  - Words will be delimited by spaces
  - No punctuation to worry about
  - Strings with one word should just perform the action on the one word
  - Words with one character have no action required

### E: Examples & Test Cases

    swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
    swap('Abcde') == 'ebcdA'
    swap('a') == 'a'
    swap('This is a test case') == 'shiT si a test easc'

### D: Data Structures

- A String object of alphanumeric words separated by spaces
- When string is split into individual words, an array of the words will be created
- Output will be the array of the transformed words joined back together as a string separated by spaces

### A: Algorithms

1. Split the input string into individual words to work with
2. Iterate through the word list
3. Swap the first and last characters of each word
4. Rejoin the words into a String object for the output
5. Return the joined string

*Problem: Swap the first and last characters*

Rules:
- Word is an alphanumeric string with no punctuation
- Case matters when swapping the elements
- Questions:
  - Is there a built-in string method to swap two characters? **NO**
  - Is there a way to assign the value of two characters at once? **YES**
    a, b = b, a

Examples:
'word' == 'dorw'
'Test' == 'tesT'
'reverse' == 'eeversr'

Data Structures:
- A string of alphanumeric characters

Algorithm:
- Remove the first character
- Remove the last character
- Concatentate the last character + rest of word + first character
- Return the word

### C: Code with Intention