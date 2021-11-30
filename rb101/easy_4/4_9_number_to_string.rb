def integer_to_string(int)
  return '0' if int == 0
  digits = []
  place_counter = 1

  until int / place_counter == 0
    digits << int % (place_counter*10) / place_counter
    place_counter *= 10
  end
  digits.reverse.join
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'