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

def prompt(message)
  puts("=> #{message}")
end

def get_player_choice
  choice = nil
  loop do
    prompt("Choose one: (R)ock, (P)aper, (S)cissors, (L)izard, (Sp)ock")
    choice = gets.chomp.downcase
    if VALID_CHOICES.include?(choice.to_sym)
      choice = VALID_CHOICES[choice.to_sym]
      break
    elsif VALID_CHOICES.value?(choice)
      break
    else
      prompt("That's not a valid choice!")
    end
  end
  choice
end

def win?(first, second)
  WINNING_OPTIONS[first.to_sym].include?(second.to_sym)
end

def display_results(player, computer)
  if win?(player, computer)
    display_win(player, computer)
  elsif win?(computer, player)
    display_lose(computer, player)
  else
    prompt("It's a tie! No points!")
  end
end

def display_win(player, computer)
  prompt("#{player.capitalize} " \
    "#{WINNING_OPTIONS[player.to_sym][computer.to_sym]} " \
    "#{computer.capitalize}.")
  prompt("You win a point!")
end

def display_lose(computer, player)
  prompt("#{computer.capitalize} " \
    "#{WINNING_OPTIONS[computer.to_sym][player.to_sym]} " \
    "#{player.capitalize}.")
  prompt("Computer wins a point!")
end

loop do
  player_choice = get_player_choice

  computer_choice = VALID_CHOICES.values.sample

  prompt("You chose: #{player_choice.capitalize}; " \
    "Computer chose: #{computer_choice.capitalize}")

  display_results(player_choice, computer_choice)

  prompt("Play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing! Goodbye!")
