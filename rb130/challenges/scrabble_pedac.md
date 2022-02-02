Write a program that, given a word, computes the Scrabble score for that word.

You'll need the following tile scores:

Letter	Value
A, E, I, O, U, L, N, R, S, T 1
D, G	2
B, C, M, P	3
F, H, V, W, Y	4
K	5
J, X	8
Q, Z	10

# Understand the problem

Given, a word, calculate the Scrabble score of that word given the tile score.

# Examples

'CABBAGE' => 3 1 3 3 1 2 1 => 14 points

Other examples in test cases

# Data Structure

Input: a String of a word to score
Ouput: an Integer represenation of the score

# Algorithm

A `Scrabble` class

Constructor
- Accept a string argument that represents the word to score and store it in `@word`
  - Validate that this string only contains alphabetic characters

Instance Methods
- `score` which scores the word stored in the instance variable `@word`
  - a helper method which determines points for each character of the word
  - could use a hash constant with the point value as the key
  - alternatively could use a case statement that returns the point value based on the category
- `valid?` which confirms if word passed into constructor is a valid word to score

Class Methods
- `self.score` which scores a word passed to it as an argument without instantiating a new object