WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

def display_board(board)
  puts " #{board.at(0)} | #{board.at(1)} | #{board.at(2)} "
  puts "-----------"
  puts " #{board.at(3)} | #{board.at(4)} | #{board.at(5)} "
  puts "-----------"
  puts " #{board.at(6)} | #{board.at(7)} | #{board.at(8)} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  #index.between?(0,8) && !position_taken?(board, index)
  board.at(index) == " " && index.between?(0, 8) ? true : false
end

def full?(board)
  board.all? { |b| b == 'X' or b == 'O' }
end

def turn2(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def turn(board)
  input = gets.strip
  index = input_to_index(input)
  
  if valid_move?(board, index)
     move(board, index, "X")
     display_board(board)
  else
    turn(board)
  end
  
end

def play(board)
  
  i = 0
  loop do
    i += 1
    turn(board)
    if i == 9
      break
    end
  end
end