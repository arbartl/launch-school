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

  @@match_wins = 0

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

  def self.match_point
    @@match_wins += 1
  end

  def self.match_wins
    @@match_wins
  end

end

class Computer < Player
  OPPONENTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
  @@match_wins = 0

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

  def self.match_point
    @@match_wins += 1
  end

  def self.match_wins
    @@match_wins
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
  attr_accessor :winner, :loser, :points_to_win

  @@number = 0
  @@history = []

  def initialize
    @winner = nil
    @loser = nil
    @@number += 1
  end

  def update_history(human, computer)
    winner = self.winner ? self.winner.name : "Tie"
    Round.history << {round: Round.number,
                      human.name => human.move.value,
                      computer.name => computer.move.value,
                      winner: winner
    }
  end

  def self.number
    @@number
  end

  def self.history
    @@history
  end
  
  def self.reset_round
    @@number = 0
    @@history = []
  end

end

class Match
  attr_reader :points_to_win, :winner, :loser
  @@history = []
  @@number = 0

  def initialize
    @points_to_win = determine_points
    @@number += 1
  end

  def self.number
    @@number
  end

  def self.history
    @@history
  end

  def determine_points
    points = 0
    loop do
      puts "\n=> How many points do you want to play to? (1-10)"
      points = gets.chomp
      break if (1..10).include?(points.to_i) && points == points.to_i.to_s
      puts "That's not a valid choice..."
    end
    Display.clear_screen
    points.to_i
  end

  def update_history(human, computer)
    Match.history << {match: Match.number,
                      human.name => Human.match_wins,
                      :cpu => Computer.match_wins
    }
  end

end

class Display

  def self.clear_screen
    system('clear')
  end

  def clear_screen
    system('clear')
  end

  def welcome_message
    clear_screen
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def round_info(info)
    clear_screen
    puts "Round number: #{Round.number}"
    puts "======================================================="
    scores(info[:human], info[:computer])
    puts "-------------------------------------------------------"
    puts "First to #{info[:match].points_to_win} points wins!"
    puts "======================================================="
    puts ""
  end

  def scores(human, computer)
    puts human.show_score
    puts computer.show_score
  end

  def moves(human, computer)
    puts "#{human.name} chose: #{human.move}"
    sleep(0.5)
    puts "#{computer.name} chose: #{computer.move}"
  end

  def round_winner(round)
    if round.winner
      puts ""
      puts "#{round.winner.move} beats #{round.loser.move}!"
      puts "#{round.winner.name} wins!"
    else
      puts ""
      puts "It's a tie!"
    end
    puts ""
  end

  def next_round
    puts "Press [Enter] to start next round..."
    ready = gets
  end

  def round_history(human, computer)
    puts "Round History:"
    puts "=============="
    Round.history.each do |hsh|
      puts "Round: #{hsh[:round]} -- #{human.name}: #{hsh[human.name]} -- #{computer.name}: #{hsh[computer.name]} -- Winner: #{hsh[:winner]}"
    end
  end

  def match_history(human, computer)
    puts "Match History:"
    puts "=============="
    Match.history.each do |hsh|
      puts "Match: #{hsh[:match]} -- #{human.name}: #{hsh[human.name]} -- CPU: #{hsh[:cpu]}"
    end
  end

  def match_winner(winner)
    puts ""
    puts "#{winner.name} wins the match!"
    puts ""
  end

  def goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

end

# Game Engine

class RPSGame
  attr_accessor :human, :computer, :match, :round, :display

  def initialize
    @display = Display.new
    display.welcome_message
    @human = Human.new
  end

  def start_match
    @match = Match.new
    Round.reset_round
    @computer = Computer.new
    @info = { human: @human, computer: @computer, match: @match, round: @round }
  end

  def start_round
    @round = Round.new    
  end

  def choose_moves
    human.choose
    computer.choose
  end

  def determine_round_winner
    if human.move > computer.move
      round.winner, round.loser = human, computer
    elsif computer.move > human.move
      round.winner, round.loser = computer, human
    else
      round.winner = nil
    end
  end

  def determine_match_winner
    human.score == match.points_to_win ? human : computer
  end

  def process_round
    display.moves(human, computer)
    determine_round_winner
    round.winner.add_point if round.winner
    display.round_winner(round)
    round.update_history(human, computer)
  end

  def game_winner?
    (human.score == match.points_to_win) ||
      (computer.score == match.points_to_win)
  end

  def award_match_point(winner)
    winner.class.match_point
  end

  def play_again?
    answer = nil
    loop do
      puts "\n=> Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(answer)
      puts "Sorry, must be 'y' or 'n'."
    end
    display.clear_screen
    answer == 'y' || answer == 'yes'
  end

  def play
    loop do
      start_match
      loop do
        start_round
        display.round_info(@info)
        choose_moves
        process_round
        break if game_winner?
        display.next_round
      end
      display.round_history(human, computer)
      winner = determine_match_winner
      display.match_winner(winner)
      award_match_point(winner)
      match.update_history(human, computer)
      display.match_history(human, computer)
      break unless play_again?
    end
  end
end

RPSGame.new.play