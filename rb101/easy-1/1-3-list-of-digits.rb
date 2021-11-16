=begin
Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.

Inputs:
-integer

Output:
-an array of the integer's digits

=end

def digit_list(integer)
  arr = integer.to_s.chars.map {|i| i.to_i} 
end

p digit_list(12345)
p digit_list(7)
p digit_list(375290)
p digit_list(444)