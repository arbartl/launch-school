def short_long_short(str1, str2)
  return str1 + str2 + str1 if str1.size < str2.size
  return str2 + str1 + str2 if str2.size < str1.size
end


p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"