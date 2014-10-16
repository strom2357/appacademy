class Rook < SlidingPiece
  DIRS = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ]
  
  def inspect
    @color == "black" ? "\u265C".colorize(:light_black) : "\u265C".colorize(:light_blue)
  end
end
