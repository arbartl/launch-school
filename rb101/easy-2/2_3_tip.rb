puts "How much is the bill?"
bill_amount = gets.chomp.to_f

puts "What percentage do you want to tip?"
tip_percent = gets.chomp.to_f

tip_amount = bill_amount * tip_percent / 100
total = bill_amount + tip_amount

puts "The tip is: $#{tip_amount}"
puts "The total is: $#{total}"