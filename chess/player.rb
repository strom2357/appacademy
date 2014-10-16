class Player
  attr_accessor :color

  def initialize(color, board)
    @color = color
    @board = board
  end
  
  def get_turn
    c = get_input
    until c == "."
      @board.display_board
      c = get_input
    end
    
    [@board.cursor[0], @board.cursor[1]]
  end

  def get_input
    puts "#{@color}: "
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
    else
      return c
    end
  end  
  
  private
  
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