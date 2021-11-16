def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number)
  number.to_i != 0
end

def operation_to_message(operation)
  case operation
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

# ask the user for two numbers

prompt("Welcome to Calculator!")

name = ''
loop do
  prompt("Please enter your name: ")
  name = gets.chomp

  if name.empty?
    prompt("Make sure to use your name!")
    next
  else
    break
  end
end

num1 = nil
num2 = nil

prompt("Hello, #{name}!")

loop do
  loop do
    prompt("Please enter the first number: ")
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt("Invalid number!")
    end
  end

  loop do
    prompt("Please enter the second number: ")
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt("Invalid number!")
    end
  end

  # ask the user for an operation to perform

  operation_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operation_prompt)

  operation = nil
  loop do
    operation = gets.chomp

    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end

  # perform the operation

  prompt("#{operation_to_message(operation)} the two numbers...")
  result =  case operation
            when '1'
              num1.to_i + num2.to_i
            when '2'
              num1.to_i - num2.to_i
            when '3'
              num1.to_i * num2.to_i
            when '4'
              num1.to_f / num2.to_f
            end

  # output the result

  prompt("The result is: #{result}")

  prompt("Would you like to perform another calculation? (Y / N)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using calculator. Good bye!")