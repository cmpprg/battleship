require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/game'

class GameTest < Minitest::Test

  #TODO this file is all notes thus far.
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_can_play_the_game
    skip 
  end

  def test_it_can_start_the_game
    skip
  end

  def test_shot_implementation
    skip
  end

  def test_player_fire_on_shot_implementation
    skip
  end

  def test_player_shot_implementation
    skip
    game = Game.new

    Kernel.stubs(:gets).returns("A1")
    input = Kernel.gets

    assert_equal true, game.shot_valid?("A1")
    assert_equal "A1", game.player_shot_implementation
  end

  def test_shot_valid
    skip
    game = Game.new
  end

  def test_a_coordinate_exists
    game = Game.new

    Kernel.stubs(:gets).returns("A1")
    input = Kernel.gets
    game.stubs(:valid_coordinate?).returns(true)
  end

  def test_it_can_print_cell_results
    game = Game.new

    assert_equal "was a miss", game.print_cell_results("M")
    assert_equal "was a hit", game.print_cell_results("H")
    assert_equal "sunk a ship", game.print_cell_results("S")
  end

  def test_it_can_return_shot_results
    game = Game.new

    game.setup = Setup.new
    expected = "Your shot on A3 was a miss"
               "My shot on B1 sunk a ship"

    assert_equal expected, game.shot_results("A3", "B1")
  end

  def test_player_game_over
    skip
  end

  def test_computer_game_over
    skip
  end

  def test_it_can_end_game
    game = Game.new

    expected1 = "****************************************"
                "~ ~ ~ ~ ~ ~ ~ ~YOU WON!~ ~ ~ ~ ~ ~ ~ ~"
                "****************************************"

    assert_equal expected1, game.end_game(true, nil)

    expected2 =  "****************************************"
                 "~ ~ ~ ~ ~ ~ ~ ~ ~I WON!~ ~ ~ ~ ~ ~ ~ ~ ~"
                 "****************************************"

    assert_equal expected2, game.end_game(nil, true)
  end
end

#
# def test_welcome_method_play
#   play_gather_input_spy = Spy.on(@setup, :gather_input).and_return("p")
#   @setup.welcome?
#
#   assert @setup.valid_response?(@setup.gather_input)
#   assert @setup.welcome?
#
# end
#
#   def test_welcome_method_quit
#     quit_gather_input_spy = Spy.on(@setup, :gather_input).and_return("q")
#     @setup.welcome?
#
#     assert @setup.valid_response?(@setup.gather_input)
#     assert_equal false, @setup.welcome?
#   end
#
# def test_valid_response_method
#     play_game_input = "p"
#     quit_game_input = "q"
#     invalid_input = "$"
#
#
#     assert @setup.valid_response?(play_game_input)
#     assert @setup.valid_response?(quit_game_input)
#     assert_equal false, @setup.valid_response?(invalid_input)
#   end