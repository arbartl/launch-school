def xor?(statement1, statement2)
  return true if statement1 && !statement2
  return true if statement2 && !statement1
  false
end

p xor?(5.even?, 4.even?) == true
p xor?(5.odd?, 4.odd?) == true
p xor?(5.odd?, 4.even?) == false
p xor?(5.even?, 4.odd?) == false