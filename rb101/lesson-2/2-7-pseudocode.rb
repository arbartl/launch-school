=begin
1. a method that returns the sum of two integers

Given two integers as input
return the result of integer1 + integer2

START

SET result = integer1 + integer2
RETURN result

END


2. a method that takes an array of strings, and returns a string that is all those strings concatenated together

Given an array of strings
  iterate through each element of the array and concatenate the value to an empty string
  return the completed string

START

  SET iterator = 1
  SET string = ''

  WHILE iterator is less than the length of the array
    concatenate value of element to the string variable

  RETURN string

END


3. a method that takes an array of integers, and returns a new array with every other element

Given an array of integers
  initialize an empty array to hold the returned elements
  initialize an iterator at the first index of the array
  while the iterator is less than the lenght of the array
    push the value at the given index into the empty array
    increase the iterator by two to skip every other element
  return the new array

START

SET new_array = empty array
SET iterator = 0

WHILE iterator + 1 < size of the input array
  push input_array[iterator] into the new_array
  increment the iterator by 2

RETURN new_array

END

=end