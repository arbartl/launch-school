module Display
  def clear
    system('clear')
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe. Goodbye!"
  end

  def display_board
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    puts "#{human.name} (#{human.marker}): #{human.score} points"
    puts "#{computer.name} (#{computer.marker}): #{computer.score} points"
    puts "-----------------------"
    puts "First to #{TTTGame::POINTS_TO_WIN} wins!"
    puts ""
    board.draw
    puts ""
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then puts "You win!"
    when computer.marker then puts "Computer wins!"
    else puts "It's a tie!"
    end
    sleep(2)
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def reset
    @squares = (1..9).to_a.to_h { |sq| [sq, Square.new] }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(square, marker)
    squares[square].marker = marker
  end

  def empty_square_keys
    squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    empty_square_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def block_or_win?
    !!threatened_square
  end

  def threatened_square
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if squares.any? { |square| square.unmarked? } &&
         squares.select(&:marked?).map(&:marker).uniq.size == 1 &&
         squares.select(&:marked?).map(&:marker).size == 2
        squares.each do |square|
          return square if square.marker == Square::INITIAL_MARKER
        end
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score, :name

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class Human < Player

  def set_name
    loop do
      puts "What's your name?"
      @name = gets.chomp.strip
      break unless @name.empty?
      puts "Please enter a name..."
    end
  end

  def move(board)
    puts "Choose a square: #{joinor(board.empty_square_keys)}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.empty_square_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = marker
  end

  def joinor(arr, separator=', ', last_separator='or')
    return arr[0].to_s if !arr[1]
    last_element = arr.pop
    arr.join(separator) + " #{last_separator} " + last_element.to_s
  end
end

class Computer < Player
  COMPUTERS = ['R2D2', 'Sonny', 'Chappie', 'Hal', 'Number 5']

  def initialize(marker)
    super
    @name = COMPUTERS.sample
  end
  
  def move(board)
    puts "Computer is thinking..."
    sleep(1)    
    if board.block_or_win?
      board.threatened_square.marker = marker
    elsif board.empty_square_keys.include?(5)
      board[5] = marker
    else
      square = board.empty_square_keys.sample
      board[square] = marker
    end
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  POINTS_TO_WIN = 5

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  include Display

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @current_player = nil
  end

  def play
    clear
    display_welcome_message    
    main_game
    display_goodbye_message
  end

  private

  def choose_first_player
    clear
    4.times do
      [human.name, computer.name].each do |name|
        puts "Choosing who goes first: #{name}"
        sleep(0.3)
        clear
      end
    end
    @current_player = first_player = [human, computer].sample
    puts "Choosing who goes first: #{first_player.name}"
    sleep(2)
  end

  def main_game
    human.set_name
    choose_first_player
    loop do
      clear_screen_and_display_board
      take_turns
      display_result
      break if match_winner?
      reset
    end
  end

  def current_player_moves
    @current_player.move(board)
    switch_current_player
  end

  def switch_current_player
    self.current_player = current_player == human ? computer : human
  end

  def take_turns
    loop do
      current_player_moves
      clear_screen_and_display_board
      award_point if board.someone_won?
      break if board.full? || board.someone_won?
    end
  end

  def award_point
    case board.winning_marker
    when human.marker then human.score += 1
    when computer.marker then computer.score += 1
    end
  end

  def match_winner?
    human.score == POINTS_TO_WIN || computer.score == POINTS_TO_WIN
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, please enter 'y' or 'n'."
    end
    answer == 'y'
  end

  def reset
    clear
    board.reset
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
