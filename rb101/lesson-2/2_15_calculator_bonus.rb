# Require files

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

# Method definitions

def prompt(message)
  puts "=> #{message}"
end

def integer?(number)
  number == number.to_i.to_s
end

def float?(number)
  number == number.to_f.to_s
end

def number?(number)
  integer?(number) || float?(number)
end

def operation_to_message(operation)
  word =  case operation
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
  end

  word
end

def convert_string(number)
  return number.to_i if integer?(number)
  number.to_f
end

# ask the user for two numbers

prompt(MESSAGES['welcome'])

name = ''
loop do
  prompt(MESSAGES['name_request'])
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['invalid_name'])
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
    prompt(MESSAGES['first_number'])
    num1 = gets.chomp

    if number?(num1)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  loop do
    prompt(MESSAGES['second_number'])
    num2 = gets.chomp

    if number?(num2)
      break
    else
      prompt(MESSAGES['invalid_number'])
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
      prompt(MESSAGES['invalid_operation'])
    end
  end

  # perform the operation

  num1 = convert_string(num1)
  num2 = convert_string(num2)

  prompt("#{operation_to_message(operation)} the two numbers...")
  result =  case operation
            when '1'
              num1 + num2
            when '2'
              num1 - num2
            when '3'
              num1 * num2
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