require './lib/ship'

class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def place_ship(ship_name)
     @ship = ship_name
     ship
  end

  def empty?
    @ship == nil
  end

end
