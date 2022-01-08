module DisplayUtil
  def clear
    system('clear')
  end

  def prompt(message)
    puts "=> #{message}"
  end
end

module ScreenDisplay
  include DisplayUtil

  EXPLANATION = <<-MSG
   You will start the game with 500 chips to use (aren't we generous?).
   You will be asked to place a bet before each round.

   You and the dealer will each be dealt 2 cards. You will only see one 
   of the dealer's cards. The goal is to reach 21 points without going
   over (busting). You can continue drawing cards (hit) to improve your
   score. You also have the option to double down after your cards are
   dealt. This will double your bet and you will only get one more card.
   
   After you decide to keep your hand (stay), the dealer will go.
 
   The dealer will reveal their other card, and decide to hit or stay.
   The dealer MUST hit if they have less than 17 points. After the dealer
   stays, your scores will be compared.
   
   Aces are worth 1 or 11 points, Face Cards are worth 10 points, and all
   other cards are worth their face value.
   
   If you have an Ace and a Face Card as your dealt hand, you have a
   Blackjack and automatically win, unless the dealer also does. If you
   get Blackjack, you get one and a half times your bet back!  
  MSG

  WELCOME = <<-MSG
            Welcome to Ruby BlackJack (OOP Version)!


                        +------+
                        |A     |
                        |♠   +------+
                        |    |K     |
                        |    |♠     |
                        |    |      |
                        +----|     ♠|
                             |     K|
                             +------+

  MSG

  def welcome_message
    clear
    puts(WELCOME)
    puts ""
    display_explanation if ask_for_explanation
  end

  def joinor(arr, separator=', ', last_separator='or')
    return arr[0].to_s if !arr[1]
    arr[0...-1].join(separator) + " #{last_separator} " + arr[-1].to_s
  end

  def ask_for_explanation
    choice = nil
    loop do
      prompt("Would you like an explanation of the rules? (Y/N)")
      choice = gets.chomp.strip.downcase
      break if %w(y n yes no).include?(choice)
      prompt("Sorry, I didnt catch that...")
    end
    clear
    %w(y yes).include?(choice)
  end

  def display_explanation
    clear
    puts(EXPLANATION)
    puts("")
    prompt("Ready to start? Press [Enter] to play!")
    gets
    clear
  end

  def show_result
    puts ""
    if anyone_blackjack?
      show_blackjack
    elsif anyone_busted?
      show_busted
    else
      show_high_hand
    end
    sleep(1)
  end

  def show_blackjack
    if player.blackjack?
      prompt("You got blackjack! You win!")
    elsif dealer.blackjack?
      prompt("Dealer got blackjack! Dealer wins!")
    end
  end

  def show_busted
    if player.busted?
      prompt("You busted! Dealer wins!")
    elsif dealer.busted?
      prompt("Dealer busted! You win!")
    end
  end

  def show_high_hand
    if player.hand.total > dealer.hand.total
      prompt("You win!")
    elsif dealer.hand.total > player.hand.total
      prompt("Dealer wins!")
    else
      prompt("It's a tie!")
    end
  end

  def goodbye_message
    prompt("You left the game with #{player.chips} chips!")
    prompt("Thanks for playing BlackJack! Goodbye!")
  end
end

module HandDisplay
  def display(last_card_hidden=false)
    if !last_card_hidden
      show_full_hand
    else
      hide_last_card
    end
  end

  private

  def show_full_hand
    puts "  ======================================"
    create_top_line
    create_val_line
    create_suit_line
    puts "  ======================================"
    puts "  Hand Score: #{total}"
  end

  def hide_last_card
    puts "  ======================================"
    create_top_line
    create_val_line(true)
    create_suit_line(true)
    puts "  ======================================"
    puts "  Hand Score: ??"
  end

  def create_top_line
    top_line = "  "
    cards.size.times do
      top_line += "+----"
    end
    top_line += "--+"
    puts top_line
  end

  def create_val_line(hidden=false)
    val_line = "  "
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
    suit_line = "  "
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
  include HandDisplay

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
  include DisplayUtil

  attr_accessor :bet, :chips
  attr_reader :move

  def initialize
    @name = nil
    @hand = Hand.new
    @hand_hidden = false
    @chips = 500
    @bet = 0
  end

  def choose_name
    loop do
      prompt("Please enter your name:")
      @name = gets.chomp.strip
      break unless @name.empty?
      prompt("Invalid entry...")
    end
  end

  def double_down(card)
    @hand << card
    @hand.update_total
    @bet *= 2
  end

  def move_options
    if hand.cards.size == 2 && (bet * 2 <= chips)
      ['(h)it', '(s)tand', '(d)ouble down']
    else
      %w((h)it (s)tand)
    end
  end

  def move=(option)
    if %w(h s d dd).include?(option)
      @move = option
    else
      case option
      when 'hit' then @move = 'h'
      when 'stand' then @move = 's'
      when 'double' then @move = 'd'
      when 'double-down' then @move = 'd'
      end
    end
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

  include ScreenDisplay

  attr_reader :player, :dealer, :players, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @players = [dealer, player]
    @deck = Deck.new
  end

  def start
    welcome_message
    player.choose_name
    loop do
      play_round
      break if player.chips == 0
      break unless play_again?
      reset_game
    end
    goodbye_message
  end

  private

  def reset_game
    @deck = Deck.new
    player.reset
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
    player.bet = ask_for_bet
  end

  def ask_for_bet
    bet = nil
    loop do
      prompt("You have #{player.chips} chips. " \
             "How many would you like to bet? (1 - #{player.chips})")
      bet = gets.chomp
      break if (1..player.chips).include?(bet.to_i) && bet == bet.to_i.to_s
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
      puts ""
      puts "  #{player.name}'s Hand:"
      player.hand_hidden ? player.hand.display(true) : player.hand.display
    end
    puts ""
    puts "  Your chips: #{player.chips} -- Your bet: #{player.bet}"
  end

  def player_turn
    loop do
      display_cards
      break if player.blackjack?
      process_player_move
      break if player.busted? ||
               player.hand.total == TARGET_VALUE ||
               %w(s d dd).include?(player.move)
    end
    display_cards
  end

  def player_choice
    options = player.move_options
    short_valid = %w(h s hit stand)
    long_valid = %w(h s d dd hit stand double double-down)
    loop do
      player_move_request(options)
      break if (short_valid.include?(player.move) && options.size == 2) ||
               (long_valid.include?(player.move) && options.size == 3)
      prompt("Invalid choice...")
    end
  end

  def player_move_request(options)
    puts ""
    prompt("Would you like to #{joinor(options)}?")
    player.move = gets.chomp.downcase
  end

  def process_player_move
    player_choice
    deck.deal_card(player) if player.move == 'h'
    player.double_down(deck.draw) if %w(d dd).include?(player.move)
  end

  def dealer_turn
    dealer.hand_hidden = false
    unless player.busted? || player.blackjack?
      process_dealer_turn
    end
    display_cards
  end

  def process_dealer_turn
    loop do
      display_cards
      puts ""
      prompt("Dealer's Turn...")
      break if dealer.busted? || dealer.hand.total >= DEALER_STAY
      deck.deal_card(dealer)
      sleep(1)
    end
  end

  def update_chip_count
    if player.blackjack?
      player.chips += (player.bet * 1.5).to_i unless dealer.blackjack?
    elsif loser?
      lose_bet
    elsif winner?
      win_bet
    end
  end

  def anyone_busted?
    player.busted? || dealer.busted?
  end

  def anyone_blackjack?
    player.blackjack? || dealer.blackjack?
  end

  def winner?
    dealer.busted? ||
      (player.hand.total > dealer.hand.total && !player.busted?)
  end

  def loser?
    player.busted? ||
      dealer.blackjack? ||
      (dealer.hand.total > player.hand.total && !dealer.busted?)
  end

  def win_bet
    player.chips += player.bet
  end

  def lose_bet
    player.chips -= player.bet
  end

  def play_again?
    answer = nil
    puts ""
    prompt("You have #{player.chips} chips left.")
    loop do
      prompt("Would you like to play again? (y/n)")
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      prompt("Invalid choice...")
    end
    %w(y yes).include?(answer)
  end
end

Game.new.start
