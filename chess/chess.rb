require './piece.rb'
require './sliding_pieces'
require './stepping_pieces'
require './king'
require './knight'
require './rook'
require './bishop'
require './queen'
require './pawn.rb'


class Board
  attr_accessor :board
  
  def add_pieces
    
    # Pawn
    # @board[1].each_index do |index|
    #   @board[1][index] = Pawn.new(self, [1, index], "white")
    # end
    #
    # @board[6].each_index do |index|
    #   @board[6][index] = Pawn.new(self, [6, index], "black")
    # end

    # King
    @board[0][4] = King.new(self, [0, 4], "white")
    @board[7][4] = King.new(self, [7, 4], "black")

    # Queen
    @board[0][3] = Queen.new(self, [0, 3], "white")
    @board[7][3] = Queen.new(self, [7, 3], "black")
    
    # Knight
    @board[0][1] = Knight.new(self, [0, 1], "white")
    @board[0][6] = Knight.new(self, [0, 6], "white")

    @board[7][1] = Knight.new(self, [7, 1], "black")
    @board[7][6] = Knight.new(self, [7, 6], "black")

    # Rook
    @board[0][0] = Rook.new(self, [0, 0], "white")
    @board[0][7] = Rook.new(self, [0, 7], "white")
    
    @board[7][0] = Rook.new(self, [7, 0], "black")
    @board[7][7] = Rook.new(self, [7, 7], "black")
    
    # Bishop
    @board[0][2] = Bishop.new(self, [0, 2], "white")
    @board[0][5] = Bishop.new(self, [0, 5], "white")    

    @board[7][2] = Bishop.new(self, [7, 2], "black")
    @board[7][5] = Bishop.new(self, [7, 5], "black")

  end

  def initialize
    @board = Array.new(8) { Array.new(8) }
    add_pieces
  end

  def [] pos
    x, y = pos
    @board[x][y]
  end

  
  def place_piece(klass, pos, color)
  end

  def move(start_pos, end_pos)
    x, y = end_pos
    if self[start_pos].valid_moves.include?(end_pos)
      @board[x][y] = self[start_pos]
      @board[start_pos[0]][start_pos[1]] = nil
      self[end_pos].position = end_pos
    end
  end

  def inspect
    puts "  0 1 2 3 4 5 6 7"
    @board.each_with_index do |row, index|
      row_string = "#{index} "
      row.each do |el|
        row_string += (el.nil? ? "_" : el.inspect) + " "
      end
      puts row_string
    end
    
    nil
  end
end

class Array
  def element_times(num)
    x, y = self[0], self[1]
    x *= num
    y *= num
    [x, y]
  end
  
  def element_plus(num)
    x, y = self[0], self[1]
    x += num[0]
    y += num[1]
    
    [x, y]
  end
end

# g = Board.new
# p g
# p g[[7,3]].is_valid?([6,7])
