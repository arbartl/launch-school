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

  def initialize(marker)
    @marker = marker
  end
end

class Human < Player
  def move(board)
    puts "Choose a square: #{board.empty_square_keys.join(', ')}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.empty_square_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = marker
  end
end

class Computer < Player
  def move(board)
    square = board.empty_square_keys.sample
    board[square] = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  include Display

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @current_player = human
  end

  def play
    clear
    display_welcome_message

    loop do
      clear_screen_and_display_board
      loop do
        current_player_moves
        clear_screen_and_display_board
        break if board.full? || board.someone_won?        
      end
      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  private

  def current_player_moves
    @current_player.move(board)
    switch_current_player
  end

  def switch_current_player
    if current_player == human
      self.current_player = computer
    else
      self.current_player = human
    end
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