class Rook < SlidingPiece
  DIRS = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ]
  
  def inspect
    "R"
  end
end
