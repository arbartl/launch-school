CONSONANTS = /[b-df-hj-np-tv-z]/i

def double_consonants(str)
  rtn_str = ''
  str.chars do |char|
    CONSONANTS.match(char) ? rtn_str << char * 2 : rtn_str << char
  end
  rtn_str
end

p double_consonants('String') == "SSttrrinngg"
p double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
p double_consonants("July 4th") == "JJullyy 4tthh"
p double_consonants('') == ""