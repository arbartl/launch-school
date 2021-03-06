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

CENTER_SQUARE = 5
BOARD_SIZE = 3

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear')
end

def joinor(arr, separator=', ', last_separator='or')
  return arr[0].to_s if !arr[1]
  last_element = arr.pop
  arr.join(separator) + " #{last_separator} " + last_element.to_s
end

def choose_points_to_win
  points_to_win = nil
  loop do
    prompt("How many points do you want to play to? (1 - 5)")
    points_to_win = gets.chomp.strip.to_i
    break if (1..5).include?(points_to_win)
    prompt("That's not a valid point goal...")
  end
  points_to_win
end

def choose_computer_difficulty
  difficulty = nil
  loop do
    prompt("What difficulty do you want to face?")
    prompt("1. Easy")
    prompt("2. Medium")
    prompt("3. Hard")
    difficulty = gets.chomp.strip.to_i
    break if (1..3).include?(difficulty)
    prompt("That's not a valid difficulty selection...")
  end
  difficulty
end

def choose_first_player
  player = nil
  loop do
    prompt("Who should go first?")
    prompt("1. Player")
    prompt("2. Computer")
    prompt("3. Decide for me!")
    player = gets.chomp.strip.to_i
    break if (1..3).include?(player)
    prompt("That's not a valid choice...")
  end
  player
end

def assign_first_player
  first_player = choose_first_player
  if first_player == 1
    "Player"
  elsif first_player == 2
    "Computer"
  else
    ["Player", "Computer"].sample
  end
end

def display_first_player(player)
  prompt("#{player} goes first!")
  sleep(1.5)
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  puts ""
  puts "        |     |"
  puts "     #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "        |     |"
  puts "   -----+-----+-----"
  puts "        |     |"
  puts "     #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "        |     |"
  puts "   -----+-----+-----"
  puts "        |     |"
  puts "     #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "        |     |"
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
  empty_squares(board).include?(square.to_i) && square == square.to_i.to_s
end

def player_places_piece!(board)
  player_choice = nil
  prompt("Your turn!")
  loop do
    prompt("Choose an empty square (#{joinor(empty_squares(board))})")
    player_choice = gets.chomp.strip
    break if valid_choice?(player_choice, board)
    prompt("That's not a valid choice...")
  end
  board[player_choice.to_i] = PLAYER_MARKER
end

def find_at_risk_square(marker, board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(marker) == 2
      line.each do |index|
        if board[index] == " "
          return index
        end
      end
    end
  end
  nil
end

def computer_places_piece!(board, difficulty)
  prompt("Computer turn...")
  sleep(1)
  case difficulty
  when 1
    board[empty_squares(board).sample] = COMPUTER_MARKER
  when 2
    computer_logic_medium(board)
  when 3
    computer_logic_hard(board)
  end
end

def computer_logic_medium(board)
  if find_at_risk_square(PLAYER_MARKER, board)
    board[find_at_risk_square(PLAYER_MARKER, board)] = COMPUTER_MARKER
  elsif find_at_risk_square(COMPUTER_MARKER, board)
    board[find_at_risk_square(COMPUTER_MARKER, board)] = COMPUTER_MARKER
  else
    board[empty_squares(board).sample] = COMPUTER_MARKER
  end
end

def computer_logic_hard(board)
  if find_at_risk_square(COMPUTER_MARKER, board)
    board[find_at_risk_square(COMPUTER_MARKER, board)] = COMPUTER_MARKER
  elsif find_at_risk_square(PLAYER_MARKER, board)
    board[find_at_risk_square(PLAYER_MARKER, board)] = COMPUTER_MARKER
  elsif board[CENTER_SQUARE] == " "
    board[CENTER_SQUARE] = COMPUTER_MARKER
  else
    board[empty_squares(board).sample] = COMPUTER_MARKER
  end
end

def place_piece!(current_player, board, difficulty)
  player_places_piece!(board) if current_player == "Player"
  computer_places_piece!(board, difficulty) if current_player == "Computer"
end

def alternate_player(current_player)
  current_player == "Player" ? "Computer" : "Player"
end

def someone_won?(board)
  !!detect_winner(board)
end

def board_full?(board)
  empty_squares(board).empty?
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == BOARD_SIZE
      return "Player"
    elsif board.values_at(*line).count(COMPUTER_MARKER) == BOARD_SIZE
      return "Computer"
    end
  end
  nil
end

def display_round_winner(board)
  if someone_won?(board)
    prompt("#{detect_winner(board)} won a point!")
  else
    prompt("It's a tie!")
  end
end

def update_scores(winner, scores)
  scores[winner.to_sym] += 1
end

def display_score(scores, points_to_win, board)
  clear_screen
  prompt("Player: #{scores[:Player]} -- Computer: #{scores[:Computer]}")
  prompt("First to #{points_to_win} wins!") if !detect_winner(board)
end

def display_game_winner(scores, points_to_win)
  prompt("#{scores.key(points_to_win)} wins the game!")
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
  clear_screen
  scores = {
    Player: 0,
    Computer: 0
  }
  board = nil
  points_to_win = choose_points_to_win
  difficulty = choose_computer_difficulty
  current_player = assign_first_player
  display_first_player(current_player)

  loop do
    board = initialize_board

    loop do
      display_score(scores, points_to_win, board)
      display_board(board)
      place_piece!(current_player, board, difficulty)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_score(scores, points_to_win, board)
    display_board(board)
    winner = detect_winner(board)
    display_round_winner(board)
    sleep(1.25)
    update_scores(winner, scores) if winner
    break if scores.values.any?(points_to_win)
  end

  display_score(scores, points_to_win, board)
  display_game_winner(scores, points_to_win)
  answer = play_again
  break unless VALID_EXIT_ANSWER[:positive].include?(answer)
end

prompt("Thanks for playing!")
