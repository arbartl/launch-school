CARD_SUITS = ["Spades", "Diamonds", "Clubs", "Hearts"]

CARD_VALUES = ['A', 'K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2']

CARD_SYMBOLS = {
  "Spades" => "♠",
  "Diamonds" => "♦",
  "Clubs" => "♣",
  "Hearts" => "♥"
}

CARD_POINTS = {
  'A' => 11, 'K' => 10, 'Q' => 10, 'J' => 10, '10' => 10, '9' => 9, '8' => 8,
  '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2
}

DEALER_STAY = 17
TARGET_VALUE = 21

VALID_TURN_CHOICE = {
  stand: ['s', 'st', 'stand'],
  hit: ['h', 'hi', 'hit']
}

VALID_ROUND_OVER_CHOICE = {
  continue: ['c', 'cont', 'continue'],
  walk: ['w', 'walk', 'walk away', 'walkaway', 'q', 'quit']
}

VALID_YES_NO = {
  positive: ['y', 'yes'],
  negative: ['n', 'no']
}

EXPLANATION = <<-MSG
   You and the dealer will each be dealt 2 cards. You will only see one 
   of the dealer's cards. The goal is to reach 21 points without going
   over (busting). After you decide to keep your hand (stay), the dealer
   will go.
 
   The dealer will reveal their other card, and decide to stay or hit.
   The dealer MUST hit if they have less than 17 points. After the dealer
   stays, your scores will be compared.
   
   Aces are worth 1 or 11 points, Face Cards are worth 10 points, and all
   other cards are worth their face value.
   
   If you have an Ace and a Face Card as your dealt hand, you have a
   Blackjack and automatically win, unless the dealer also does. If you
   get Blackjack, you get one and a half times your bet back!  
MSG

def clear_screen
  system("clear")
end

def joinand(arr, separator=', ', last_separator=' & ')
  joined_arr = []
  arr.each do |card|
    str = card[:value] + card[:symbol]
    joined_arr << str
  end
  last_element = joined_arr.pop
  joined_arr[0] + last_separator + last_element unless joined_arr[1]
  joined_arr.join(separator) + last_separator + last_element
end

def prompt(message)
  puts("=> #{message}")
end

def welcome
  clear_screen
  prompt("Welcome to Ruby Blackjack!")
  prompt("")
  prompt("You'll start with 500 chips.")
  prompt("")
end

def ask_for_explanation
  choice = nil
  loop do
    prompt("Would you like an explanation? (Y / N)")
    choice = gets.chomp.strip.downcase
    break if VALID_YES_NO.values.flatten.include?(choice)
    prompt("Sorry, I didnt catch that...")
  end
  choice
end

def display_explanation
  clear_screen
  puts(EXPLANATION)
  puts("")
  prompt("Ready to start? Press Enter to play!")
  gets
end

def initialize_deck
  deck = []
  card = {}
  CARD_VALUES.each do |value|
    CARD_SUITS.each do |suit|
      card[:value] = value
      card[:suit] = suit
      card[:symbol] = CARD_SYMBOLS[suit]
      card[:points] = CARD_POINTS[value]
      deck << card
      card = {}
    end
  end
  deck
end

def reset_hands_and_scores(game_info)
  game_info[:dealer_hand] = []
  game_info[:player_hand] = []
  game_info[:player_hand_score] = 0
  game_info[:dealer_hand_score] = 0
  game_info[:current_deck] = initialize_deck.shuffle
end

def player_bet(game_info)
  bet = 0
  chips = game_info[:player_chip_count]
  loop do
    prompt("You have #{chips} chips")
    prompt("How much would you like to bet? (1 - #{chips})")
    bet = gets.chomp.strip
    break if valid_bet?(bet, chips)
    prompt("That's not a valid bet...")
  end
  bet.to_i
end

def valid_bet?(bet, chips)
  bet.to_i > 0 &&
    bet.to_i <= chips &&
    bet == bet.to_i.to_s
end

def deal_starting_hands(game_info)
  2.times { game_info[:dealer_hand] << game_info[:current_deck].pop }
  2.times { game_info[:player_hand] << game_info[:current_deck].pop }
end

def display_game_info(game_info)
  clear_screen
  dealer_hand = game_info[:dealer_hand][0]
  prompt("----------------------")
  prompt("Dealer's Hand: #{dealer_hand[:value]}#{dealer_hand[:symbol]}" \
          " & ??")
  prompt("Dealer's Total: ??")
  prompt("----------------------")
  display_your_hand(game_info)
  display_current_chips(game_info)
end

def reveal_dealer_hand(game_info)
  clear_screen
  prompt("----------------------")
  prompt("Dealer's Hand: #{joinand(game_info[:dealer_hand])}")
  prompt("Dealer's Total: #{score_hand(game_info[:dealer_hand])}")
  prompt("----------------------")
  display_your_hand(game_info)
  display_current_chips(game_info)
end

def display_your_hand(game_info)
  prompt("----------------------")
  prompt("Your Hand: #{joinand(game_info[:player_hand])}")
  prompt("Your Total: #{score_hand(game_info[:player_hand])}")
  prompt("----------------------")
end

def display_current_chips(game_info)
  prompt("Your Chip Count: #{game_info[:player_chip_count]}")
  prompt("Your Bet: #{game_info[:player_bet]}")
  prompt("")
end

def hit(hand, deck)
  hand << deck.pop
end

def player_hit(game_info)
  hit(game_info[:player_hand], game_info[:current_deck])
end

def dealer_hit(game_info)
  hit(game_info[:dealer_hand], game_info[:current_deck])
end

def player_turn(game_info)
  player_turn_choice(game_info)
  player_choice = game_info[:player_choice]
  player_hit(game_info) if VALID_TURN_CHOICE[:hit].include?(player_choice)
  update_hand_scores(game_info)
end

def dealer_turn(game_info)
  reveal_dealer_hand(game_info)
  dealer_hit(game_info) if game_info[:dealer_hand_score] < DEALER_STAY
  sleep(1)
  update_hand_scores(game_info)
end

def player_turn_choice(game_info)
  choice = nil
  loop do
    prompt("Would you like to (H)it or (S)tand?")
    choice = gets.chomp.strip.downcase
    break if VALID_TURN_CHOICE.values.flatten.include?(choice)
    prompt("That's not a valid choice...")
  end
  game_info[:player_choice] = choice
end

def player_turn_over?(game_info)
  VALID_TURN_CHOICE[:stand].include?(game_info[:player_choice]) ||
    game_info[:player_hand_score] == TARGET_VALUE ||
    bust?(game_info[:player_hand])
end

def score_hand(hand)
  total = 0
  hand.each { |card| total += card[:points] }

  hand.select { |card| card[:value] == "A" }.count.times do
    total -= 10 if total > TARGET_VALUE
  end

  total
end

def blackjack?(hand)
  score_hand(hand) == TARGET_VALUE && hand.size == 2
end

def bust?(hand)
  score_hand(hand) > TARGET_VALUE
end

def update_hand_scores(game_info)
  game_info[:player_hand_score] = score_hand(game_info[:player_hand])
  game_info[:dealer_hand_score] = score_hand(game_info[:dealer_hand])
end

def determine_winner(game_info)
  if winning_hand?(game_info[:player_hand]) &&
     beats_opponent?(game_info[:player_hand], game_info[:dealer_hand])
    return "Player"
  elsif winning_hand?(game_info[:dealer_hand]) &&
        beats_opponent?(game_info[:dealer_hand], game_info[:player_hand])
    return "Dealer"
  end
  nil
end

def winning_hand?(hand)
  !bust?(hand) || blackjack?(hand)
end

def beats_opponent?(hand, opponent_hand)
  score_hand(hand) > score_hand(opponent_hand) || bust?(opponent_hand)
end

def update_chip_count(game_info, winner)
  if winner == "Player" && blackjack?(game_info[:player_hand])
    unless blackjack?(game_info[:dealer_hand])
      game_info[:player_chip_count] += (game_info[:player_bet] * 1.5).to_i
    end
  elsif winner == "Player"
    game_info[:player_chip_count] += game_info[:player_bet]
  elsif winner == "Dealer"
    game_info[:player_chip_count] -= game_info[:player_bet]
  end
end

def display_chip_count(game_info)
  prompt("")
  prompt("You have #{game_info[:player_chip_count]} chips left.")
end

def display_winner(game_info, winner)
  if blackjack?(game_info[:player_hand])
    prompt("Blackjack!!")
  elsif bust?(game_info[:player_hand])
    prompt("You busted!")
  elsif bust?(game_info[:dealer_hand])
    prompt("Dealer busted!")
  end

  if winner
    prompt("#{winner} wins!")
  else
    prompt("It's a tie!")
  end
end

def end_round(game_info)
  winner = determine_winner(game_info)
  display_winner(game_info, winner)
  update_chip_count(game_info, winner)
  sleep(1)
  display_chip_count(game_info)
end

def end_round_choice
  choice = nil
  loop do
    prompt("")
    prompt("Would you like to (C)ontinue or (W)alk away?")
    choice = gets.chomp.strip.downcase
    break if VALID_ROUND_OVER_CHOICE.values.flatten.include?(choice)
    prompt("That's not a valid choice...")
  end
  choice
end

def display_game_results(game_info)
  prompt("You walked away with #{game_info[:player_chip_count]} chips!") if
    game_info[:player_chip_count] > 0
  prompt("You ran out of chips!") if game_info[:player_chip_count] <= 0
end

def play_again_choice
  choice = nil
  loop do
    prompt("Would you like to play again? (Y / N)")
    choice = gets.chomp.strip.downcase
    break if VALID_YES_NO.values.flatten.include?(choice)
    prompt("That's not a valid choice...")
  end
  choice
end

def game_over?(game_info)
  VALID_ROUND_OVER_CHOICE[:walk].include?(game_info[:player_choice]) ||
    game_info[:player_chip_count] <= 0
end

welcome
explanation_choice = ask_for_explanation
display_explanation if
  VALID_YES_NO[:positive].include?(explanation_choice)

loop do # main loop
  game_info = {
    dealer_hand: [],
    player_hand: [],
    dealer_hand_score: 0,
    player_hand_score: 0,
    player_chip_count: 500,
    player_bet: 0,
    player_choice: '',
    current_deck: initialize_deck.shuffle
  }

  loop do
    clear_screen
    reset_hands_and_scores(game_info)
    game_info[:player_bet] = player_bet(game_info)

    deal_starting_hands(game_info)
    update_hand_scores(game_info)
    display_game_info(game_info)

    loop do
      display_game_info(game_info)
      break if blackjack?(game_info[:player_hand])
      player_turn(game_info)
      break if player_turn_over?(game_info)
    end

    unless bust?(game_info[:player_hand])
      loop do
        dealer_turn(game_info)
        break if game_info[:dealer_hand_score] >= DEALER_STAY
      end
    end

    reveal_dealer_hand(game_info)
    end_round(game_info)
    game_info[:player_choice] = end_round_choice if
      game_info[:player_chip_count] > 0
    break if game_over?(game_info)
  end

  clear_screen
  display_game_results(game_info)

  player_choice = play_again_choice
  break if VALID_YES_NO[:negative].include?(player_choice)
end

prompt("Thanks for playing!")
