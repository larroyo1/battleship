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
      sleep(5)
      @game.cpu_fire
      break if (@game.cpu_cruiser.sunk? == true && @game.cpu_submarine.sunk? == true) ||
      (@game.cruiser.sunk? == true && @game.submarine.sunk? == true)
    end

    if (@game.cpu_cruiser.sunk? == true && @game.cpu_submarine.sunk? == true)
      puts "You Won!"
    elsif (@game.cruiser.sunk? == true && @game.submarine.sunk? == true)
      puts "I won!"
    end    
  end







end

turn = Turn.new
turn.setup
