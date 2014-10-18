class Board
	attr_accessor :grid, :cursor
	def initialize(populate = true)
		@grid = Array.new(8) { Array.new(8) }
    @cursor = [4, 4]
		add_pieces if populate
	end

	def add_pieces
		p grid
		grid.each_with_index do |row, i|
			row.each_with_index do |square, j|
				if (i + j) % 2 != 0
					if (i < 3)
						grid[i][j] = Piece.new(self, :w, [i, j])
					elsif (i > 4)
						grid[i][j] = Piece.new(self, :b, [i, j])
					end
				end
			end
		end
	end

	def dup_board
	  dup_board = Board.new(populate = false)
      dup_board.grid.each_with_index do |row, i|
	      row.each_with_index do |square, j|
          if @grid[i][j].nil?
            dup_board.grid[i][j] = nil 
          else
            dup_board.grid[i][j] = @grid[i][j].class.new(dup_board, @grid[i][j].color, [i, j], @grid[i][j].promoted)
          end
	      end
	    end
    dup_board
  end

	def inspect
    puts "  0 1 2 3 4 5 6 7"
    @grid.each_with_index do |row, i|
      row_string = "#{i} "
      row.each_with_index do |el, j|
      	if ((i + j) % 2 == 0)
          if i == @cursor[0]  && j == @cursor[1]
            row_string += "\u2600 ".blue.on_white
        	else 
            row_string += (el.nil? ? " ".on_white : el.inspect.on_black) + " ".on_white
          end
        else
          if i == @cursor[0]  && j == @cursor[1]
            row_string += "\u2600 ".blue.on_black
          else
        	 row_string += (el.nil? ? " ".on_black : el.inspect.on_black) + " ".on_black
          end
        end
      end
      puts row_string
    end
    
    nil
  end
end








