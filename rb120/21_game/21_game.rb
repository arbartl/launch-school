module Displayable
  def display
    puts "===================================="
    create_top_line
    create_val_line
    create_suit_line
    puts "===================================="
    puts "Hand Score: #{self.total}"
    puts ""
  end

  def create_top_line
    top_line = ""
    self.cards.size.times do
      top_line += "+----"
    end
    top_line += "--+"
    puts top_line
  end

  def create_val_line
    val_line = ""
    self.cards.each do |card|
      val_line += "|#{card.rank}".ljust(5)
    end
    val_line += '  |'
    puts val_line
  end

  def create_suit_line
    suit_line = ""
    self.cards.each do |card|
      suit_line += "|#{card.symbol}".ljust(5)
    end
    suit_line += '  |'
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
  end

  def <<(card)
    cards << card
  end

  def to_s
    cards.map(&:to_s).to_s
  end
end

class Participant
  attr_reader :hand, :name
  # what goes in here? all the redundant behaviors from Player and Dealer?

  def hit(card)
    @hand << card
    @hand.update_total
  end

  def stay
  end

  def busted?
    hand.total > 21
  end
end

class Player < Participant
  def initialize
    @name = choose_name
    @hand = Hand.new   
  end

  def choose_name
    name = nil
    loop do
      puts "Please enter your name:"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Invalid entry..."
    end
    name
  end
end

class Dealer < Participant
  def initialize
    @name = 'Dealer'
    @hand = Hand.new
  end

  def deal
    # does the dealer or the deck deal?
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

  def cards_left
    @cards.size
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
                   "Hearts" => "♥"}

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @points = point_value
  end

  def symbol
    CARD_SYMBOLS[self.suit]
  end

  def to_s
    "#{rank}#{CARD_SYMBOLS[suit]}"
  end

  def +(card)
    self.point_value + card
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
  attr_reader :human, :dealer, :players, :deck

  def initialize
    @human = Player.new
    @dealer = Dealer.new
    @players = [dealer, human]
    @deck = Deck.new
  end

  def start
    deal_starting_hands
    show_initial_cards
    human.hit(deck.draw)
    sleep(1)
    show_initial_cards
    #player_turn
    #dealer_turn
    #show_result
  end

  private

  def deal_starting_hands
    2.times do
      players.each { |player| deck.deal_card(player) }
    end
  end

  def show_initial_cards
    system('clear')
    players.each do |player|
      puts "#{player.name}'s Hand:"
      player.hand.display
    end
  end
end

Game.new.start
