require './ship'

class Cell
  attr_accessor :fired_upon



  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @fired_upon = false
    # @render     = '.'
  end

  def place_ship(ship_name)
     @ship = ship_name
     ship
  end

  def empty?
    @ship == nil
  end

  def fire_upon
    if @ship != nil
      @ship.hit
      @fired_upon = true
    else
      @fired_upon = true
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal = false)
    if reveal == true && !empty? && !fired_upon
      "S"
    elsif reveal == true && !empty? && fired_upon? && !@ship.sunk?
      "H"
    elsif reveal == true && empty? && fired_upon?
      "M"
    elsif reveal == true && !empty && fired_upon? && @ship.sunk?
      "X"
    elsif fired_upon? && empty?
      "M"
    elsif !empty? && fired_upon? && @ship.sunk?
      "X"
    elsif !empty? && fired_upon? && !@ship.sunk?
      "H"
    else
      '.'
    end
  end
end
