INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

VALID_EXIT_ANSWER = {
  positive: ['y', 'yes'],
  negative: ['n', 'no']
}

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear')
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  clear_screen
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = INITIAL_MARKER }
  board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def valid_choice?(square, board)
  empty_squares(board).include?(square)
end

def player_places_piece!(board)
  player_choice = nil
  loop do
    prompt("Choose an empty square (#{empty_squares(board).join(', ')})")
    player_choice = gets.chomp.strip.to_i
    break if valid_choice?(player_choice, board)
    prompt("That's not a valid choice...")
  end
  board[player_choice] = PLAYER_MARKER
end

def computer_places_piece!(board)
  computer_choice = empty_squares(board).sample
  board[computer_choice] = COMPUTER_MARKER
end

def someone_won?(board)
  !!detect_winner(board)
end

def board_full?(board)
  empty_squares(board).empty?
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def display_winner(board)
  display_board(board)
  if someone_won?(board)
    prompt("#{detect_winner(board)} won!")
  else
    prompt("It's a tie!")
  end
end

def play_again
  answer = nil
  loop do
    prompt("Play again? (Y / N)")
    answer = gets.chomp.downcase
    break if VALID_EXIT_ANSWER[:positive].include?(answer) ||
             VALID_EXIT_ANSWER[:negative].include?(answer)
    prompt("Sorry, didn't catch that...")
  end
  answer
end

loop do # main loop
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_winner(board)

  answer = play_again
  break unless VALID_EXIT_ANSWER[:positive].include?(answer)
end

prompt("Thanks for playing!")
