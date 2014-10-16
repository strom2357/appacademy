class Queen < SlidingPiece
  DIRS = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  
  def inspect
    @color == "black" ? "\u265B".colorize(:light_black) : "\u265B".colorize(:light_blue)
  end
end