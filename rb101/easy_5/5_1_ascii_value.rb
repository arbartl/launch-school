def ascii_value(str)
  str.empty? ? 0 : str.chars.map { |char| char.ord }.reduce(:+)
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0