class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :cards

  def initialize
    refill
  end

  def refill
    @cards = RANKS.each_with_object([]) do |rank, arr|
      SUITS.each do |suit|
        arr << Card.new(rank, suit)
      end
    end.shuffle
  end

  def shuffle
    @cards.shuffle!
  end

  def draw
    refill if @cards.empty?
    @cards.pop
  end

  def cards_left
    @cards.size
  end
end

class Card
  attr_reader :rank, :suit, :value, :suit_value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = get_value
    @suit_value = get_suit_value
  end

  def get_value
    case rank
    when (1..10) then rank.to_i
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    end
  end

  def get_suit_value
    case suit
    when 'Spades' then 1
    when 'Hearts' then 2
    when 'Clubs' then 3
    when 'Diamonds' then 4
    end
  end

  def <=>(other_card)
    if self.value == other_card.value
      return self.suit_value <=> other_card.suit_value
    else
      return self.value <=> other_card.value
    end
  end

  def ==(other_card)
    self.rank == other_card.rank
  end

  def to_s
    "#{rank} of #{suit}"
  end

end

# Include Card and Deck classes from the last two exercises.

class PokerHand
  attr_reader :hand

  def initialize(deck)
    @hand = []
    5.times { hand << deck.draw }
  end

  def print
    puts hand
  end

  def evaluate
    hand.sort!
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  def to_s
    hand.map { |card| card.to_s }
  end

  private

  def royal_flush?
    return false unless hand.all? { |card| card.suit == hand.first.suit && [10, 'Jack', 'Queen', 'King', 'Ace'].include?(card.rank) }
    true
  end

  def straight_flush?
    return false unless hand.all? { |card| card.suit == hand.first.suit }
    1.upto(4) do |idx|
      return false unless hand[idx].value == hand[idx-1].value + 1
    end
    true
  end

  def four_of_a_kind?
    values = hand.map { |card| card.value }
    values.any? { |value| values.count(value) == 4 }
  end

  def full_house?
    values = hand.map { |card| card.value }
    values.any? { |value| values.count(value) == 3 } &&
    values.any? { |value| values.count(value) == 2 }
  end

  def flush?
    return false unless hand.all? { |card| card.suit == hand[0].suit }
    true
  end

  def straight?
    1.upto(4) do |idx|
      return false unless hand[idx].value == hand[idx-1].value + 1
    end
    true
  end

  def three_of_a_kind?
    values = hand.map { |card| card.value }
    values.any? { |value| values.count(value) == 3 }
  end

  def two_pair?
    values = hand.map { |card| card.value }
    values.select { |val| values.count(val) == 2 }.uniq.size == 2
  end

  def pair?
    values = hand.map { |card| card.value }
    values.any? { |val| values.count(val) == 2 }
  end

end

deck = Deck.new

hand = PokerHand.new(deck)

hand.print
puts hand.evaluate
