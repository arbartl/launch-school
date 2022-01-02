class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def add_point
    self.score += 1
  end

  def show_score
    "#{self.name}: #{self.score} points"
  end

end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "\n=> What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a name!"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "=> Please choose Rock, Paper, Scissors, Lizard, or Spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', "Chappie", "Sonny", "Number 5"].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.spock? || other_move.paper?)) ||
      (spock? && (other_move.rock? || other_move.scissors?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.scissors? || other_move.rock?)) ||
      (spock? && (other_move.lizard? || other_move.paper?))
  end

  def to_s
    @value
  end
end

class Round
  attr_accessor :winner

  @@number = 0

  def initialize
    @winner = nil
    @@number += 1
  end

  def self.number
    @@number
  end

  def self.reset_rounds
    @@number = 0
  end

end

# Game Engine

class RPSGame
  attr_accessor :human, :computer, :round, :history

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    @points_to_win = points_to_win
    @history = []
    Round.reset_rounds
  end

  def clear_screen
    system('clear')
  end

  def points_to_win
    points = 0
    loop do
      puts "\n=> How many points do you want to play to? (1-10)"
      points = gets.chomp.to_i
      break if (1..10).include?(points)
      puts "That's not a valid choice..."
    end
    points
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def start_round
    @round = Round.new
  end

  def display_round_info
    clear_screen
    puts "Round number: #{Round.number}"
    puts "======================================================="
    display_scores
    puts "-------------------------------------------------------"
    puts "First to #{@points_to_win} points wins!"
    puts "======================================================="
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose: #{human.move}"
    puts "#{computer.name} chose: #{computer.move}"
  end

  def determine_winner
    if human.move > computer.move
      round.winner = human
    elsif computer.move > human.move
      round.winner = computer
    else
      round.winner = nil
    end
  end

  def award_point(winner)
    if winner
      winner.add_point
    end
  end

  def display_winner
    if round.winner
      puts "#{round.winner.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    puts human.show_score
    puts computer.show_score
  end

  def update_history
    player = human.name
    player_move = human.move.value
    comp = computer.name
    comp_move = computer.move.value
    winner = round.winner ? round.winner.name : "None"
    history << {round: Round.number, player => player_move, comp => comp_move, winner: winner}
  end

  def process_round
    display_moves
    sleep(0.5)
    determine_winner
    award_point(round.winner)
    display_winner
    sleep(1.5)
    update_history
  end

  def game_winner?
    (human.score == @points_to_win) ||
      (computer.score == @points_to_win)
  end

  def display_game_history
    history.each do |hsh|
      puts "Round: #{hsh[:round]} -- #{human.name}: #{hsh[human.name]} -- #{computer.name}: #{hsh[computer.name]} -- Winner: #{hsh[:winner]}"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "\n=> Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be 'y' or 'n'."
    end
    answer == 'y'
  end

  def play    
    loop do
      start_round
      display_round_info
      human.choose
      computer.choose
      process_round
      break if game_winner?
    end
    display_game_history
    #display_game_winner
  end
end

new_game = nil
loop do
  new_game = RPSGame.new
  new_game.play
  break unless new_game.play_again?
end

new_game.display_goodbye_message
