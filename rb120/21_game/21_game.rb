def prompt(message)
  puts "=> #{message}"
end

module DisplayMethods
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

  def clear
    system('clear')
  end

  def welcome_message
    clear
    puts "Welcome to Ruby BlackJack (OOP Version)!"
    puts ""
    display_explanation if ask_for_explanation
  end

  def ask_for_explanation
    choice = nil
    loop do
      prompt("Would you like an explanation? (Y / N)")
      choice = gets.chomp.strip.downcase
      break if %w(y n yes no).include?(choice)
      prompt("Sorry, I didnt catch that...")
    end
    choice == 'y' || choice == 'yes'
  end

  def display_explanation
    clear
    puts(EXPLANATION)
    puts("")
    prompt("Ready to start? Press [Enter] to play!")
    gets
  end

  def show_result
    if human.blackjack?
      prompt("You got blackjack! You win!")
    elsif dealer.blackjack?
      prompt("Dealer got blackjack! Dealer wins!")
    elsif human.busted?
      prompt("You busted! Dealer wins!")
    elsif dealer.busted?
      prompt("Dealer busted! You win!")
    elsif human.hand.total > dealer.hand.total
      prompt("You win!")
    elsif dealer.hand.total > human.hand.total
      prompt("Dealer wins!")
    else
      prompt("It's a tie!")
    end
    puts ""
    sleep(1)
  end

  def goodbye_message
    prompt("You left the game with #{human.chips} chips!")
    prompt("Thanks for playing BlackJack! Goodbye!")
  end
end

module Displayable
  def display(last_card_hidden=false)
    if !last_card_hidden
      show_full_hand
    else
      hide_last_card
    end
  end

  private

  def show_full_hand
    puts "======================================"
    create_top_line
    create_val_line
    create_suit_line
    puts "======================================"
    puts "Hand Score: #{total}"
    puts ""
  end

  def hide_last_card
    puts "======================================"
    create_top_line
    create_val_line(true)
    create_suit_line(true)
    puts "======================================"
    puts "Hand Score: ??"
    puts ""
  end

  def create_top_line
    top_line = ""
    cards.size.times do
      top_line += "+----"
    end
    top_line += "--+"
    puts top_line
  end

  def create_val_line(hidden=false)
    val_line = ""
    if !hidden
      cards.each { |card| val_line += "|#{card.rank}".ljust(5) }
      val_line += '  |'
    else
      val_line += "|#{first.rank}".ljust(5)
      val_line += '|XXXXXX|'
    end
    puts val_line
  end

  def create_suit_line(hidden=false)
    suit_line = ""
    if !hidden
      cards.each { |card| suit_line += "|#{card.symbol}".ljust(5) }
      suit_line += '  |'
    else
      suit_line += "|#{first.symbol}".ljust(5)
      suit_line += '|XXXXXX|'
    end
    puts suit_line
  end
end

class Hand
  include Displayable

  attr_accessor :cards, :total

  def initialize
    @cards = []
    @total = 0
  end

  def update_total
    self.total = cards.reduce { |total, card| total + card.point_value }
    cards.select { |card| card.rank == "A" }.count.times do
      self.total -= 10 if self.total > Game::TARGET_VALUE
    end
  end

  def <<(card)
    cards << card
  end

  def first
    @cards[0]
  end

  def to_s
    cards.map(&:to_s).to_s
  end
end

class Participant
  attr_reader :hand, :name, :hand_hidden

  def hit(card)
    @hand << card
    @hand.update_total if hand.cards.size >= 2
  end

  def busted?
    hand.total > 21
  end

  def blackjack?
    hand.cards.size == 2 && hand.total == 21
  end

  def reset
    @hand = Hand.new
  end
end

class Player < Participant
  attr_accessor :chips, :bet

  def initialize
    @name = choose_name
    @hand = Hand.new
    @hand_hidden = false
    @chips = 500
    @bet = 0
  end

  def choose_name
    name = nil
    loop do
      prompt("Please enter your name:")
      name = gets.chomp.strip
      break unless name.empty?
      prompt("Invalid entry...")
    end
    name
  end
end

class Dealer < Participant
  attr_accessor :hand_hidden

  def initialize
    @name = 'Dealer'
    @hand = Hand.new
    @hand_hidden = true
  end

  def reset
    @hand_hidden = true
    super
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(J Q K A)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :cards

  def initialize
    refill
  end

  def draw
    @cards.pop
  end

  def deal_card(player)
    player.hit(draw)
  end

  private

  def refill
    @cards = RANKS.each_with_object([]) do |rank, arr|
      SUITS.each do |suit|
        arr << Card.new(rank, suit)
      end
    end.shuffle
  end
end

class Card
  FACE = ['J', 'Q', 'K']
  CARD_SYMBOLS = { "Spades" => "♠",
                   "Diamonds" => "♦",
                   "Clubs" => "♣",
                   "Hearts" => "♥" }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @points = point_value
  end

  def symbol
    CARD_SYMBOLS[suit]
  end

  def to_s
    "#{rank}#{CARD_SYMBOLS[suit]}"
  end

  def +(card)
    point_value + card
  end

  def point_value
    case rank
    when (2..10) then rank
    when *FACE then 10
    when 'A' then 11
    end
  end
end

class Game
  DEALER_STAY = 17
  TARGET_VALUE = 21

  include DisplayMethods

  attr_reader :human, :dealer, :players, :deck

  def initialize
    welcome_message
    @human = Player.new
    @dealer = Dealer.new
    @players = [dealer, human]
    @deck = Deck.new
  end

  def start
    loop do
      play_round
      break if human.chips == 0
      break unless play_again?
      reset_game
    end
    goodbye_message
  end

  private

  def reset_game
    @deck = Deck.new
    human.reset
    dealer.reset
  end

  def play_round
    player_bet
    deal_starting_hands
    display_cards
    player_turn
    dealer_turn
    show_result
    update_chip_count
  end

  def player_bet
    clear
    human.bet = ask_for_bet
  end

  def ask_for_bet
    bet = nil
    loop do
      prompt("You have #{human.chips} chips. " \
             "How many would you like to bet? (1 - #{human.chips})")
      bet = gets.chomp
      break if (1..human.chips).include?(bet.to_i) && bet == bet.to_i.to_s
      prompt("That's not a valid bet...")
    end
    bet.to_i
  end

  def deal_starting_hands
    2.times do
      players.each { |player| deck.deal_card(player) }
    end
  end

  def display_cards
    clear
    players.each do |player|
      puts "#{player.name}'s Hand:"
      if player.hand_hidden
        player.hand.display(true)
      else
        player.hand.display
      end
    end
  end

  def player_turn
    move = nil
    loop do
      display_cards
      break if human.blackjack?
      move = player_choice
      deck.deal_card(human) if move == 'h'
      break if human.busted? || move == 's'
    end
    display_cards
  end

  def player_choice
    move = nil
    loop do
      prompt("Would you like to (h)it or (s)tand?")
      move = gets.chomp.downcase
      break if %w(h s).include?(move)
      prompt("Invalid choice...")
    end
    move
  end

  def dealer_turn
    dealer.hand_hidden = false
    unless human.busted? || human.blackjack?
      loop do
        display_cards
        prompt("Dealer's Turn...")
        break if dealer.busted? || dealer.hand.total >= DEALER_STAY
        deck.deal_card(dealer)
        sleep(1)
      end
    end
    display_cards
  end

  def update_chip_count
    if human.blackjack?
      human.chips += (human.bet * 1.5).to_i unless dealer.blackjack?
    elsif loser
      lose_bet
    elsif winner
      win_bet
    end
  end

  def winner
    dealer.busted? ||
      (human.hand.total > dealer.hand.total && !human.busted?)
  end

  def loser
    human.busted? ||
      dealer.blackjack? ||
      (dealer.hand.total > human.hand.total && !dealer.busted?)
  end

  def win_bet
    human.chips += human.bet
  end

  def lose_bet
    human.chips -= human.bet
  end

  def play_again?
    answer = nil
    prompt("You have #{human.chips} chips left.")
    loop do
      prompt("Would you like to play again? (y/n)")
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      prompt("Invalid choice...")
    end
    answer == 'y'
  end
end

Game.new.start
