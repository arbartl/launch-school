# Method declarations

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

prompt("Welcome to monthly loan calculator!")

# Get loan principal amount from user

loop do
  principal = 0
  loop do
    prompt("Please enter the loan principal amount: ")
    principal = gets.chomp
    break if number?(principal)
    prompt("That isn't a valid amount!")
  end

  # Get APR from user
  apr = 0
  loop do
    prompt("Please enter the APR (in percent): ")
    apr = gets.chomp
    break if number?(apr)
    prompt("That's not a valid APR!")
  end
  # Get loan duration (in months)

  duration = 0
  loop do
    prompt("Please enter the loan duration (in months): ")
    duration = gets.chomp
    break if number?(duration)
    prompt("That's not a valid duration!")
  end

  # Calculate monthly payment

  monthly_rate = apr.to_f / 100 / 12
  payment = principal.to_f * (monthly_rate / (1 - (1 +
    monthly_rate)**(-duration.to_i)))

  # Display monthly payment
  prompt("A principal of $#{principal} with an APR of #{apr}% and a duration of #{duration} months:")
  prompt("Monthly Payment: $#{format('%.2f', payment)}")

  prompt("Calculate another? (Y to continue)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  prompt("Thanks for using the loan payment calculator. Good bye!")
end