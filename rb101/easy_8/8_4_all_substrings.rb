def substrings(str)
  arr = []
  size = str.size

  loop do
    count = 1
    size.times do
      arr << str[0, count]
      count += 1
    end
    str = str[1..-1]
    break if str == ''
    size = str.size
  end
  arr
end

p substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]