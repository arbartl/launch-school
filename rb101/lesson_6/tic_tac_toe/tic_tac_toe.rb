def prompt(message)
  puts "=> #{message}"
end

def display_board(board)
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

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = ' ' }
  board
end

def empty_squares(board)
  board.keys.select { |num| board[num] }
end

def valid_choice?(square, board)
  empty_squares(board).include?(square)
end

def player_places_piece!(board)
  player_choice = nil
  loop do
    prompt("Choose an empty square (#{empty_squares(board).join(', ')})")
    player_choice = gets.chomp.to_i
    break if valid_choice?(player_choice, board)
    prompt("That's not a valid choice...")
  end
  board[player_choice] = 'X'
end

def computer_places_piece!(board)
  computer_choice = empty_squares(board).sample
  board[computer_choice] = 'O'
end


board = initialize_board

display_board(board)


player_places_piece!(board)

display_board(board)

computer_places_piece!(board)

display_board(board)
