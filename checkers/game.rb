require './checkers'
require './piece'
require 'colorize'

class Game
	attr_accessor :board
	def initialize
		@board = Board.new
	end

	def all_whites
		white = []
		@board.grid.flatten.each do |piece|
			if !piece.nil?
				if piece.color == :w
					white << piece
				end
			end
		end
		white
	end

	def all_blacks
		black = []
		@board.grid.flatten.each do |piece|
			if !piece.nil?
				if piece.color == :b
					black << piece
				end
			end
		end
		black
	end

	def white_turn
		has_jump = all_whites.any? do |tile|
			tile.has_jump?
		end

		move = get_input
		p "MOVE:"
		p move
		sequence = []
		loop do
			next_turn = get_input
			if next_turn == ","
				break
			else
				sequence << next_turn
			end
		end
		x, y = move
		if @board.grid[x][y].nil? || @board.grid[x][y].color != :w
			raise "wrong color"
		end
		if has_jump
			@board.grid[x][y].perform_jumps!(sequence)
		else 
			return @board.grid[x][y].perform_moves!(sequence)
		end
	end

	def black_turn
		has_jump = all_blacks.any? do |tile|
			tile.has_jump?
		end

		move = get_input
		p "MOVE:"
		p move
		sequence = []
		loop do
			next_turn = get_input
			if next_turn == ","
				break
			else
				sequence << next_turn
			end
		end
		x, y = move
		if @board.grid[x][y].nil? || @board.grid[x][y].color != :b
			raise "wrong color"
		end
		if has_jump
			@board.grid[x][y].perform_jumps!(sequence)
		else 
			return @board.grid[x][y].perform_moves!(sequence)
		end
	end

	def play
		loop do
			begin
				white_turn
				rescue
				retry
			end
			
			begin 
				black_turn
				rescue
				retry
			end
		end
	end

	def get_input
	  puts "trying to get input: "
	  loop do
	  	p @board
	    c = show_single_key
	    case c
	    when "w"
	      @board.cursor[0] -= 1
	    when "s"
	      @board.cursor[0] += 1
	    when "a"
	      @board.cursor[1] -= 1
	    when "d"
	      @board.cursor[1] += 1
	    when "q"
	      exit
	  	when ","
	  	  return ","
	    else
	      move = [@board.cursor[0], @board.cursor[1]]
	      return move
	      break
	    end
	  end
  	end  

  	def read_char
      old_state = `stty -g`
      system "stty raw -echo"
      c = STDIN.getc.chr
      system "stty #{old_state}"
      c
  	end

  	def show_single_key
      c = read_char
  	end
end

game = Game.new
game.play