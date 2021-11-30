def signed_integer_to_string(int)
  return '0' if int == 0
  int < 0 ? sign = '-' : sign = '+'
  int *= -1 if int < 0
  digits = []
  place_counter = 1

  until int / place_counter == 0
    digits << int % (place_counter*10) / place_counter
    place_counter *= 10
  end
  digits.reverse.join.prepend(sign)
end

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'