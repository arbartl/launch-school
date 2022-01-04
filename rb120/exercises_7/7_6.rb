class GuessingGame
  attr_accessor :guesses, :current_guess
  attr_reader :number, :range, :min, :max, :max_guesses

  def initialize(min, max)
    @min = min
    @max = max
    @range = (min..max)
    @max_guesses = Math.log2(max-min).to_i + 1
  end

  def play
    loop do
      generate_number
      self.guesses = max_guesses

      while guesses > 0
        display_guesses_remaining
        get_player_guess
        display_guess_result
        decrement_guesses
        break if correct_guess?
      end
      display_result
      break unless play_again?
    end   
  end

  private

  def generate_number
    @number = rand(range)
  end

  def display_guesses_remaining
    puts "You have #{guesses} guesses remaining."
  end

  def get_player_guess
    loop do
      puts "Enter a number between #{min} and #{max}:"
      self.current_guess = gets.chomp
      break if current_guess.to_i.to_s == current_guess && range.include?(current_guess.to_i)
      puts "Invalid guess."
    end
  end

  def display_guess_result
    puts "Your guess is too low." if current_guess.to_i < number
    puts "Your guess is too high." if current_guess.to_i > number
    puts ""
  end

  def decrement_guesses
    self.guesses -= 1
  end

  def correct_guess?
    current_guess.to_i == number
  end

  def display_result
    if current_guess.to_i == number
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Play again? (y/n)"
      answer = gets.chomp
      break if ['y','n'].include?(answer)
      puts "Invalid choice..."
    end
    answer == 'y'
  end
end

game = GuessingGame.new(501, 1500)
game.play