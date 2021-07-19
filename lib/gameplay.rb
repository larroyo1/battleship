require './lib/ship'
require './lib/cell'
require './lib/board'

class Gameplay
  attr_reader :ship_array, :board

  def initialize
    @board     = Board.new
    @cruiser   = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @ship_array = []
  end

  def welcome_message
    puts "Welcome to BATTLESHIP
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
   puts "Enter the first coordinate for the Cruiser (Letter/Number):"
   @ship_array << gets.chomp
   puts "Enter the second coordinate for the Cruiser:"
   @ship_array << gets.chomp
   puts "Enter the final coordinate for the Cruiser:"
   @ship_array << gets.chomp
   place_cruiser
   puts "Enter the first coordinate for the Submarine (Letter/Number):"
   @ship_array << gets.chomp
   puts "Enter the final coordinate for the Submarine:"
   @ship_array << gets.chomp
   place_submarine
  end

  def place_cruiser
    if @board.place(@cruiser, @ship_array)
      else
        puts "Those are invalid Cruiser coordinates. Please try again:"
    end
  end

  def place_submarine
    if @board.place(@submarine, @ship_array[3, 4])
      else
        puts "Those are invalid Submarine coordinates. Please try again:"
    end
  end

  def end_game
    puts "goodbye"
  end

require "pry"; binding.pry

end
