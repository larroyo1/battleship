require './ship'
require './cell'
require './board'

class Gameplay
  attr_reader :board

  def initialize
    @board     = Board.new
    @cruiser   = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
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
   puts "Enter three coordinates for the Cruiser (Letter/Number):"
   cruiser_coordinates = gets.chomp
   cruiser_coordinates = cruiser_coordinates.split
   puts "Enter two coordinates for the Submarine (Letter/Number):"
   sub_coordinates = gets.chomp
   sub_coordinates = sub_coordinates.split
   place_cruiser(cruiser_coordinates)
   place_submarine(sub_coordinates)
  end

  def place_cruiser(coordinates)
    if @board.valid_placement?(@cruiser, coordinates)
      @board.place(@cruiser, coordinates)
      else
        puts "Those are invalid Cruiser coordinates. Please try again:"
    end
  end

  def place_submarine(coordinates)
    if @board.valid_placement?(@submarine, coordinates)
      @board.place(@submarine, coordinates)
      else
        puts "Those are invalid Submarine coordinates. Please try again:"
    end
  end

  def end_game
    puts "goodbye"
  end
  require "pry"; binding.pry
end
