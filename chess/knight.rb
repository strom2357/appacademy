class Knight < SteppingPiece
  DIFFS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]
  
  def inspect
    @color == "black" ? "\u265E".colorize(:light_black) : "\u265E".colorize(:light_blue)
  end
end
