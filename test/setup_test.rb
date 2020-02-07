require "minitest/autorun"
require "minitest/pride"
require "./lib/setup"
require "mocha/minitest"

class SetupTest < Minitest::Test
  def setup
    @setup = Setup.new
  end

  def test_it_exists
    assert_instance_of Setup, @setup
  end

  def test_it_has_attributes
    assert_instance_of Ship, @setup.player_cruiser
    assert_instance_of Ship, @setup.player_submarine
    assert_instance_of Ship, @setup.computer_cruiser
    assert_instance_of Ship, @setup.computer_submarine
    assert_instance_of Board, @setup.computer_board
    assert_instance_of Board, @setup.player_board
  end

  def test_welcome_method
    #come back and figure out how to test this method.
  end

  def test_computer_setup_method
    assert_equal "I have laid out my ships on the grid", @setup.computer_setup
    assert_equal 3, @setup.computer_board.cells.values.count { |cell| cell.ship == @setup.computer_cruiser }
    assert_equal 2, @setup.computer_board.cells.values.count { |cell| cell.ship == @setup.computer_submarine }
  end

  def test_cell_verfication_method
    good_coordinates = "A2 A3 A4"
    bad_coordinates = "F1, A1, B2"

    assert_equal true, @setup.cell_verification(good_coordinates)

    @setup = mock
    @setup.stubs(:cell_verification).with(:bad_coordinates).returns(:cell_input)
  end

  def test_placement_verification_method
    cruiser = Ship.new("Cruiser", 3)
    # set up test for placement verification method
    assert @setup.placement_verification(cruiser, "A1 A2 A3")
  end

  def test_cell_input_method
    # form integration test for method
  end


end
