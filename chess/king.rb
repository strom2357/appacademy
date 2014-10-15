require './stepping_pieces.rb'

class King < SteppingPiece
  DIFFS = [
    [1,1],
    [1,0],
    [1,-1],
    [0,1],
    [0,-1],
    [-1,1],
    [-1,0],
    [-1,-1]
   ]

   def inspect
     "K"
   end
end