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

def palindromes(str)
  substring_arr = substrings(str)
  substring_arr.select { |word| word.size > 1 && word == word.reverse }
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]