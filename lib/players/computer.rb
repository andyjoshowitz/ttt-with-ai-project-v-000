module Players
  class Computer < Player
    
    def opponent_token
      if self.token == "X"
        opponent_token = "O"
      else
        opponent_token = "X"
      end
    end
    
    def won?(board)
      Game::WIN_COMBINATIONS.detect do |win_combo|
        position_1 = board.cells[win_combo[0]]
        position_2 = board.cells[win_combo[1]]
        position_3 = board.cells[win_combo[2]]
        
        if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
          return win_combo
        end
      end
    end
    
    def move(board)
      if board.turn_count == 0
        puts "Computer starting game..."
      else puts "Computer is making a move"
      end
      if board.turn_count == 0 || 1 && board.valid_move?("5")
        move = "5"
      elsif board.turn_count == 0 || 1 && board.valid_move?("1")
        move = "1"
      elsif board.turn_count == 2 && board.valid_move?("3")
        "3"
      elsif board.turn_count == 2 && board.valid_move?("7")
        "7"
      elsif board.turn_count == 3 || board.turn_count > 3
        if winning_move(board) != nil && won?(board) == false
          move = winning_move(board)
        elsif stop_opponent(board) != nil && won?(board) == false
          move = stop_opponent(board)
        else 
          move = board.valid_move?(rand(0..9))
        end
      end
    end
    
    def winning_move(board)
      final_move = nil
      Game::WIN_COMBINATIONS.detect do |win_combo|
        position_1 = board.cells[win_combo[0]]
        position_2 = board.cells[win_combo[1]]
        position_3 = board.cells[win_combo[2]]

        if (position_1 == self.token && position_2 == self.token && position_3 == " ")
          final_move = win_combo[2]
        elsif (position_1 == self.token && position_2 == " " && position_3 == self.token)
          final_move = win_combo[1]
        elsif (position_1 == " " && position_2 == self.token && position_3 == self.token)
          final_move = win_combo[0]
        end
      end
      final_move
    end

    def stop_opponent(board)
      stopping_move = nil
      Game::WIN_COMBINATIONS.detect do |win_combo|
        position_1 = board.cells[win_combo[0]]
        position_2 = board.cells[win_combo[1]]
        position_3 = board.cells[win_combo[2]]

        if (position_1 == opponent_token && position_2 == opponent_token && position_3 == " ")
          stopping_move = win_combo[2]
        elsif (position_1 == opponent_token && position_2 == " " && position_3 == opponent_token)
          stopping_move = win_combo[1]
        elsif (position_1 == " " && position_2 == opponent_token && position_3 == opponent_token)
          stopping_move = win_combo[0]
        end
      end
      stopping_move
    end
  end
end