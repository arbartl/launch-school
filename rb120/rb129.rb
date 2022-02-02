module Armor
  def attach_armor
  end

  def remove_armor
  end
end

module Spells
  def cast_spell(spell)
  end
end

class Player
  attr_reader :name, :health, :strength, :intelligence

  def initialize(name)
    @name = name
    @health = 100
    @strength = roll_dice(2, 12)
    @intelligence = roll_dice(2, 12)
  end

  def heal(value)
    self.health += value
  end

  def hurt(value)
    self.health -= value
  end

  def to_s
    "Name: #{name}\nClass: #{self.class}\nHealth: #{health}\nStrength: #{strength}\nIntelligence: #{intelligence}"
  end

  private

  attr_writer :health

  def roll_dice(low, high)
    (low..high).to_a.sample
  end
end

class Warrior < Player
  include Armor

  def initialize(name)
    super(name)
    @strength += 2
  end
end

class Paladin < Player
  include Armor
  include Spells
end

class Magician < Player
  include Spells

  def initialize(name)
    super(name)
    @intelligence += 2
  end
end

class Bard < Player
  include Spells

  def create_potion
  end
end

john = Bard.new("John")
puts john
john.hurt(20)
puts john
john.heal(30)
puts john