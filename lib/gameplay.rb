require './ship'
require './cell'
require './board'

class Gameplay

  attr_reader :cpu_board,
              :board


  def initialize
    @board         = Board.new
    @cpu_board     = Board.new
    @cruiser       = Ship.new('Cruiser', 3)
    @submarine     = Ship.new('Submarine', 2)
    @cpu_cruiser   = Ship.new('Computer Cruiser', 3)
    @cpu_submarine = Ship.new('Computer Submarine', 2)
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
   place_cruiser(cruiser_coordinates)
   puts "Enter two coordinates for the Submarine (Letter/Number):"
   sub_coordinates = gets.chomp
   sub_coordinates = sub_coordinates.split
   place_submarine(sub_coordinates)
  end

  def place_cruiser(coordinates)
    if @board.valid_placement?(@cruiser, coordinates)
      @board.place(@cruiser, coordinates)
      else
        puts "Those are invalid Cruiser coordinates. Please try again:"
        cruiser_coordinates = gets.chomp
        cruiser_coordinates = cruiser_coordinates.split
        place_cruiser(cruiser_coordinates)
    end
  end

  def place_submarine(coordinates)
    if @board.valid_placement?(@submarine, coordinates)
      @board.place(@submarine, coordinates)
      else
        puts "Those are invalid Submarine coordinates. Please try again:"
        sub_coordinates = gets.chomp
        sub_coordinates = sub_coordinates.split
        place_submarine(sub_coordinates)
    end
  end

  def cpu_place_ships
    cpu_place_cruiser
    cpu_place_submarine
  end

  def cpu_place_cruiser
    coordinates_sample = []
    loop do
      coordinates_sample = @cpu_board.cells.keys.sample(3)
      break if @cpu_board.valid_placement?(@cpu_cruiser, coordinates_sample)
    end
    @cpu_board.place(@cpu_cruiser, coordinates_sample)
  end

  def cpu_place_submarine
    coordinates_sample = []
    loop do
      coordinates_sample = @cpu_board.cells.keys.sample(2)
      break if @cpu_board.valid_placement?(@cpu_submarine, coordinates_sample)
    end
    @cpu_board.place(@cpu_submarine, coordinates_sample)
  end

  def display_boards
    lines = '=' * 13
    puts "#{lines}COMPUTER BOARD#{lines}"
    puts @cpu_board.render
    puts "#{lines}PLAYER BOARD#{lines}"
    puts @board.render(true)
  end


  def user_fire
    puts "Enter the coordinate for your shot:"
    chosen_coordinate = gets.chomp
    if @cpu_board.valid_coordinate?(chosen_coordinate) && @cpu_board.cells[chosen_coordinate].fired_upon == true
    puts "You've already fired on this cell. Please enter a valid coordinate"
    user_fire
    elsif @cpu_board.valid_coordinate?(chosen_coordinate)
      @cpu_board.cells[chosen_coordinate].fire_upon
    else
      puts "Invalid coordinate. Please enter a valid coordinate"
      user_fire
    end
  end

  def cpu_fire
    coordinate = @board.cells.keys.sample
      if @board.cells[coordinate].fired_upon? == false
        @board.cells.fetch(coordinate).fire_upon
      else
        cpu_fire
      end
  end

  def end_game
    puts "goodbye"
  end
  require "pry"; binding.pry
end
