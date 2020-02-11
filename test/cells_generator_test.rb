require "minitest/autorun"
require "minitest/pride"
require "./lib/cells_generator"

class CellGeneratorTest < Minitest::Test

  def test_it_exists
    cell_generator = CellsGenerator.new(10, 10)

    assert_instance_of CellsGenerator, cell_generator
  end
end
