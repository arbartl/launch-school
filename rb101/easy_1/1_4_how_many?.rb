=begin
Write a method that counts the number of occurrences of each element in a given array.

Inputs:
-an array of strings

Output:
-a hash with the key = unique string; value = number of occurrences

Mental Model:
Given an array containing multiple elements, iterate through the array. If the given element is not already a key in the hash, create a new key with the element name and increment the default
value of zero by 1. If the given element is already in the hash, increment the current value by one. After iterating through the array, print each hash key with the value (number of occurences).

Data Structures:
Hash with default value of 0 ( Hash.new(0) )

Algorithms:
-Array.each to iterate through input array
-Hash.each to print each element and occurences

=end

def count_occurrences(array)
  occurences = Hash.new(0)

  array.each {|value| occurences[value.downcase] += 1 }
  occurences.each {|key, value| puts "#{key} => #{value}"}
end

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'suv', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

count_occurrences(vehicles)
