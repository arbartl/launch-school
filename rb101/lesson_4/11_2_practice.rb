# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# PEDAC

# Problem
# Given a hash with key/value pairs in the format of name => age, add up the ages for each name in the hash.

# Example
# Total age should be 6,174

# Data Structure
# Input - hash of str/int key/value pairs
# Output - integer of total age

# Algorithm
# Iterate through the values of the given hash and add the value to an ongoing subtotal of the ages
# Return the total after iterating

# Code

total_ages = ages.values.reduce(:+)

p total_ages