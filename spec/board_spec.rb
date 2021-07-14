require 'rspec'
require './lib/board'

RSpec.describe Board do

  context 'initialize' do
    board = Board.new

    it 'exists' do
      expect(board).to be_a(Board)
    end

    xit 'has cells' do
      expect(board.cells).to eq(cellhash)
    end
  end

end
