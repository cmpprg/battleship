require "minitest/autorun"
require "minitest/pride"
require "./lib/cell_generator"

class CellGeneratorTest < Minitest::Test

  def setup
    @cell_generator = CellGenerator.new(10, 9)
  end

  def test_it_exists
    assert_instance_of CellGenerator, @cell_generator
  end

  def test_it_has_attributes
    assert_equal 10, @cell_generator.height
    assert_equal 9, @cell_generator.width
  end

  def test_it_can_produce_the_last_letter_based_on_height
    cell_generator1 = CellGenerator.new(27, 4)
    cell_generator2 = CellGenerator.new(4123, 4)
    assert_equal "AA", cell_generator1.last_letter
    assert_equal "FBO", cell_generator2.last_letter
  end

  def test_it_can_produce_a_range_of_letters_based_on_height
    cell_generator1 = CellGenerator.new(27, 4)
    cell_generator2 = CellGenerator.new(4123, 4)
    assert_equal ("A".."AA").to_a, cell_generator1.generate_letters_range
    assert_equal ("A".."FBO").to_a, cell_generator2.generate_letters_range
  end

end
