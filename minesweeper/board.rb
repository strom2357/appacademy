module Minesweeper
  class Board
    attr_reader :board, :size, :bomb_count
    attr_accessor :flag_count

    def initialize(size)
      @size = size
      @board = Array.new(@size) { Array.new(@size) { Tile.new(self) } }
      @board.each_with_index do |array, row|
        array.each_with_index do |tile, column|
          tile.position = [row, column]
        end
      end
      @bomb_count = ((size*size)/64)*10
      @flag_count = 0
      seeding_bombs(@bomb_count)
    end

    def seeding_bombs(num)
      @board.flatten.sample(num).each { |tile| tile.bombed = true }
      # num.times do |i|
      #   @board.sample.sample.bombed = true
      # end
    end

    def [] pos
      x, y = pos
      @board[x][y]
    end

    def over?
      return lost? || won?
    end

    def won?
      @board.flatten.all? {|tile| tile.revealed? || (tile.bombed? && tile.flagged?) }
    end

    def lost?
      @board.flatten.any? {|tile| tile.revealed? && tile.bombed? }
    end

    def inspect
      @board.each do |row|
        p row
      end

      "Type SAVE to save, QUIT to quit"
    end
  end
end
