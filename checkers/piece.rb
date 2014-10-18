class Piece
	attr_reader :color, :position, :grid, :promoted
	def initialize(board, color, position, promoted = false)
		@board = board
		@position = position
		@color = color
    @promoted = promoted
	end

	
	def perform_slide(end_pos)
		return false if !valid_slide?(end_pos)
		
		#do that funky stuff
		x, y = end_pos
		@board.grid[position[0]][position[1]] = nil
		@board.grid[x][y] = self   

		@position = end_pos
		true
	end

  def has_jump?
    !jump_set.empty?
  end

  def maybe_promote?
    if @promoted == false
      if color == :w && position[0] == 7
        @promoted = true
      elsif color == :b && position[0] == 0
        puts "PROMOTED"
        @promoted = true
      end
    end
  end

	def perform_jump(end_pos)
		return false if !valid_jump?(end_pos)

		x, y = end_pos
		i, j = space_between(position, end_pos)
		
		@board.grid[position[0]][position[1]] = nil
		@board.grid[x][y] = self
		@board.grid[i][j] = nil
    
    @position = end_pos
		true
	end

  def perform_jumps!(sequence)
    dup_board = @board.dup

    sequence.any? do |move|
      if !valid_jump?(move)
        raise "not a valid jump"
      end
    end
    moves = []
    sequence.each do |arr|
      moves << [arr[0], arr[1]]
    end

    valid_move_seq?(self.position, sequence)
    if moves.length == 1
      perform_jump(moves[0])
      maybe_promote?
    else 
      until moves.empty?
        perform_jump(moves.shift)
        maybe_promote?
      end

    end
  end

  def perform_moves!(sequence)
    moves = []
    sequence.each do |arr|
      moves << [arr[0], arr[1]]
    end

    return false unless valid_move_seq?(self.position, sequence)
    if moves.length == 1
      perform_jump(moves[0]) unless perform_slide(moves[0])
      maybe_promote?
    else 
      until moves.empty?
        perform_jump(moves.shift)
        maybe_promote?
      end
    end
  end

  def perform_moves(sequence)
    if sequence.length == 1
      perform_jump(sequence[0]) unless perform_slide(sequence[0])
    else 
      until sequence.empty?
        return false unless perform_jump(sequence.shift)
      end
    end
    return true
  end

  def valid_move_seq?(position, sequence)
    x, y = position
    dup_board = @board.dup_board
    if dup_board.grid[x][y].perform_moves(sequence)     
      perform_moves(sequence)
      return true
    else 
      p "bad sequence"
      return false
    end
  end

	def space_between(array1, array2)
		arr = [(array2[0] - array1[0])/2, (array2[1] - array1[1])/2]
		eplus(array1, arr)
	end

	def jumps
		if promoted 
      [[2, 2], [2, -2], [-2, 2], [-2, -2]]
    elsif color == :w 
      [[2, 2], [2, -2]] 
    else
      [[-2, 2], [-2, -2]]
    end
	end

	def jump_set
		set = []
		jumps.each_with_index do |move, i| 
			x, y = eplus(position, slides[i])
      next unless on_board?([x, y])
			if !@board.grid[x][y].nil? && @board.grid[x][y].color != self.color
        set << eplus(position, move)
        puts "SET #{set}"
      end
		end
		set.keep_if do |move| 
      x, y = move
      on_board?(move) && @board.grid[x][y].nil? 
    end
	end

	def valid_jump?(end_pos)
    x, y = end_pos
		jump_set.include?(end_pos) && @board.grid[x][y].nil?
	end

	def valid_slide?(end_pos)
		x, y = end_pos
		slide_set.include?(end_pos) && @board.grid[x][y].nil?
	end

	def slide_set
	 	set = []
	 	slides.each { |move| set << eplus(position, move) }
	 	set.keep_if { |pos| on_board?(pos) }
	end

	def slides
    if promoted
      [[1,1], [1,-1], [-1,1], [-1, -1]]
    elsif color == :w 
      [[1,1], [1,-1]] 
    else
      [[-1,1], [-1, -1]]
    end
	end

	def inspect
    code = (promoted ? "\u2605" : "\u25CF")
		color == :w ? code.light_green : code.light_cyan
	end

	def on_board?(pos)
		true
    pos[0].between?(0,7) && pos[1].between?(0,7)
	end

	def eplus(array1, array2)
		arr = [(array1[0] + array2[0]), (array1[1] + array2[1])]
	end
end

