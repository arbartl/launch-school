arr = []
puts "Enter the 1st number:"
arr << gets.chomp.to_i
puts "Enter the 2nd number:"
arr << gets.chomp.to_i
puts "Enter the 3rd number:"
arr << gets.chomp.to_i
puts "Enter the 4th number:"
arr << gets.chomp.to_i
puts "Enter the 5th number:"
arr << gets.chomp.to_i
puts "Enter the last number:"
comparison = gets.chomp.to_i
puts "The number #{comparison} #{arr.include?(comparison) ? "appears" : "does not appear"} in #{arr.inspect}."