class SlidingPiece < Piece

  def moves
    possible_moves = []
    
    self.class::DIRS.each do |dir|
      i = 1
      next_move = each_plus(position, each_times(dir, i))
      
      while is_valid?(next_move)
        possible_moves << next_move
        break if !@board[next_move].nil?
        i += 1
        next_move = each_plus(position, each_times(dir, i))
      end
    end
    
    possible_moves
  end  
 
  def is_valid?(move)
    on_board?(move) && (@board[move].nil? || @board[move].color != self.color)
  end  
  
  
  private  
    def each_times(vector, scalar)
      [].tap do |result|
        vector.each { |i| result << i *= scalar }
      end
    end
  
    def each_plus(vector, scalar)
      [].tap do |result|
        vector.each_with_index { |v, i| result << v += scalar[i] }
      end
    end
end

