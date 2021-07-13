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

  def fire_upon
    if empty?
      return 'empty fire'
    else @ship.hit
    end
  end

  def fired_upon?
    @ship.health < @ship.length
  end

  def render
    if fire_upon == 'empty fire'
      return 'M'
    elsif fired_upon?
      return 'H'
    elsif @ship.health == 0
      return 'X'
    else
      return '.'
    end
  end
end
