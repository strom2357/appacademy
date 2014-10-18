require 'rspec'
require 'card'

describe Card do
  subject (:c) { Card.new(:spades, :ace) }
  
  it "returns its suit" do
    expect(c.suit).to eq :spades
  end
  
  it "returns its value" do
    expect(c.value).to eq :ace
  end
  
  describe "#poker_value" do
    it "returns a numerical value" do
      expect(c.poker_value).to eq 14
    end
  end
end

#
# describe Hand do
# end
#
# describe Player do
# end
#
# describe Game do
# end
