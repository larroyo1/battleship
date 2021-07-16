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
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    it 'has valid ship placement' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
      expect(board.valid_placement?(submarine, ["A2", "A3"])).to be(true)
    end


    it 'tests for all valid placements' do
      expect(board.all_valid_placements?(['A1', 'R1', '11'])).to eq(false)
      expect(board.all_valid_placements?(['A1', 'A2', 'A3', 'C3'])).to eq(true)
    end

    it 'validates vertical placement' do
      expect(board.consecutive_vertical_placements?(["A1", "B1", "C1"])).to be(true)
      expect(board.consecutive_vertical_placements?(["A1", "B1", "D1"])).to be(false)
    end

    it 'validates horizontal placement' do
      expect(board.consecutive_horizontal_placements?(["A1", "A2", "A3"])).to be(true)
      expect(board.consecutive_horizontal_placements?(["A1", "A2", "A4"])).to be(false)
    end

    it 'finds bad placements' do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
    end

    it 'places ships' do
      board.place(cruiser, ['A1', 'A2', 'A3'])

      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_1.ship).to eq(cell_2.ship)
    end
  end

  context 'overlap' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    it 'detects overlapping ships' do
      expect(board.ship_present?(["A1", "A2"])).to be(false)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.ship_present?(["A1", "A2"])).to be(true)
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(false)

    end
  end
end
