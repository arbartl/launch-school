# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

# ex
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

frequency = Hash.new(0)

statement.split.join('').chars { |char| frequency[char] += 1 }

p frequency