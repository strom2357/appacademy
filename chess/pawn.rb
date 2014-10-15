class Pawn < Piece
 
  def initialize(board, position, color)
    super
  end

  def moves
    x, y = @position
    [[x, y + 1]]
  end
  
  # def valid_moves
  #   self.moves.keep_if do |move|
  #     (@board[move].nil? || @board[move].color != self.color) && on_board(move)
  #   end
  # end
  
  def inspect
    "P"
  end
end


