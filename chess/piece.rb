class Piece
  attr_accessor :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  
  def valid_moves
    moves.keep_if do |move|
      on_board?(move) && (@board[move].nil? || @board[move].color != self.color)
    end
  end
  
  def on_board?(move)
    move[0].between?(0, 7) && move[1].between?(0, 7)
  end
end

