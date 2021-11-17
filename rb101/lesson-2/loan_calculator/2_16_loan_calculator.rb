require 'yaml'
MESSAGES = YAML.load_file('loan_calculator_messages.yml')

VALID_RESPONSE = {
  positive: ['y', 'yes'],
  negative: ['n', 'no']
}

MONTHS = 12

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

def positive?(number)
  number.to_i > 0
end

def format_to_currency(number)
  format('%.2f', number)
    .reverse
    .scan(/(\d*\.\d{1,3}|\d{1,3})/)
    .join(',')
    .reverse
end

def clear_screen
  system('clear')
end

def get_principal
  principal = 0
  loop do
    prompt(MESSAGES['get_principal'])
    principal = gets.chomp
    break if number?(principal) && positive?(principal)
    prompt(MESSAGES['invalid_principal'])
  end
  principal
end

def get_downpayment(loan)
  downpayment = 0
  loop do
    prompt(MESSAGES['get_downpayment'])
    downpayment = gets.chomp
    break if number?(downpayment) &&
             downpayment.to_f >= 0 &&
             downpayment.to_f < loan[:principal].to_f
    prompt(MESSAGES['invalid_downpayment'])
  end
  downpayment
end

def get_apr
  apr = 0
  loop do
    prompt(MESSAGES['get_apr'])
    apr = gets.chomp
    break if number?(apr) && apr.to_f >= 0
    prompt(MESSAGES['invalid_apr'])
  end
  apr
end

def get_duration
  duration = 0
  loop do
    prompt(MESSAGES['get_duration'])
    duration = gets.chomp
    break if number?(duration) && positive?(duration)
    prompt(MESSAGES['invalid_duration'])
  end
  duration
end

def calculate_monthly_payment(loan)
  if loan[:apr].to_f != 0
    calculate_payment_apr(loan)
  else
    (loan[:principal].to_f - loan[:downpayment].to_f) / loan[:duration].to_i
  end
end

def calculate_payment_apr(loan)
  monthly_rate = loan[:apr].to_f / 100 / MONTHS
  (loan[:principal].to_f - loan[:downpayment].to_f) *
    (monthly_rate / (1 - (1 + monthly_rate)**(-loan[:duration].to_i)))
end

def display_summary(loan)
  clear_screen
  summary_prompt = <<-MSG
  Summary of Input:
     Principal:       $#{format_to_currency(loan[:principal])}
     Downpayment:     $#{format_to_currency(loan[:downpayment])}
     APR:             #{loan[:apr]}%
     Duration:        #{loan[:duration]} months (#{loan[:duration].to_f / MONTHS} years)
     Monthly Payment: $#{format_to_currency(loan[:payment])}
  MSG
  prompt(summary_prompt)
  prompt('')
end

def calculate_another?
  answer = nil
  loop do
    prompt(MESSAGES['calculate_another?'])
    answer = gets.chomp.downcase
    break if VALID_RESPONSE[:positive].include?(answer) ||
             VALID_RESPONSE[:negative].include?(answer)

    prompt(MESSAGES['invalid_exit_response'])
  end
  answer
end

clear_screen
prompt(MESSAGES['welcome'])

loop do # main loop
  loan_details = Hash.new(0)
  loan_details[:principal] = get_principal
  loan_details[:downpayment] = get_downpayment(loan_details)
  loan_details[:apr] = get_apr
  loan_details[:duration] = get_duration
  loan_details[:payment] = calculate_monthly_payment(loan_details)

  display_summary(loan_details)

  go_again = calculate_another?
  clear_screen unless VALID_RESPONSE[:negative].include?(go_again)
  break if VALID_RESPONSE[:negative].include?(go_again)
end
prompt(MESSAGES['goodbye'])
