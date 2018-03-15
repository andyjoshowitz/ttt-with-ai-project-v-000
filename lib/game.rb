class Game
  attr_accessor :board, :player_1, :player_2
  
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [2,5,8],
    [0,4,8],
    [2,4,6],
    [0,3,6], # added to the end of array
    [1,4,7]  # added to the end of array
    ]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  
  def current_player
    board.turn_count.even? ? @player_1 : @player_2
  end
  
  def won?
    WIN_COMBINATIONS.detect do |win_combo|
      position_1 = board.cells[win_combo[0]]
      position_2 = board.cells[win_combo[1]]
      position_3 = board.cells[win_combo[2]]
      
      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combo
      end
    end
  end
  
  def draw?
   !won? && board.full? ? true : false
  end
  
  def over?
    won? || draw? ? true : false
  end
  
  def winner
    if won?
      board.cells[won?[0]]
    end
  end
  
  def turn
    puts ""
    user_input = current_player.move(board)
    if board.valid_move?(user_input)
      board.update(user_input, current_player)
      board.display
    else
      puts "Invalid move. Try again!"
      turn
    end
  end
  
  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end