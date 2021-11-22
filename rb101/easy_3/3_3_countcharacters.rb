puts "Please write word or multiple words: "
text = gets.chomp.split(' ')

count = 0
text.each { |word| count += word.size }

puts "There are #{count} characters in \"#{text.join(' ')}\"."