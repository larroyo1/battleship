require 'rspec'
require './lib/ship'

RSpec.describe Ship do

  context 'initialize' do
    cruiser = Ship.new("Cruiser", 3)

    it 'exists with attributes' do
      expect(cruiser).to be_a(Ship)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end

    it 'is still afloat' do
      expect(cruiser.sunk?).to be(false)
    end

    it 'takes damage and sinks' do
      cruiser.hit
      expect(cruiser.health).to eq(2)
      expect(cruiser.sunk?).to be(false)
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to be(true)
    end
  end
end
