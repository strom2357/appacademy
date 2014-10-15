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
    "N"
  end
end

# knight = Knight.new(nil, [1, 2])
# p knight.moves