require 'rspec'
require 'deck'

describe Deck do
  subject (:d) { Deck.new }
  it "creates an array of 52 unique cards" do
    expect(d.cards.uniq.count).to eq 52
  end
  
  describe "#deal_cards" do 
    it "removes n cards from the deck" do
      d.deal_cards(5)
      expect(d.cards.count).to eq 47  
    end
    
    it "returns an array of cards" do
      expect(d.deal_cards(5).all? { |card| card.class == Card }).to eq true
    end  
    
    it "returns the number of cards asked for" do
      expect(d.deal_cards(13).length).to eq 13
    end
  end
    
  describe "#return_cards" do
    it "puts an array of cards back in the deck" do
      hand = d.deal_cards(5)
      d.return_cards(hand)
      expect(d.cards.count).to eq 52
    end
    
    
  end
end