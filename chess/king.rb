
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
     @color == "black" ? "\u265A".colorize(:light_black) : "\u265A".colorize(:light_blue)
   end
end