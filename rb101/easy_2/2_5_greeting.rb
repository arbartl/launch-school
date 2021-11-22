puts "What is your name?"
name = gets.chomp

puts (name.match('!')) ? "HELLO #{name.upcase.chop}. WHY ARE WE SCREAMING?" : "Hello #{name}."