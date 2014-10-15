require 'yaml'
require './tile.rb'
require './board.rb'
require './leaderboard.rb'
module Minesweeper
  class GamePlay

    def initialize
      @scoreboard = Leaderboard.new
      @cursor = [0, 0]
    end

    def make_board(size)
      @board = Board.new(size)
    end

    def display_board
      @board.board.each_with_index do |row, i| 
        row_string = ""
        row.each_with_index do |tile, j|
          if @cursor ==[i, j]
            row_string += "\u25A1 "
          else
            row_string += "#{tile.inspect} "
          end
        end
        puts row_string
      end
    end

    def play
    # save previous state of stty
    # disable echoing and enable raw (not having to press enter)
      # puts "Enter board size 1 - 42"
      # size = gets.chomp.to_i
      # make_board(size)

      start_time = Time.now
      until @board.over?
        system "clear"
        display_board
        puts "#{@board.bomb_count} bombs"
        puts "#{@board.flag_count} flagged"
        get_input
      end

      if @board.lost?
        puts "Game Over! You are bombed!!"
      else
        puts "You won!!"
        elapsed_time = Time.now - start_time
        # @scoreboard.values.each_with_index do |time, index|
        #   if elapsed_time < time
            puts "Type your name: "
            name = gets.chomp
            @scoreboard.scores[name] = elapsed_time
            #some_hash[name] = elapsed_time
            # @scoreboard.scores.insert(index, elapsed_time)
            # @scoreboard.scores = @scoreboard.scores[0..4]
            @scoreboard.record_score
      end

        p @scoreboard

    end

    def save
      File.open("saved-game", "w") do |f|
        saved_game = self.to_yaml
        f.puts saved_game
      end
    end

    def get_input
      c = show_single_key
      if c == "w"
        @cursor[0] -= 1
      elsif c == "s"
        @cursor[0] += 1
      elsif c == "a"
        @cursor[1] -= 1
      elsif c == "d"
        @cursor[1] += 1
      elsif c == "r"
        @board[@cursor].reveal
      elsif c == "f"
        @board[@cursor].flag
      elsif c == "q"
        exit
      elsif c == "."
        save
      end

      p @cursor
      # return save if pos == "SAVE"
      # exit if pos == "QUIT"

      # pos = pos.split(",").map { |i| i.to_i }
      # pos.reverse!

      # puts "Reveal or flag? R/F"
      # move = gets.chomp.upcase
      # if move == "R"
      #   @board[pos].reveal
      # elsif move == "F"
      #   @board[pos].flag
      # else
      #   puts "Invalid input!"
      # end
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
end

#

puts "Welcome to Minesweeper! New game or load saved? N/S"
ans = gets.chomp.upcase
if ans == "S"
  yaml_minesweeper = File.read("saved-game")
  minesweeper = YAML::load(yaml_minesweeper)
else
  minesweeper = Minesweeper::GamePlay.new
  puts "Enter board size 1 - 42"
  size = gets.chomp.to_i
  minesweeper.make_board(size)
end

minesweeper.play




