require 'pry'

DECK = [["A", "D"], ["A", "C"], ["A", "H"], ["A", "S"],
        ["K", "D"], ["K", "C"], ["K", "H"], ["K", "S"],
        ["Q", "D"], ["Q", "C"], ["Q", "H"], ["Q", "S"],
        ["J", "D"], ["J", "C"], ["J", "H"], ["J", "S"],
        ["10", "D"], ["10", "C"], ["10", "H"], ["10", "S"],
        ["9", "D"], ["9", "C"], ["9", "H"], ["9", "S"],
        ["8", "D"], ["8", "C"], ["8", "H"], ["8", "S"],
        ["7", "D"], ["7", "C"], ["7", "H"], ["7", "S"],
        ["6", "D"], ["6", "C"], ["6", "H"], ["6", "S"],
        ["5", "D"], ["5", "C"], ["5", "H"], ["5", "S"],
        ["4", "D"], ["4", "C"], ["4", "H"], ["4", "S"],
        ["3", "D"], ["3", "C"], ["3", "H"], ["3", "S"],
        ["2", "D"], ["2", "C"], ["2", "H"], ["2", "S"]]

CARD_SUITS = {
  "S" => "♠",
  "D" => "♦",
  "C" => "♣",
  "H" => "♥"
}

DEALER_STAY = 17

VALID_TURN_CHOICE = {
  stand: ['s', 'st', 'stand'],
  hit: ['h', 'hi', 'hit']
}

VALID_ROUND_OVER_CHOICE = {
  continue: ['c', 'cont', 'continue'],
  walk: ['w', 'walk', 'walk away', 'walkaway', 'q', 'quit']
}

VALID_PLAY_AGAIN_CHOICE = {
  positive: ['y', 'yes'],
  negative: ['n', 'no']
}

def clear_screen
  system("clear")
end

def joinand(arr, separator=', ', last_separator=' & ')
  joined_arr = []
  arr.each do |sub_arr|
    str = sub_arr[0] + CARD_SUITS[sub_arr[1]]
    joined_arr << str
  end
  last_element = joined_arr.pop
  joined_arr[0] + last_separator + last_element unless joined_arr[1]
  joined_arr.join(separator) + last_separator + last_element
end

def prompt(message)
  puts("=> #{message}")
end

def reset_hands_and_scores(game_info)
  game_info[:dealer_hand] = []
  game_info[:player_hand] = []
  game_info[:player_hand_score] = 0
  game_info[:dealer_hand_score] = 0
  game_info[:current_deck] = DECK.shuffle
end

def player_bet(game_info)
  bet = 0
  chips = game_info[:player_chip_count]
  loop do
    prompt("You have #{chips} chips")
    prompt("How much would you like to bet? (1 - #{chips})")
    bet = gets.chomp.strip.to_i
    break if bet > 0 && bet <= chips
    prompt("That's not a valid bet...")
  end
  bet
end

def deal_starting_hands(game_info)
  2.times { game_info[:dealer_hand] << game_info[:current_deck].pop }
  2.times { game_info[:player_hand] << game_info[:current_deck].pop }
end

def display_game_info(game_info)
  clear_screen
  dealer_hand = game_info[:dealer_hand][0]
  prompt("----------------------")
  prompt("Dealer's Hand: #{dealer_hand[0]}#{CARD_SUITS[dealer_hand[1]]}" \
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

def score_hand(hand)
  total = 0
  hand.each do |card|
    total += if card[0] == "A"
               11
             elsif card[0].to_i == 0 # Face Cards
               10
             else
               card[0].to_i
             end
  end

  hand.select { |card| card[0] == "A" }.count.times do
    total -= 10 if total > 21
  end

  total
end

def blackjack?(hand)
  score_hand(hand) == 21 && hand.size == 2
end

def bust?(hand)
  score_hand(hand) > 21
end

def update_hand_scores(game_info)
  game_info[:player_hand_score] = score_hand(game_info[:player_hand])
  game_info[:dealer_hand_score] = score_hand(game_info[:dealer_hand])
end

def determine_winner(game_info)
  if winning_hand?(game_info[:player_hand]) &&
     beats_opponent?(game_info[:player_hand], game_info[:dealer_hand])
    "Player"
  elsif winning_hand?(game_info[:dealer_hand]) &&
        beats_opponent?(game_info[:dealer_hand], game_info[:player_hand])
    "Dealer"
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
  prompt("You have #{game_info[:player_chip_count]} chips left.")
end

def display_winner(game_info, winner)
  if winner == "Player" && blackjack?(game_info[:player_hand])
    if !blackjack?(game_info[:dealer_hand])
      prompt("Blackjack!!")
      prompt("#{winner} wins!")
    elsif winner == "Player" && bust?(game_info[:dealer_hand])
      prompt("Dealer busted!")
      prompt("#{winner} wins!")
    end
  elsif winner == "Dealer" && bust?(game_info[:player_hand])
    prompt("You busted!")
    prompt("#{winner} wins!")
  elsif winner
    prompt("#{winner} wins!")
  else
    prompt("It's a tie!")
  end
end

def play_again_choice
  choice = nil
  loop do
    prompt("Would you like to play again? (Y / N)")
    choice = gets.chomp.strip.downcase
    break if VALID_PLAY_AGAIN_CHOICE.values.flatten.include?(choice)
    prompt("That's not a valid choice...")
  end
  choice
end

loop do # main loop
  game_info = {
    dealer_hand: [],
    player_hand: [],
    dealer_hand_score: 0,
    player_hand_score: 0,
    player_chip_count: 500,
    player_bet: 0,
    player_choice: '',
    current_deck: DECK.shuffle
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
      break if VALID_TURN_CHOICE[:stand].include?(game_info[:player_choice]) ||
               game_info[:player_hand_score] == 21 ||
               bust?(game_info[:player_hand])
    end

    unless bust?(game_info[:player_hand])
      loop do
        dealer_turn(game_info)
        break if game_info[:dealer_hand_score] >= DEALER_STAY
      end
    end

    reveal_dealer_hand(game_info)

    winner = determine_winner(game_info)
    display_winner(game_info, winner)
    update_chip_count(game_info, winner)
    sleep(1)
    display_chip_count(game_info)
    player_choice = end_round_choice if game_info[:player_chip_count] > 0
    break if VALID_ROUND_OVER_CHOICE[:walk].include?(player_choice) ||
             game_info[:player_chip_count] <= 0
  end

  clear_screen
  prompt("You walked away with #{game_info[:player_chip_count]} chips!") if
    game_info[:player_chip_count] > 0
  prompt("You ran out of chips!") if game_info[:player_chip_count] <= 0

  player_choice = play_again_choice
  break if VALID_PLAY_AGAIN_CHOICE[:negative].include?(player_choice)
end

prompt("Thanks for playing!")
