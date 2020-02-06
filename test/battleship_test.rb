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
  
end
