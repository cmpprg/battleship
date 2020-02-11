require_relative 'cell'
class Board

  attr_reader :cells

  def initialize
    @cells = {"A1" => Cell.new("A1"),
              "A2" => Cell.new("A2"),
              "A3" => Cell.new("A3"),
              "A4" => Cell.new("A4"),
              "B1" => Cell.new("B1"),
              "B2" => Cell.new("B2"),
              "B3" => Cell.new("B3"),
              "B4" => Cell.new("B4"),
              "C1" => Cell.new("C1"),
              "C2" => Cell.new("C2"),
              "C3" => Cell.new("C3"),
              "C4" => Cell.new("C4"),
              "D1" => Cell.new("D1"),
              "D2" => Cell.new("D2"),
              "D3" => Cell.new("D3"),
              "D4" => Cell.new("D4")}
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    check_empty?(coordinates) && (ship.length == coordinates.length) && (horizontal?(coordinates) ^ vertical?(coordinates))
  end

  def horizontal?(coordinates)
    horizontal_letters?(coordinates) && horizontal_numbers?(coordinates)
  end

  def horizontal_letters?(coordinates)
    new_coords = coordinates.map do |coord|
      coord[0]
    end
    new_coords.uniq.length == 1
  end

  def horizontal_numbers?(coordinates)
    number = (1..4).to_a
    all_numbers = number.each_cons(coordinates.length).to_a
    new_coords = coordinates.map do |coord|
      coord[1].to_i
    end
    all_numbers.any? do |num|
      num.eql?(new_coords)
    end
  end

  def vertical?(coordinates)
    vertical_numbers?(coordinates) && vertical_letters?(coordinates)
  end

  def vertical_numbers?(coordinates)
    numbers = coordinates.map do |coord|
      coord[1]
    end
    numbers.uniq.length == 1
  end

  def vertical_letters?(coordinates)
    coords = ("A".."D").to_a
    new_coord = coords.each_cons(coordinates.length).to_a
    letters = coordinates.map do |coord|
      coord[0]
    end
    new_coord.any? do |new|
      new.eql?(letters)
    end
  end

  def check_empty?(coordinates)
    coordinates.all? do |coord|
      @cells[coord].empty?
    end

  end

  def place(ship, coordinates)
    coordinates.each do |cell|
      cells[cell].place_ship(ship)
    end
  end

  def not_fired_upon
    cells.find_all { |_coordinate, object| !object.fired_upon? }.to_h
  end

  def coordinate_not_fired_upon
    not_fired_upon.keys.sample
  end

  def fire_upon(coordinate)
    cells[coordinate].fire_upon
  end

  def fired_upon?(coordinate)
    cells[coordinate].fired_upon?
  end

  def render(is_player = false)

    "  1 2 3 4 \n" +
    "A #{cells["A1"].render(is_player)} #{cells["A2"].render(is_player)} #{cells["A3"].render(is_player)} #{cells["A4"].render(is_player)} \n" +
    "B #{cells["B1"].render(is_player)} #{cells["B2"].render(is_player)} #{cells["B3"].render(is_player)} #{cells["B4"].render(is_player)} \n" +
    "C #{cells["C1"].render(is_player)} #{cells["C2"].render(is_player)} #{cells["C3"].render(is_player)} #{cells["C4"].render(is_player)} \n" +
    "D #{cells["D1"].render(is_player)} #{cells["D2"].render(is_player)} #{cells["D3"].render(is_player)} #{cells["D4"].render(is_player)} \n"
  end
end
