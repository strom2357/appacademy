require 'rspec'
require 'array'

describe "#my_uniq" do
  it "removes repeat items in an array" do
    expect([1, 2, 3, 5, 4, 3].my_uniq).to eq [1, 2, 3, 5, 4]
  end
end

describe "#two_sum" do 
  it "returns the positions of items in an array that sum to two" do
    expect([-1, 0, 2, -2, 1].two_sum).to eq [[0, 4], [2, 3]]
  end
end

describe "#my_transpose" do
  it "row i becomes column i, column j becomes row j" do 
    expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]].my_transpose).to eq [
      [1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end
end

describe "#stock_picker" do
  it "picks the two best days to buy and sell" do
    expect([2, 1, 4, 8, 5, 7].stock_picker).to eq [1, 3]
  end
  
  it "doesn't pick anything if there isn't any profit possible" do
    expect([2, 1, 0, -8, -15, -17].stock_picker).to eq []
  end
end





































describe TowersOfHanoi do
  subject(:h) { TowersOfHanoi.new }
  it "should have a TowersOfHanoi class" do
    h.class.should == TowersOfHanoi
  end

  it "should have 3 towers" do
    h.towers.length.should == 3
  end

  it "starts with three discs on the first tower" do
    expect(h.towers[0]).to eq [3, 2, 1]
  end


  describe "#move" do

    it "successfully moves a disc from tower to tower" do
      h.move(0, 1)
      h.towers.should == [[3, 2], [1], []]
    end

    it "does not move from nonexistent tower" do
      expect do
        h.move(5, 1)
      end.to raise_error
    end

    it "does not move from an empty tower" do
      expect do
        h.move(2, 0)
      end.to raise_error
    end

    it "does not move onto a smaller disc" do
      expect do
        h.move(0, 1)
        h.move(0, 1)
      end.to raise_error
    end

  end

  describe "#winning?" do

    it "should not recognize a full first tower as a victory" do
      h.winning?.should == false
    end

    it "should recognize winning game state" do
      h.towers = [[], [], [3, 2, 1]]
      h.winning?.should == true
    end
  end
end





