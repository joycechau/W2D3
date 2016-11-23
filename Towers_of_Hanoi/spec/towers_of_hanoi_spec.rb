require "towers_of_hanoi"
require "rspec"

describe TowersOfHanoi do
  subject(:towers) { TowersOfHanoi.new(3) }

  describe "#initialize" do
    it "initializes first tower with disks in descending order" do
      expect(towers.first).to eq([3, 2, 1])
    end

    it "initializes second and third towers as empty arrays" do
      expect(towers.second).to be_empty
      expect(towers.third).to be_empty
    end

    context "when no size is given" do
      subject(:towers) { TowersOfHanoi.new }

      it "initializes first tower with 5 disks" do
        expect(towers.first).to eq([5, 4, 3, 2, 1])
      end
    end
  end

  describe '#make_move' do
    it "moves a disk from one tower to another tower" do
      towers.make_move(towers.first, towers.second)
      expect(towers.first).to eq([3, 2])
      expect(towers.second).to eq([1])
      towers.make_move(towers.second, towers.third)
      expect(towers.second).to eq([])
      expect(towers.third).to eq([1])
    end

    it "raises an error if starting tower is empty" do
      expect { towers.make_move(towers.second, towers.third) }.to raise_error("Invalid move!")
    end

    it "raises an error if moving disk is greater than ending tower's top disk" do
      towers.second = [2]
      towers.third = [1]
      expect { towers.make_move(towers.second, towers.third) }.to raise_error("Invalid move!")
    end
  end


  describe "#won?" do

    it "returns true if second or third tower has all the disks in proper order" do
      towers.first = []
      towers.second = [3, 2, 1]
      expect(towers.won?).to be true
      towers.second = []
      towers.third = [3, 2, 1]
      expect(towers.won?).to be true
    end

    it "returns false if second or third tower has all the disks in incorrect order" do
      towers.first = []
      towers.second = [2, 3, 1]
      expect(towers.won?).to be false
      towers.second = []
      towers.third = [2, 3, 1]
      expect(towers.won?).to be false
    end

    it "returns false if game is in process" do
      towers.first = [3]
      towers.second = [2]
      towers.third = [1]
      expect(towers.won?).to be false
    end
  end
end