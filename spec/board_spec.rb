require 'rspec'
require './lib/board'
require './lib/ship'

RSpec.describe Board do

  context 'initialize' do
    board = Board.new

    it 'exists' do
      expect(board).to be_a(Board)
    end

    it 'has cells' do
      expect(board.cells.count).to eq(16)
    end

    it 'has valid coordinates' do
      expect(board.valid_coordinate?("A4")).to be(true)
      expect(board.valid_coordinate?("E3")).to be(false)
    end
  end

  context 'ship placements' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    it 'has valid ship placement' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
      #double check this test
      expect(board.valid_placement?(submarine, ["A2", "A3"])).to be(true)
    end


    xit 'tests for all valid placements' do
      expect(board.all_valid_placements?(['A1', 'R1', '11'])).to eq(false)
      expect(board.all_valid_placements?(['A1', 'A2', 'A3', 'C3'])).to eq(true)
    end
  end
end
