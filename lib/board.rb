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
    same_length?(ship, coordinates)
  end

  def same_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive?(ship, coordinates)

  end

  def horizontal_letters?(coordinates)
    new_coords = coordinates.map do |coord|
      coord[0]
    end
    new_coords.uniq.length == 1
  end

  def horizontal_numbers?(coordinates)
    number = (1..4).to_a
    num = number.each_cons(coordinates.length).to_a
    new_coords = coordinates.map do |coord|
      coord[1].to_i
    end
    num.any? do |n|
      n.eql?(new_coords)
    end
  end
end