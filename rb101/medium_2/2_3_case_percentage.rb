CASES = {
  upper: /[A-Z]/,
  lower: /[a-z]/
}

def letter_percentages(str)
  percentage_hsh = {}
  percentage_hsh[:lowercase] = (str.scan(CASES[:lower]).count / str.size.to_f) * 100
  percentage_hsh[:uppercase] = (str.scan(CASES[:upper]).count / str.size.to_f) * 100
  percentage_hsh[:neither] = 100 - percentage_hsh[:lowercase] - percentage_hsh[:uppercase]
  percentage_hsh
end

p letter_percentages('abCdef 123') == { lowercase: 50.0, uppercase: 10.0, neither: 40.0 }
p letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25.0 }
p letter_percentages('123') == { lowercase: 0.0, uppercase: 0.0, neither: 100.0 }