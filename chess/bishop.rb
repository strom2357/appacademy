class Bishop < SlidingPiece
  DIRS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  
  def inspect
    @color == "black" ? "\u265D".colorize(:light_black) : "\u265D".colorize(:light_blue)
  end
end