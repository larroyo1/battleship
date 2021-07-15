require 'rspec'
require './lib/board'

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

end
