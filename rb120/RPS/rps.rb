require 'yaml'

MESSAGES = YAML.load_file('rps.yml')

def prompt(message)
  puts "=> #{message}"
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
  end

  def add_point
    self.score += 1
  end

  def show_score
    "#{name}: #{score} points"
  end
end

class Human < Player
  @@match_wins = 0

  def initialize
    super
    choose_name
  end

  def choose_name
    n = nil
    loop do
      prompt(MESSAGES['get_name'])
      n = gets.chomp
      break unless n.empty?
      prompt(MESSAGES['invalid_name'])
    end
    self.name = n
  end

  def choose_move
    choice = nil
    loop do
      prompt(MESSAGES['choose_move'])
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      prompt(MESSAGES['invalid_move'])
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

  def initialize
    super
  end

  def self.opponent_shuffle(opponent)
    2.times do
      OPPONENTS.shuffle.each do |name|
        puts "\n=> Choosing Opponent: #{name}"
        sleep(0.25)
        system('clear')
      end
    end
    puts "\n=> Choosing Opponent: #{opponent}"
    sleep(1)
  end

  def self.create(opponent)
    opponent_shuffle(opponent)
    case opponent
    when 'R2D2' then R2D2.new
    when 'Hal' then Hal.new
    when 'Chappie' then Chappie.new
    when 'Sonny' then Sonny.new
    when 'Number 5' then Number5.new
    end
  end

  def choose_move
    self.move = Move.create(Move::VALUES.keys.sample)
  end

  def show_score
    "#{name} (CPU): #{score} points"
  end

  def speak
    puts ""
    puts "#{@name}: #{self.class::QUOTES.sample}"
    sleep(3)
  end

  def quotes
    QUOTES
  end

  def self.match_point
    @@match_wins += 1
  end

  def self.match_wins
    @@match_wins
  end
end

class R2D2 < Computer
  QUOTES = MESSAGES['r2d2_quotes']
  MOVES = { 'r' => 'rock',
            'p' => 'paper',
            'l' => 'lizard',
            'sp' => 'spock',
            'ls' => 'lightsaber' }
  def initialize
    super
    @name = 'R2D2'
    speak
  end

  def choose_move
    self.move = Move.create(MOVES.keys.sample)
  end
end

class Hal < Computer
  attr_accessor :move

  QUOTES = MESSAGES['hal_quotes']
  def initialize
    super
    @name = 'Hal'
    speak
  end
end

class Chappie < Computer
  QUOTES = MESSAGES['chappie_quotes']
  MOVES = { 'r' => 'rock',
            'sp' => 'spock' }
  def initialize
    super
    @name = 'Chappie'
    speak
  end

  def choose_move
    self.move = Move.create(MOVES.keys.sample)
  end
end

class Sonny < Computer
  QUOTES = MESSAGES['sonny_quotes']
  MOVES = { 'r' => 'rock',
            'p' => 'paper',
            's' => 'scissors' }
  def initialize
    super
    @name = 'Sonny'
    speak
  end

  def choose_move
    self.move = Move.create(MOVES.keys.sample)
  end
end

class Number5 < Computer
  QUOTES = MESSAGES['number5_quotes']
  def initialize
    super
    @name = 'Number 5'
    speak
  end
end

class Move
  VALUES = { 'r' => 'rock',
             'p' => 'paper',
             's' => 'scissors',
             'l' => 'lizard',
             'sp' => 'spock' }

  attr_reader :value, :beats

  def >(other_move)
    self.class::BEATS.keys.include?(other_move.value)
  end

  def self.create(type)
    case type
    when 'r' then Rock.new
    when 'p' then Paper.new
    when 's' then Scissors.new
    when 'l' then Lizard.new
    when 'sp' then Spock.new
    when 'ls' then Lightsaber.new
    end
  end

  def to_s
    @value.capitalize
  end
end

class Rock < Move
  BEATS = { 'scissors' => 'crushes', 'lizard' => 'crushes' }
  def initialize
    @value = 'rock'
  end
end

class Paper < Move
  BEATS = { 'rock' => 'covers', 'spock' => 'disproves' }
  def initialize
    @value = 'paper'
  end
end

class Scissors < Move
  BEATS = { 'paper' => 'cut', 'lizard' => 'dismember' }
  def initialize
    @value = 'scissors'
  end
end

class Lizard < Move
  BEATS = { 'paper' => 'eats', 'spock' => 'poisons' }
  def initialize
    @value = 'lizard'
  end
end

class Spock < Move
  BEATS = { 'rock' => 'vaporizes', 'scissors' => 'crushes' }
  def initialize
    @value = 'spock'
  end
end

class Lightsaber < Move
  BEATS = { 'rock' => 'melts',
            'paper' => 'burns',
            'scissors' => 'melts',
            'lizard' => 'annihilates',
            'spock' => 'surprises' }

  def initialize
    @value = 'lightsaber'
  end

  def to_s
    "~*#{@value.upcase}*~"
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
    Round.history << { :round => Round.number,
                       human.name => human.move.value,
                       computer.name => computer.move.value,
                       :winner => winner }
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
      prompt(MESSAGES['choose_points'])
      points = gets.chomp
      break if (1..10).include?(points.to_i) && points == points.to_i.to_s
      prompt(MESSAGES['invalid_points'])
    end
    Display.clear_screen
    points.to_i
  end

  def update_history(human)
    Match.history << { :match => Match.number,
                       human.name => Human.match_wins,
                       :cpu => Computer.match_wins }
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
    puts MESSAGES['welcome']
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
      w_move = round.winner.move
      l_move = round.loser.move
      puts ""
      prompt("#{w_move} #{w_move.class::BEATS[l_move.value]} #{l_move}!")
      prompt("#{round.winner.name} wins!")
      puts ""
    else
      puts "\nIt's a tie!"
    end
  end

  def next_round
    prompt(MESSAGES['continue'])
    gets
  end

  def round_history(human, computer)
    puts "Round History:"
    puts "=============="
    Round.history.each do |hsh|
      puts "Round: #{hsh[:round]} -- #{human.name}: #{hsh[human.name]} --" \
           " #{computer.name}: #{hsh[computer.name]} -- Winner: #{hsh[:winner]}"
    end
  end

  def match_history(human)
    puts "Match History:"
    puts "=============="
    Match.history.each do |hsh|
      puts "Match: #{hsh[:match]} -- #{human.name}: #{hsh[human.name]} --" \
           " CPU: #{hsh[:cpu]}"
    end
  end

  def match_winner(winner)
    puts ""
    if !winner
      prompt("Hal knows too much... Let's try again.")
    else
      prompt("#{winner.name} wins the match!")
    end
    puts ""
  end

  def goodbye_message
    prompt(MESSAGES['goodbye'])
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

  def play
    loop do
      play_match
      finish_match
      break unless play_again?
    end
    display.goodbye_message
  end

  private

  def start_match
    @match = Match.new
    Round.reset_round
    @computer = Computer.create(Computer::OPPONENTS.sample)
    @info = { human: @human, computer: @computer, match: @match, round: @round }
  end

  def start_round
    @round = Round.new
    display.round_info(@info)
    choose_moves
  end

  def choose_moves
    human.choose_move
    if computer.name == 'Hal'
      computer.move = human.move.dup
    else
      computer.choose_move
    end
  end

  def determine_round_winner
    human_move = human.move
    computer_move = computer.move
    if human_move > computer_move
      assign_winner(human, computer)
    elsif computer_move > human_move
      assign_winner(computer, human)
    else
      round.winner = nil
    end
  end

  def assign_winner(winner, loser)
    round.winner = winner
    round.loser = loser
  end

  def determine_match_winner
    return nil if computer.name == 'Hal'
    human.score == match.points_to_win ? human : computer
  end

  def process_round
    display.moves(human, computer)
    determine_round_winner
    round&.winner&.add_point
    display.round_winner(round)
    round.update_history(human, computer)
  end

  def game_winner?
    (human.score == match.points_to_win) ||
      (computer.score == match.points_to_win)
  end

  def award_match_point(winner)
    winner.class.match_point if winner == human
    winner.class.superclass.match_point if winner == computer
  end

  def finish_match
    display.round_history(human, computer)
    winner = determine_match_winner
    display.match_winner(winner)
    award_match_point(winner)
    human.score = 0
    match.update_history(human)
    display.match_history(human)
  end

  def play_again?
    answer = nil
    loop do
      puts "\n=> Would you like to play another match? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(answer)
      puts "Sorry, must be 'y' or 'n'."
    end
    display.clear_screen
    answer == 'y' || answer == 'yes'
  end

  def play_round
    start_round
    process_round
  end

  def opponent_cheated
    computer.name == 'Hal' && Round.number == 5
  end

  def play_match
    start_match
    loop do
      play_round
      break if game_winner? || opponent_cheated
      display.next_round
    end
  end
end

RPSGame.new.play
