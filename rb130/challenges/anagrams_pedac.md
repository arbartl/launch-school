Write a program that takes a word and a list of possible anagrams and selects the correct sublist that contains the anagrams of the word.

For example, given the word "listen" and a list of candidates like "enlists", "google", "inlets", and "banana", the program should return
a list containing "inlets". Please read the test suite for the exact rules of anagrams.

# Understand the Problem

Given a word and an array of words, return a list of words in the array that are anagrams for the given word.

An anagram is a word that contains the exact frequency of characters as another word does.
Ex: "listen" - "inlets"

# Examples

listen - [enlists, google, inlets, banana] => inlets

See test cases file

# Data Structures

Input: a string & an array of strings
Output: an array of strings that are anagrams of the given string

Class: Anagram
- Initialized with a string that represents the word that will be compared
- `match` instance method that takes an array of strings as an argument and runs the comparison. This method returns the array of anagrams

# Algorithm

- Iterate through the array of strings to compare against
- Select the words from the array that are anagrams of the given word
  - Can create a hash representation of each character with its count in the word
  - Compare it to a hash representation of the given word character counts
  - Select if hash maps are equal
- Return the array of anagrams

