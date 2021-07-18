require './cell'
require 'pry'

class Board
  attr_reader :cells, :cell_renders, :ship_cells

  def initialize
    @cells = create_cells
    @cell_renders = []
    @ship_cells = []
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
    @cells.include? coordinate
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def all_valid_placements?(coordinates_array)
    coordinates_array.all? do |coordinate_index|
      valid_coordinate?(coordinate_index)
    end
  end

  def consecutive_placements?(coordinates_array)
     horizontal_placement? || vertical_placement?
   end

  def horizontal_placement?(coordinates_array)
    coordinate_first_characters =
    coordinates_array.map do |coordinate|
      coordinate[0]
    end

    coordinate_first_characters.uniq.length !=
    coordinate_first_characters.length
  end

  def vertical_placement?(coordinates_array)
    coordinate_second_characters =
    coordinates_array.map do |coordinate|
      coordinate[1]
    end

    coordinate_second_characters.uniq.length !=
    coordinate_second_characters.length
  end

  def consecutive_vertical_placements?(coordinates_array)
    index_0 = coordinates_array.map {|coordinate| coordinate[0]}

    index_0 == (index_0.first..index_0.last).to_a
  end

  def consecutive_horizontal_placements?(coordinates_array)
    index_1 = coordinates_array.map {|coordinate| coordinate[1]}

    index_1 == (index_1.first..index_1.last).to_a
  end

  def ship_present?(coordinates_array)
    coordinates_array.any? do |coordinate|
       @cells[coordinate].empty? == false
    end
  end

  def duplicate_coordinates?(coordinates_array)
     coordinates_array != coordinates_array.uniq
  end

  def valid_placement?(ship, coordinates)
    !ship_present?(coordinates) &&
    ship.length == coordinates.length &&
    !duplicate_coordinates?(coordinates) &&
    all_valid_placements?(coordinates) &&
    horizontal_placement?(coordinates) ||
    vertical_placement?(coordinates) &&
    consecutive_vertical_placements?(coordinates) &&
    consecutive_horizontal_placements?(coordinates)
  end

  def each_cell_render
  cell_instances = @cells.values

    @cell_renders =
    cell_instances.map do |cell_instance|
      cell_instance.render
    end
  end

  def each_cell_status
  cell_instances = @cells.values

    @ship_cells =
    cell_instances.map do |cell_instance|
      if cell_instance.ship == nil
        "."
      else
        "S"
      end
    end
  end

  def render(reveal = false)
    if reveal == true
      each_cell_status
      "1 2 3 4 \nA #{@ship_cells[0]} #{@ship_cells[1]} #{@ship_cells[2]} #{@ship_cells[3]} \nB #{@ship_cells[4]} #{@ship_cells[5]} #{@ship_cells[6]} #{@ship_cells[7]} \nC #{@ship_cells[8]} #{@ship_cells[9]} #{@ship_cells[10]} #{@ship_cells[11]} \nD #{@ship_cells[12]} #{@ship_cells[13]} #{@ship_cells[14]} #{@ship_cells[15]} \n"
    else
      each_cell_render
      "1 2 3 4 \nA #{@cell_renders[0]} #{@cell_renders[1]} #{@cell_renders[2]} #{@cell_renders[3]} \nB #{@cell_renders[4]} #{@cell_renders[5]} #{@cell_renders[6]} #{@cell_renders[7]} \nC #{@cell_renders[8]} #{@cell_renders[9]} #{@cell_renders[10]} #{@cell_renders[11]} \nD #{@cell_renders[12]} #{@cell_renders[13]} #{@cell_renders[14]} #{@cell_renders[15]} \n"
    end
  end
end
