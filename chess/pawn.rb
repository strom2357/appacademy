class Pawn < Piece
  attr_accessor :moved
 
  def initialize(board, position, color)
    super
    @moved = false
  end
  
  def color_move(op, opponent_color)
    x, y = @position
    moves = []
    
    moves << [x.send(op, 1), y] if @board[[x.send(op, 1), y]].nil?
    moves << [x.send(op, 2), y] if @moved == false 
    
    if !@board[[x.send(op, 1), y + 1]].nil? && 
      @board[[x.send(op, 1), y + 1]].color == opponent_color
      
      moves << [x.send(op, 1), y + 1]
    end
    if !@board[[x.send(op, 1), y - 1]].nil? && 
      @board[[x.send(op, 1), y - 1]].color == opponent_color
      
      moves << [x.send(op, 1), y - 1]
    end
    
    moves
  end

  def moves
    op = (@color == "white" ? "+" : "-")
    opponent_color = (@color == "white" ? "black" : "white")
    
    moves = color_move(op, opponent_color)
  end
  
  def inspect
    @color == "black" ? "\u265F".light_black : "\u265F".light_blue
  end
end


