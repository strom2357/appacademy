require_relative 'card'
class Deck
  attr_accessor :cards
  
  def all_cards
    cards = []
    52.times do | i |
      cards << Card.new(Card.suits[(i + 1) % 4], Card.values[(i + 1) % 13])
    end
    cards
  end
  
  def initialize
    @cards = all_cards
  end
  
  def deal_cards(n)
    hand = []
    n.times { hand << @cards.shift }
    hand
  end
  
  def return_cards(hand)
    hand.each do | card |
      cards.push(card)
    end
  end
end