require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"

class CellTest < Minitest::Test

  def test_it_exists
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_instance_of Cell, cell
  end

end
