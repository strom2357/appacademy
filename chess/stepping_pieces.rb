class SteppingPiece < Piece
  
  def moves
    possible_moves = []
    self.class::DIFFS.each do |pos|
      x, y = self.position
      possible_moves << [x + pos[0], y + pos[1]]
    end
    possible_moves
  end  
end
