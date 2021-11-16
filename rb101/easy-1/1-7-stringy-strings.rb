=begin
Write a method that takes one argument, a positive integer, and returns a string of alternating 1s and 0s, always starting with 1. The length of the string should match the given integer.

=end


def stringy(integer)
  count = 1
  arr = []
  integer.times do
    arr.push (count.odd?) ? '1'.to_s : '0'.to_s
    count += 1
  end
  arr.join('')
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'