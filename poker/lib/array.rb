class Array 

  def my_uniq
    self & self
  end
  
  def two_sum 
    sums = []
    self.each_with_index do |num_1, idx_1|
      self.drop(idx_1 + 1).each_with_index do |num_2, idx_2|
        if num_1 + num_2 == 0
          sums << [idx_1, (idx_2 + idx_1 + 1)] 
        end
      end
    end
    sums
  end
  
  
  def stock_picker
    best_profit = 0
    best_days = []
    self.each_with_index do | price1, buy_day |
      self.each_with_index do | price2, sell_day |
        next if sell_day <= buy_day
        profit = price2 - price1 
        if profit > best_profit
          best_profit = profit
          best_days = [buy_day, sell_day]
        end
      end
    end
    
    best_days
  end
  
  def my_transpose
    arr = Array.new(self.length) { [] }
    self.each do | subarray |
      subarray.each_with_index do | element, idx |
        arr[idx] << element
      end
    end
    arr
  end
end

class TowersOfHanoi
  attr_accessor :towers

  def build_towers
    towers = Array.new(3) { [] }
    towers[0] = [3, 2, 1]
    towers
  end

  def initialize
    @towers = build_towers
  end
  
  def move(from, to)
    disc = take(from)
    place(to, disc)
  end
  
  def winning?
    towers[0].empty? && (towers[1].empty? || towers[2].empty?)
  end
  
  private
  
  def take(n)
    raise "Not even a tower" unless n.between?(0,2) 
    raise "Empty tower" if towers[n].empty?
    @towers[n].pop
  end
  
  def place(n, disc)
    unless towers[n].empty? 
      raise "disc too big" if towers[n].last < disc  
    end
    
    @towers[n] << disc
  end
end
