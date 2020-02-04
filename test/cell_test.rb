require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"
require "./lib/ship"

class CellTest < Minitest::Test

  def test_it_exists
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_instance_of Cell, cell
  end

  def test_attributes
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_equal coordinate, cell.coordinate
    assert_nil cell.ship
  end

  def test_cell_empty_method
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_equal true, cell.empty?
  end

  def test_place_ship_method
    coordinate = "A1"
    cell = Cell.new(coordinate)
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

end
