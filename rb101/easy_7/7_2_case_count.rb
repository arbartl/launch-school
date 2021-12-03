CASE = {
  lowercase: /[a-z]/,
  uppercase: /[A-Z]/,
  neither: /[^a-zA-Z]/
}

def letter_case_count(str)
  hsh = Hash.new(0)
  CASE.each { |k, v| hsh[k] = str.scan(v).count }
  hsh
end


p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }