# -*- coding: utf-8 -*-
class Card
  
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUES = {
    :two => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }
  
  attr_reader :suit, :value
  
  def self.suits
    SUIT_STRINGS.keys
  end
  
  def self.values
    VALUES.keys
  end
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
  
  def poker_value
    VALUES[@value]
  end
end
