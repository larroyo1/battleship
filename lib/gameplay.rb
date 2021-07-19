require './lib/ship'
require './lib/cell'
require './lib/board'

class Gameplay

  def initialize
    @board     = Board.new
    @cruiser   = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def welcome_message
    "Welcome to BATTLESHIP
  Enter p to play. Enter q to quit."

    if gets.chomp == 'p'
      start_game
    else
      end_game
    end
  end


  def start_game
   puts "I have laid out my ships on the grid.
You now need to lay out your two ships.
The Cruiser is three units long and the Submarine is two units long."
   puts @board.render
  end

  def end_game
    puts "goodbye"
  end

require "pry"; binding.pry

end
