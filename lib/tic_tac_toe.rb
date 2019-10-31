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
  
def turn_arr(board)
  { 
    x: board.each_index.select { |x| board[x] == 'X' },
    o: board.each_index.select { |o| board[o] == 'O' }
  }
end


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

def turn_count(board)
  board.count { |i| i != " " }
end

def current_player(board)
  i = 0
  board.each { |val| 
    i += 1 if val == "X" or val == "O"
  }
  (i.even?) ? "X" : "O"
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
end

def over?(board)
  if won?(board) or draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  
  combos = WIN_COMBINATIONS
  turns = turn_arr(board)
  x = 0
  combos.each do |c|
    if (c & turns[:x]).length == 3
      break 'X'
    elsif (c & turns[:o]).length == 3
      break 'O'
    end
    x += 1
    break nil if combos.count == x
  end
end

def turn(board)
  input = gets.strip
  index = input_to_index(input)
  
  if valid_move?(board, index)
    who = current_player(board)
    move(board, index, who)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  if board.uniq.count <= 1
    return false
  end
  combos = WIN_COMBINATIONS
  turns = turn_arr(board)
  
  check_x = nil
  check_o = nil
  
  combos.each do |c|
    if (c & turns[:x]).length == 3
     check_x = c
     break
    elsif (c & turns[:o]).length == 3
      check_o = c
      break
    end
  end
  
  # easily could add winner('x') / winner('o') to print out winner
  if !check_x.nil?
    return check_x
  elsif !check_o.nil?
    return check_o
  end
  
end

def play(board)
  
  until over?(board)
    turn(board)
  end
  
  if draw?(board)
    puts "Cat's Game!"
  elsif over?(board)
    puts "Congratulations #{winner(board)}!"
  end
end