require './board'
require './player'
require './piece'
require './sliding_pieces'
require './stepping_pieces.rb'
require './king'
require './knight'
require './rook'
require './bishop'
require './queen'
require './pawn.rb'
require './exceptions'
require 'colorize'

class Game

  def initialize
    @board = Board.new
    @player1 = Player.new('black', @board)
    @player2 = Player.new('white', @board)
    @game_over = false
  end

  def play_turn(player)
    @board.display_board
    check_status(player)
    
    begin
      start_pos = player.get_turn
      end_pos = player.get_turn
      @board.move(start_pos, end_pos, player.color)
    rescue InvalidMoveError => e
      puts "#{e.message}"
      puts "Choose one of your pieces."
      retry
    end
    
    @board[end_pos].moved = true if @board[end_pos].is_a?(Pawn)
  end

  def check_status(player)
    if @board.in_check?(player.color) 
      p "#{player.color}: in check"
      if @board.checkmate?(player.color)
        @game_over = true
        puts "#{player.color}: Checkmate! You Lose!!!"
        exit
      end
    end
  end

  def play
    until @game_over
      play_turn(@player1)
      play_turn(@player2)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
