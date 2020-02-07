require "minitest/autorun"
require "minitest/pride"
require "./lib/battleship"

class BattleshipTest < Minitest::Test
  def setup
    @battleship = Battleship.new
  end

  def test_it_exists
    assert_instance_of Battleship, @battleship
  end

  def test_it_has_attributes
    assert_instance_of Ship, @battleship.cruiser
    assert_instance_of Ship, @battleship.cruiser
    assert_instance_of Board, @battleship.computer_board
    assert_instance_of Board, @battleship.player_board
  end

  def test_welcome_method
    #come back and figure out how to test this method.
  end

  def test_computer_setup_method
    assert_equal "I have laid out my ships on the grid", @battleship.computer_setup
    assert_equal 3, @battleship.computer_board.cells.values.count { |cell| cell.ship == @battleship.cruiser }
    assert_equal 2, @battleship.computer_board.cells.values.count { |cell| cell.ship == @battleship.submarine }
  end

  def test_cell_verfication_method
  end

  
end
