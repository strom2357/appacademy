class SlidingPiece < Piece

  def moves
    possible_moves = []
    
    self.class::DIRS.each do |dir|
      i = 1
      next_move = position.element_plus(dir.element_times(i))
      
      while is_valid?(next_move)
        possible_moves << next_move
        break if !@board[next_move].nil?
        i += 1
        next_move = position.element_plus(dir.element_times(i))
      end
    end
    
    possible_moves
  end  
  
  def is_valid?(move)
    on_board?(move) && (@board[move].nil? || @board[move].color != self.color)
  end  
end