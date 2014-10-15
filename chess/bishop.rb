class Bishop < SlidingPiece
  DIRS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  
  def inspect
    "B"
  end
end