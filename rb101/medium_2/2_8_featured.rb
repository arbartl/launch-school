def featured(int)

  new_int = int.dup

  loop do 
    break if new_int % 7 == 0 && new_int > int && new_int.odd?
    new_int += 1
  end

  loop do
    break if new_int.to_s.chars == new_int.to_s.chars.uniq
    new_int += 14
    return "There is no possible number that fulfills those requirements." if new_int > 9876543210
  end
 
  new_int
end

p featured(12) == 21
p featured(20) == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
p featured(999_999) == 1_023_547
p featured(999_999_987) == 1_023_456_987
p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements