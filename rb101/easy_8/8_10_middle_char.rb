def center_of(str)
  mid = str.size / 2
  str.size.even? ? str[mid-1..-mid] : str[mid..(mid*-1)-1]
end

p center_of('I love ruby') == 'e'
p center_of('Launch School') == ' '
p center_of('Launch') == 'un'
p center_of('Launchschool') == 'hs'
p center_of('x') == 'x'