require 'yaml'

MESSAGES = YAML.load_file('rps_messages.yml')

VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  l: 'lizard',
  sp: 'spock'
}

WINNING_OPTIONS = {
  rock: { scissors: 'crushes', lizard: 'crushes' },
  paper: { rock: 'covers', spock: 'disproves' },
  scissors: { paper: 'cuts', lizard: 'decapitate' },
  lizard: { spock: 'poisons', paper: 'eats' },
  spock: { rock: 'vaporizes', scissors: 'smashes' }
}

VALID_EXIT_ANSWER = {
  positive: ['y', 'yes'],
  negative: ['n', 'no']
}

def prompt(message)
  puts("=> #{message}")
end

def clear_screen
  system('clear')
end

def get_player_choice
  choice = nil
  loop do
    prompt(MESSAGES['choose_one'])
    choice = gets.chomp.downcase
    if VALID_CHOICES.include?(choice.to_sym)
      choice = VALID_CHOICES[choice.to_sym]
      break
    elsif VALID_CHOICES.value?(choice)
      break
    else
      prompt(MESSAGES['invalid_choice'])
    end
  end
  choice
end

def get_computer_choice
  VALID_CHOICES.values.sample
end

def display_choices(player, computer)
  prompt("You chose: #{player.capitalize} -- " \
    "Computer chose: #{computer.capitalize}")
end

def win?(first, second)
  WINNING_OPTIONS[first.to_sym].include?(second.to_sym)
end

def decide_result(player, computer, score)
  if win?(player, computer)
    display_win(player, computer)
    add_point(score, :player)
  elsif win?(computer, player)
    display_lose(computer, player)
    add_point(score, :computer)
  else
    prompt(MESSAGES['tie'])
  end
end

def add_point(score, winner)
  score[winner] += 1
end

def display_win(player, computer)
  prompt("#{player.capitalize} " \
    "#{WINNING_OPTIONS[player.to_sym][computer.to_sym]} " \
    "#{computer.capitalize}!")
  prompt(MESSAGES['player_win_point'])
end

def display_lose(computer, player)
  prompt("#{computer.capitalize} " \
    "#{WINNING_OPTIONS[computer.to_sym][player.to_sym]} " \
    "#{player.capitalize}!")
  prompt(MESSAGES['computer_win_point'])
end

def display_score(score, name)
  prompt("#{name}: #{score[:player]} -- Computer: #{score[:computer]}")
end

def display_winner(score, name)
  if score[:player] == 3
    prompt("#{name} won!!")
  else
    prompt(MESSAGES['computer_win_game'])
  end
end

def play_again
  answer = nil
  loop do
    prompt(MESSAGES['play_again'])
    answer = gets.chomp.downcase
    break if VALID_EXIT_ANSWER[:positive].include?(answer) ||
             VALID_EXIT_ANSWER[:negative].include?(answer)
    prompt(MESSAGES['invalid_choice'])
  end
  answer
end

clear_screen

prompt(MESSAGES['welcome'])
prompt(MESSAGES['line'])
prompt(MESSAGES['ask_name'])
name = gets.chomp
rules_display = <<-MSG
Here are the rules:

        Paper | Spock >> Rock >> Lizard | Scissors
    Scissors | Lizard >> Paper >> Rock | Spock
         Rock | Spock >> Scissors >> Paper | Lizard
      Rock | Scissors >> Lizard >> Spock | Paper
       Paper | Lizard >> Spock >> Scissors | Rock

               First to 3 points wins!

Press Enter to play...
MSG
clear_screen
prompt("Hello, #{name}!")
puts rules_display
gets

loop do # main loop
  score = { player: 0, computer: 0 }
  clear_screen

  loop do
    player_choice = get_player_choice
    computer_choice = get_computer_choice

    prompt(MESSAGES['line'])
    display_choices(player_choice, computer_choice)
    prompt('')
    decide_result(player_choice, computer_choice, score)
    prompt('')
    display_score(score, name)
    prompt(MESSAGES['line'])

    break if score[:player] == 3 || score[:computer] == 3
  end

  display_winner(score, name)
  answer = play_again
  break unless VALID_EXIT_ANSWER[:positive].include?(answer)
end
prompt("Thanks for playing, #{name}! Goodbye!")
