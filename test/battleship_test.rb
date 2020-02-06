require "minitest/autorun"
require "minitest/pride"
require "./lib/battleship"
require "o_stream_catcher"

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
    assert_instance_of String, @battleship.user_input
  end

  def test_user_input_method
    puts "Please type in whatever you like."
    assert_equal @battleship.gather_input, @battleship.user_input
  end

  def test_welcome_method
    
  end
end
