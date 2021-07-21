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

    it 'tests horizontal placements' do
      expect(board.horizontal_placement?(["A1", "A2", "A3"])).to be(true)
      expect(board.horizontal_placement?(["A1", "A2", "B3"])).to be(false)
    end

    it 'vertical placements' do
      expect(board.vertical_placement?(["A1", "B1", "C1"])).to be(true)
      expect(board.vertical_placement?(["A1", "B1", "C2"])).to be(false)
    end

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
      expect(board.consecutive_horizontal_placements?(["D1", "D3", "D4"])).to be(false)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
    end

    it 'finds bad placements' do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "B4"])).to be(false)
      expect(board.valid_placement?(cruiser, ["C1", "C2", "C3"])).to be(true)
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

    it 'detects duplicate coordinates for same ship' do
      expect(board.duplicate_coordinates?(["A1", "A1"])).to be(true)
      expect(board.duplicate_coordinates?(["A1", "A2"])).to be(false)
    end

    it 'detects overlapping ships' do
      expect(board.ship_present?(["A1", "A2"])).to be(false)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.ship_present?(["A1", "A2"])).to be(true)
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(false)
      expect(board.valid_placement?(submarine, ["B1", "B2"])).to be(true)
    end
  end

  context 'board render method' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    it 'renders initialized cells' do
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'renders hits when a ship has been fired upon' do
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      board.cells.fetch("A1").fire_upon
      expect(board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")
      board.cells.fetch("A2").fire_upon
      expect(board.render).to eq("  1 2 3 4 \nA H H . . \nB . . . . \nC . . . . \nD . . . . \n")
      board.cells.fetch("A3").fire_upon
      expect(board.render).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'renders ships on the board when the argument true is given' do
      expect(board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")

      submarine = Ship.new("Submarine", 2)
      board.place(submarine, ["B2", "B3"])

      expect(board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . S S . \nC . . . . \nD . . . . \n")

    end
  end
end
