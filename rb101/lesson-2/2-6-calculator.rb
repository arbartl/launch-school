# ask the user for two numbers

puts "Welcome to Calculator!"
puts "Please enter the first number: "
num1 = gets.chomp

puts "Please enter the second number: "
num2 = gets.chomp

# ask the user for an operation to perform

puts "What operation would you like to perform?"
puts "1) add 2) subtract 3) multiply 4) divide"
operation = gets.chomp

# perform the operation

if operation == '1'
  result = num1.to_i + num2.to_i
elsif operation == '2'
  result = num1.to_i - num2.to_i
elsif operation == '3'
  result = num1.to_i * num2.to_i
elsif operations == '4'
  result = num.to_f / num2.to_f
end

# output the result

puts "The result is: #{result}"