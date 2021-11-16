=begin
Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.

Inputs:
-string
-positive integer

Outputs:
-string repeated as many times as integer argument indicates

=end

def repeat(string, num)
  num.times {|i| puts string }
end

repeat('Hello', 3)