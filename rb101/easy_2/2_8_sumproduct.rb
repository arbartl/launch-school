puts ">> Please enter an integer greater than 0:"
number = gets.chomp.to_i

puts ">> Enter 's' to compute the sum, 'p' to compute the product."
sum_or_product = gets.chomp

result = (1..number).reduce(sum_or_product == 's' ? :+ : :*)

puts "The #{sum_or_product == 's' ? "sum" : "product"} of the integers between 1 and #{number} is #{result}."