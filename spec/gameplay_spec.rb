require 'rspec'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/gameplay'

RSpec.describe Gameplay do

  context 'Initialize gameplay class' do
    game = Gameplay.new

    it 'exists' do
      expect(game).to be_a(Gameplay)
    end

    xit 'welcomes a user' do
      expect(game.welcome_message).to eq("Welcome to BATTLESHIP\n  Enter p to play. Enter q to quit.")
    end
  end
end
