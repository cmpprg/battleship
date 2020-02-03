require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"

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

end
