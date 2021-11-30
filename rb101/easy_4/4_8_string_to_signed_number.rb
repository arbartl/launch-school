DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}

def string_to_integer(str)
  int = 0
  index = -1
  str.size.times do |i|
    if i == 0
      int += DIGITS[str[index]]
    else
      digit = 1
      i.times { digit = digit * 10 }
      int += digit * DIGITS[str[index]]
    end
    index -= 1
  end
  int
end

def string_to_signed_integer(str)
  unless DIGITS.include?(str[0])
    sign = str.chars.shift
    str = str.slice!(1..-1)
  end
  number = string_to_integer(str)

  return number * -1 if sign == '-'
  number
end

p string_to_signed_integer('4321') == 4321
p string_to_signed_integer('-570') == -570
p string_to_signed_integer('+100') == 100