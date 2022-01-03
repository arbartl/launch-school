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
      puts "=> Please choose (R)ock, (P)aper, (S)cissors, (L)izard, or (Sp)ock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.create(choice)
  end
end

class Computer < Player
  OPPONENTS = ['R2D2', 'Hal', "Chappie", "Sonny", "Number 5"]

  def set_name
    2.times do
      OPPONENTS.shuffle.each do |name|
        puts "\n=> Choosing Opponent: #{name}"
        sleep(0.25)
        system('clear')
      end
    end
    self.name = OPPONENTS.sample
    puts "\n=> Choosing Opponent: #{name}"
    sleep(1)
  end

  def choose
    self.move = Move.create(Move::VALUES.keys.sample)
  end

  def show_score
    "#{self.name} (CPU): #{self.score} points"
  end
end

class Move
  VALUES = {'r' => 'rock',
            'p' => 'paper',
            's' => 'scissors',
            'l' => 'lizard',
            'sp' => 'spock'
  }

  attr_reader :value, :beats

  def >(other_move)
    self.class::BEATS.include?(other_move.value)
  end

  def self.create(type)
    case type
    when 'r' then Rock.new
    when 'p' then Paper.new
    when 's' then Scissors.new
    when 'l' then Lizard.new
    when 'sp' then Spock.new
    end
  end

  def to_s
    @value
  end
end

class Rock < Move
  BEATS = ['scissors', 'lizard']
  def initialize
    @value = 'rock'
  end
end

class Paper < Move
  BEATS = ['rock', 'spock']
  def initialize
    @value = 'paper'
  end
end

class Scissors < Move
  BEATS = ['paper', 'lizard']
  def initialize
    @value = 'scissors'
  end
end

class Lizard < Move
  BEATS = ['paper', 'spock']
  def initialize
    @value = 'lizard'
  end
end

class Spock < Move
  BEATS = ['rock', 'scissors']
  def initialize
    @value = 'spock'
  end
end

class Round
  attr_accessor :winner, :loser

  @@number = 0

  def initialize
    @winner = nil
    @loser = nil
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
  attr_accessor :human, :computer, :round, :round_history

  def initialize
    display_welcome_message
    @human = Human.new
    @points_to_win = points_to_win
    @computer = Computer.new    
    @round_history = []
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
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose: #{human.move}"
    sleep(0.5)
    puts "#{computer.name} chose: #{computer.move}"
  end

  def determine_winner
    if human.move > computer.move
      round.winner, round.loser = human, computer
    elsif computer.move > human.move
      round.winner, round.loser = computer, human
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
      puts ""
      puts "#{round.winner.move} beats #{round.loser.move}!"
      puts "#{round.winner.name} wins!"
    else
      puts ""
      puts "It's a tie!"
    end
    puts ""

    unless game_winner?
      puts "Press [Enter] to start next round..."
      ready = gets.chomp
    end
  end

  def display_scores
    puts human.show_score
    puts computer.show_score
  end

  def update_history
    winner = round.winner ? round.winner.name : "Tie"
    round_history << {round: Round.number,
                      human.name => human.move.value,
                      computer.name => computer.move.value,
                      winner: winner
    }
  end

  def process_round
    display_moves
    determine_winner
    award_point(round.winner)
    display_winner
    update_history
  end

  def game_winner?
    (human.score == @points_to_win) ||
      (computer.score == @points_to_win)
  end

  def display_game_history
    puts "Match History:"
    puts "=============="
    round_history.each do |hsh|
      puts "Round: #{hsh[:round]} -- #{human.name}: #{hsh[human.name]} -- #{computer.name}: #{hsh[computer.name]} -- Winner: #{hsh[:winner]}"
    end
  end

  def display_game_winner
    winner = human.score == @points_to_win ? human : computer
    puts ""
    puts "#{winner.name} wins the match!"
    puts ""
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
    display_game_winner
  end
end

new_game = nil

loop do
  new_game = RPSGame.new
  new_game.play
  break unless new_game.play_again?
end

new_game.display_goodbye_message
