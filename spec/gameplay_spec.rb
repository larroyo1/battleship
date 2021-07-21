require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/gameplay'

RSpec.describe Gameplay do
  it 'exists' do
    game = Gameplay.new
    expect(game).to be_a(Gameplay)
  end
end
