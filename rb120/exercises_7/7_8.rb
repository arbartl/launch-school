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

p Card.new(3, 'Diamonds') <=> Card.new(3, 'Diamonds')
