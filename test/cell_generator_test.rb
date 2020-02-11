require "minitest/autorun"
require "minitest/pride"
require "./lib/cell_generator"

class CellGeneratorTest < Minitest::Test

  def setup
    @cell_generator = CellsGenerator.new(10, 9)
  end

  def test_it_exists
    assert_instance_of CellGenerator, @cell_generator
  end

  def test_it_has_attributes
    assert_equal 10, @cell_generator.height
    assert_equal 9, @cell_generator.width
  end
end
