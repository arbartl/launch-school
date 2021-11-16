=begin
Write a method that takes one argument, a string, and returns a new string with the words in reverse order.

Inputs:
-a string

Output:
-a string with the words reversed


Mental Model:
Take a string argument, split the string into an array with each word as a separate element. Take the elements from the end of the array and add them into a new array until the original
array is empty. Join the new array back together as a string and return it.

=end

def reverse_sentence(string)
  arr = string.split
  reverse_arr = []
  until arr.empty? do reverse_arr << arr.pop end
  reverse_arr.join(' ')
end

puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
puts reverse_sentence('') == ''
puts reverse_sentence('    ') == '' # Any number of spaces results in ''
