require './cell'
require './ship'
require './board'
require './gameplay'

class Turn

  def initialize
    @game = Gameplay.new
  end

  def setup
    @game.welcome_message
    take_turns
  end

  def take_turns
    @game.display_boards
    loop do
      @game.user_fire
      puts "thinking..."
      sleep(3)
      @game.cpu_fire
      break if (@game.cpu_cruiser.sunk? && @game.cpu_submarine.sunk?) ||
      (@game.cruiser.sunk? && @game.submarine.sunk?)
    end

    if (@game.cpu_cruiser.sunk? && @game.cpu_submarine.sunk?)
      puts "You Won!"
    elsif (@game.cruiser.sunk? && @game.submarine.sunk?)
      puts "I won!"
    end
    end_of_game
  end

  def end_of_game
    puts "Would you like to play again?"
    puts "p to start new game, q to quit"
    user_input = gets.downcase.chomp

    if user_input == "p"
      turn = Turn.new
      turn.setup
    else
      puts "Thanks for playing!"
    end
  end
end

turn = Turn.new
turn.setup
