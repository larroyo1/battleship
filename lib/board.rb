require './cell'

class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells_hash = {}
    numbers = [1, 2, 3, 4]
    letters = ["A", "B", "C", "D"]

    letters.each do |letter|
      numbers.each do |number|
        cell_name = letter + number.to_s
        cells_hash[cell_name] = Cell.new(cell_name)
      end
    end
    return cells_hash
  end

  def valid_coordinate?(coordinate)
    if coordinate.class == Array
      coordinate.each do |cell|
        @cells.include? coordinate
        end
        true
    elsif @cells.include? coordinate
        true
    else
        false
    end
  end

  def valid_placement?(ship, coordinates)

    ship.length == coordinates.length && valid_coordinate?(coordinates)
  end

end
