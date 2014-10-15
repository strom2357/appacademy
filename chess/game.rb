require './piece'
require './sliding_pieces'
require './stepping_pieces'
require './king'
require './knight'
require './rook'
require './bishop'
require './queen'
require './pawn'
require './chess'

class Game

  def initialize
    @board = Board.new
  end
  
  def get_input
    puts "Enter a coordinate (start position): x,y"
    start_pos = gets.chomp
    start_pos =  start_pos.split(",").map { |i| i.to_i }

    puts "Enter a coordinate (end position): x,y"
    end_pos = gets.chomp
    end_pos = end_pos.split(",").map { |i| i.to_i }
    
    [start_pos, end_pos]
  end

  
  def play
    
    until game_over?
      p @board
      start_pos, end_pos = get_input
      @board.move(start_pos, end_pos)
    end
  end
  
  def game_over?
    false
  end


end

g = Game.new
g.play
