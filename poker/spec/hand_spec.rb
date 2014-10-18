require 'rspec'
require 'hand'


describe Hand do
  subject (:h) { Hand.new(Deck.new) }
  subject (:hand2) { Hand.new(Deck.new) }
  
  it "is instantiated with 5 cards" do
    expect(h.cards.count).to eq 5
  end

  
  describe "#type" do
    let (:h2)  { Card.new(:hearts, :two) }
    let (:h3)  { Card.new(:hearts, :three) }
    let (:h4)  { Card.new(:hearts, :four) }
    let (:h5)  { Card.new(:hearts, :five) }
    let (:h6)  { Card.new(:hearts, :six) }
    let (:h10) { Card.new(:hearts, :ten) }
    let (:s3)  { Card.new(:spades, :three) }
    let (:s10) { Card.new(:spades, :ten) }
    let (:s11) { Card.new(:spades, :jack) }
    let (:s12) { Card.new(:spades, :queen) }
    let (:s13) { Card.new(:spades, :king) }
    let (:s14) { Card.new(:spades, :ace) }
    let (:d3)  { Card.new(:diamonds, :three) }
    let (:c3)  { Card.new(:clubs, :three) }

    it "correctly identifies a royal flush" do
      h.cards = ([s10, s11, s12, s13, s14])
      expect(h.type).to eq 10
    end

    it "correctly identifies a straight flush" do
      h.cards = ([h2, h3, h4, h5, h6])
      expect(h.type).to eq 9
    end
    
    it "correctly identifies four of a kind" do 
      h.cards = ([s3, h3, d3, c3, h2])
      expect(h.type).to eq 8
    end
      
    it "correctly identifies full house" do 
      h.cards = ([s3, h3, d3, s10, h10])
      expect(h.type).to eq 7
    end

    it "correctly identifies a flush" do
      h.cards = ([h2, h10, h4, h5, h6])
      expect(h.type).to eq 6
    end
    
    it "correctly determines a straight" do
      h.cards = ([h2, c3, h4, h5, h6])
      expect(h.type).to eq 5
    end
    
    it "correctly determines an ace low straight" do
      h.cards = ([s14, h2, c3, h4, h5])
      expect(h.type).to eq 5
    end
    
    it "correctly determines three of a kind" do 
      h.cards = ([s3, h3, d3, h6, h2])
      expect(h.type).to eq 4
    end
    
    it "correctly identifies two pair" do 
      h.cards = ([s3, h3, h10, s10, h2])
      expect(h.type).to eq 3
    end
    
    it "correctly identifies pair" do 
      h.cards = ([s3, h3, h5, s10, h2])
      expect(h.type).to eq 2
    end
    
    it "correctly identifies high card" do 
      h.cards = ([s3, h6, h5, s10, h2])
      expect(h.type).to eq 1
    end

  end

  describe "#compare_hands(other_hand)" do
    let (:h2)  { Card.new(:hearts, :two) }
    let (:h3)  { Card.new(:hearts, :three) }
    let (:h4)  { Card.new(:hearts, :four) }
    let (:h5)  { Card.new(:hearts, :five) }
    let (:h6)  { Card.new(:hearts, :six) }
    let (:h10) { Card.new(:hearts, :ten) }
    let (:s3)  { Card.new(:spades, :three) }
    let (:s10) { Card.new(:spades, :ten) }
    let (:s11) { Card.new(:spades, :jack) }
    let (:s12) { Card.new(:spades, :queen) }
    let (:s13) { Card.new(:spades, :king) }
    let (:s14) { Card.new(:spades, :ace) }
    let (:d3)  { Card.new(:diamonds, :three) }
    let (:d10) { Card.new(:diamonds, :ten) }
    let (:c3)  { Card.new(:clubs, :three) }
    let (:c10) { Card.new(:clubs, :ten) }
    
    it "correctly determines better of two hands of different types" do
      h.cards = ([s3, h3, h5, s10, h2])
      hand2.cards = ([s3, h3, h10, s10, h2])
      expect(h.compare_hands(hand2)).to eq -1
      expect(hand2.compare_hands(h)).to eq 1
    end
      
    it "correctly breaks ties behind two hands of the same type" do
      h.cards = ([s3, h3, h5, s10, h2])
      hand2.cards = ([s3, h3, h5, s14, h2])
      expect(h.compare_hands(hand2)).to eq -1
      expect(hand2.compare_hands(h)).to eq 1
    end
      
    it "correctly finds a tie" do
      h.cards = ([s3, h3, c3, s10, d10])
      hand2.cards = ([s3, h3, c3, h10, s10])
      expect(h.compare_hands(hand2)).to eq 0
      expect(hand2.compare_hands(h)).to eq 0
    end
  end
    
end
