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

VALID_TURN_CHOICE = {
    stand: ['s', 'stand'],
    hit: ['h', 'hit']
}

CARD_SUITS = {
    "S" => "♠",
    "D" => "♦",
    "C" => "♣",
    "H" => "♥"
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

def deal_starting_hands(dealer, player, deck)
    2.times { dealer << deck.pop }
    2.times { player << deck.pop }
end

def display_hands(dealer, player)
    clear_screen
    prompt("Dealer's Hand: #{dealer[0][0]}#{CARD_SUITS[dealer[0][1]]}" +
           " & ??")
    prompt("Your Hand: #{joinand(player)}")
    prompt("Your Total: #{score_hand(player)}")
end

def display_dealer_hand(dealer, player)
    clear_screen
    prompt("Dealer's Hand: #{joinand(dealer)}")
    prompt("Dealer's Total: #{score_hand(dealer)}")
    prompt("Your Hand: #{joinand(player)}")
    prompt("Your Total: #{score_hand(player)}")
end

def hit(hand, deck)
    hand << deck.pop
end

def player_turn(hand, deck)
    choice = nil
    loop do
        prompt("Would you like to (H)it or (S)tand?")
        choice = gets.chomp.strip.downcase        
        break if VALID_TURN_CHOICE.values.flatten.include?(choice)
        prompt("That's not a valid choice...")
    end
    choice
end

def score_hand(hand)
    total = 0
    hand.each do |card|
        if card[0] == "A"
            total += 11
        elsif card[0].to_i == 0 # Face Cards
            total += 10
        else
            total += card[0].to_i
        end
    end

    hand.select { |card| card[0] == "A" }.count.times do
        total -= 10 if total > 21
    end

    total
end

def bust?(hand)
    score_hand(hand) > 21
end

def determine_winner(player, dealer)
    if player <= 21 && (player > dealer || dealer > 21)
        return "Player"
    elsif dealer <= 21 && (dealer > player || player > 21)
        return "Computer"
    else
        return nil
    end
end

def display_winner(winner)
    if winner
        prompt("#{winner} wins!")
    else
        prompt("It's a tie!")
    end
end


loop do # main loop
    current_deck = DECK.shuffle
    dealer_hand = []
    player_hand = []
    player_total = 0
    dealer_total = 0

    deal_starting_hands(dealer_hand, player_hand, current_deck)

    display_hands(dealer_hand, player_hand)

    loop do
        display_hands(dealer_hand, player_hand)
        player_choice = player_turn(player_hand, current_deck)
        hit(player_hand, current_deck) if VALID_TURN_CHOICE[:hit].include?(player_choice)
        player_total = score_hand(player_hand)
        break if VALID_TURN_CHOICE[:stand].include?(player_choice) || bust?(player_hand)
    end

    loop do
        display_dealer_hand(dealer_hand, player_hand)
        hit(dealer_hand, current_deck) if score_hand(dealer_hand) < 17
        sleep(1)
        dealer_total = score_hand(dealer_hand)
        break if score_hand(dealer_hand) >= 17 || bust?(dealer_hand)
    end

    display_dealer_hand(dealer_hand, player_hand)

    winner = determine_winner(player_total, dealer_total)
    display_winner(winner)

    break
end
