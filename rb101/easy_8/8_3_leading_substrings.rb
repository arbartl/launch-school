def leading_substrings(str)
  arr = []
  count = 1
  (str.size).times { arr << str[0, count] ; count += 1 }
  arr
end

p leading_substrings('abc') == ['a', 'ab', 'abc']
p leading_substrings('a') == ['a']
p leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']