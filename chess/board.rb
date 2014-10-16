class Board
  attr_accessor :board, :cursor
  
  def add_pieces
    # Pawn
    @board[1].each_index do |index|
      @board[1][index] = Pawn.new(self, [1, index], "white")
    end

    @board[6].each_index do |index|
      @board[6][index] = Pawn.new(self, [6, index], "black")
    end

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

  def initialize(fill_board = true)
    @board = Array.new(8) { Array.new(8) }
    add_pieces if fill_board
    @cursor = [0, 0]
  end

  def [] pos
    x, y = pos
    @board[x][y]
  end

  def display_board
    system "clear"
    
    @board.each_with_index do |row, i| 
      row_string = "#{8 - i} "
      row.each_with_index do |piece, j| 
        if @cursor ==[i, j]
          row_string += ((i + j) % 2 == 0 ?  "\u263A ".red.on_white :  "\u263A ".red.on_black)
        elsif piece.nil?
          row_string += ((i + j) % 2 == 0 ? "  ".on_white : "  ".on_black) 
        else
          row_string += ((i + j) % 2 == 0 ? "#{piece.inspect} ".on_white : "#{piece.inspect} ".on_black)
        end
      end
      # puts row_string
      puts background(row_string)
      
    end
    
    puts "  A B C D E F G H"
  end
  
  def background(str)
    x = str.split("")
    x.each do |sq|
      sq = sq.on_red
    end
    x.join("")
    # str.split(" ").count.times do |i|
    #   puts str[i].on_white if i % 2 == 0
    # end
  end
        
      

  def in_check?(color)
    my_king = team(color).select { |piece| piece.is_a?(King) }
    
    team(other_color(color)).any? do |piece|
      piece.valid_moves.include?(my_king[0].position)
    end
  end
  
  def move_into_check?(start_pos, end_pos)
    dup_board = Board.new(false)
    
    8.times do |x|
      8.times do |y|
        piece = @board[x][y]
        unless piece.nil?
          dup_board.board[x][y] = piece.class.new(dup_board, [x,y], piece.color) 
        end
      end
    end
    
    dup_board.move!(start_pos, end_pos)
    dup_board.in_check?(dup_board[end_pos].color)
  end
  
  def checkmate?(color)
    team(color).any? do |piece|
      piece.valid_moves.all? do |move|
        move_into_check?(piece.position, move) == false
      end
    end
  end
  
  def other_color(color)
    color == 'black' ? 'white' : 'black'
  end

  def team(color)
    @board.flatten.compact.select do | piece |
      piece.color == color
    end
  end

  def move(start_pos, end_pos, color)
    x, y = end_pos
    
    if @board[start_pos[0]][start_pos[1]].nil? || @board[start_pos[0]][start_pos[1]].color != color
       raise InvalidMoveError.new("That's not your piece!!")
    elsif self[start_pos].valid_moves.include?(end_pos)
      @board[x][y] = self[start_pos]
      @board[start_pos[0]][start_pos[1]] = nil
      self[end_pos].position = end_pos
    else
      raise InvalidMoveError.new("This is an invalid move!!")
    end
  end
  
  def move!(start_pos, end_pos)
    x, y = end_pos
    
    if self[start_pos].valid_moves.include?(end_pos)
      @board[x][y] = self[start_pos]
      @board[start_pos[0]][start_pos[1]] = nil
      self[end_pos].position = end_pos
    end
  end
end

