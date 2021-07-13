require './lib/cell'
require './lib/ship'

RSpec.describe Cell do

  context 'initialize' do
    cell = Cell.new('B4')

    it 'exists with attributes' do
      expect(cell).to be_a(Cell)
      expect(cell.coordinate).to eq('B4')
    end

    it 'The cell starts empty' do
      expect(cell.ship).to eq(nil)
      expect(cell.empty?).to eq(true)
    end

    it 'can have a ship placed in it' do
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq(false)
    end
  end
end
