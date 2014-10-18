require_relative 'deck'

class Hand
  attr_accessor :cards
  
  def initialize(deck)
    @cards = deck.deal_cards(5)
  end
  
  def type
    return 10 if royal_flush?
    return 9 if straight_flush?
    return 8 if four_kind?
    return 7 if full_house?
    return 6 if flush?
    return 5 if straight? 
    return 4 if three_kind?
    return 3 if two_pair?
    return 2 if pair?
    1 
  end
  
  def compare_hands(other_hand)
    comparison = self.type <=> other_hand.type
    if comparison == 0 
      comparison = self.pair_tie_break(other_hand)
    end  
    comparison
  end
  
  def pair_tie_break(other_hand)
    self_arr = parse_hash(self.value_hash).reverse
    other_arr = parse_hash(other_hand.value_hash).reverse

    i = 0
    while i < self_arr.count
      if self_arr[i][1] < other_arr[i][1]
        return 1
      elsif self_arr[i][1] > other_arr[i][1]
        return -1
      end
      i += 1
    end
    0
  end
  
  def value_hash
    count = Hash.new( 0 )
    cards.each do | card |
      count[card.value] += 1
    end
    count
  end
  
  private
  
  def royal_flush?
    sorted_vals = @cards.map { |card| card.poker_value }.sort
    straight_flush? && sorted_vals[-2] == 13
  end
  
  def straight_flush?
    flush? && straight?
  end
  
  def four_kind?
    value_hash.values.max == 4
  end
  
  def full_house?
    value_hash.values.include?(3) && value_hash.values.include?(2)
  end
  
  def flush?
    @cards.all? { |card| card.suit == cards[0].suit }
  end

  def straight? 
    sorted_vals = @cards.map { |card| card.poker_value }.sort
    return true if sorted_vals == [2, 3, 4, 5, 14]
    sorted_vals.uniq.length == 5 && sorted_vals.last - sorted_vals.first == 4
  end
  
  def three_kind?
    value_hash.values.max == 3
  end
  
  def two_pair?
    value_hash.values.count(2) == 2
  end
  
  def pair?
    value_hash.values.max == 2
  end

  def parse_hash(hash)
    parsed = hash.sort_by { |key, value| key }
    parsed.each { | cards | cards.reverse! }
    parsed.sort!
  end
  
end

    