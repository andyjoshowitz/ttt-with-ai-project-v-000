module Players
  class Human < Player
    def move(board)
      if board.turn_count.even?
        puts "Player 1's move"
      else puts "Player 2's move"
      end
      puts "To execute your turn, please enter 1-9:"
      gets.chomp
    end
  end
end