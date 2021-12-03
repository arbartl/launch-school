def repeater(str)
  rtn_str = ''
  str.chars { |char| rtn_str << char * 2 }
  rtn_str
end

p repeater('Hello') == "HHeelllloo"
p repeater("Good job!") == "GGoooodd  jjoobb!!"
p repeater('') == ''