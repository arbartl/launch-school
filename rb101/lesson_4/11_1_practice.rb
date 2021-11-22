# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values are the positions in the array.

# PEDAC

# Problem
# Given an array of strings, return a hash with the key, value pairs being the element in the array with a value of the element's index.

# Examples
# Hash = { "Fred" => 0, "Barney" => 1, "Wilma" => 2 ...}

# Data Structures
# Input - Array of strings
# Output - Hash of Str/Int key/value pairs

# Algorithm
# Create a new empty Hash
# Iterate through the array and add each element to the Hash with a value of the element's index in the parent array
# Return the hash

# Code

flintstones_hash = {}

flintstones.each_with_index { |element, index| flintstones_hash[element] = index }

p flintstones_hash