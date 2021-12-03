def swapcase(str)
  return_str = ''
  str.chars { |char| char == char.upcase ? return_str << char.downcase : return_str << char.upcase }
  return_str
end

p swapcase('CamelCase') == 'cAMELcASE'
p swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'