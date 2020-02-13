require 'o_stream_catcher'
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

  def test_shot_valid
    game = Game.new
    game.setup = Setup.new

    assert_equal true, game.shot_valid?("A3")
    assert_equal false, game.shot_valid?("3M")
  end

  def test_a_coordinate_exists
    game = Game.new
    game.setup = Setup.new

    assert_equal false, game.validate_coordinate_exists?("M4")
    assert_equal true, game.validate_coordinate_exists?("A3")
  end

  def test_it_can_verify_cell_fired_upon
    game = Game.new
    game.setup = Setup.new

    assert_equal false, game.validate_cell_fired_upon?("A3")
  end

  def test_it_can_implement_computer_shot
    game = Game.new
    game.setup = Setup.new

    game.stubs(:computer_shot_implementation).returns("D3")
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
    expected = "Your shot on A3 sunk a ship.\n" +
               "My shot on B1 sunk a ship.\n"

    result, stdout, stderr = OStreamCatcher.catch do
      game.shot_results("A3", "B1")
    end

    assert_equal expected, stdout
  end

  def test_player_game_over
    game = Game.new
    game.setup = Setup.new

    assert_equal false, game.player_game_over?

    game.setup.computer_board.place(game.setup.computer_cruiser, ["A1", "A2", "A3"])
    game.setup.computer_board.place(game.setup.computer_submarine, ["B3", "B4"])
    game.setup.computer_board.cells["A1"].fire_upon
    game.setup.computer_board.cells["A2"].fire_upon
    game.setup.computer_board.cells["A3"].fire_upon
    game.setup.computer_board.cells["B3"].fire_upon
    game.setup.computer_board.cells["B4"].fire_upon

    assert_equal true, game.player_game_over?
  end

  def test_computer_game_over
    game = Game.new
    game.setup = Setup.new

    assert_equal false, game.computer_game_over?

    game.setup.player_board.place(game.setup.player_cruiser, ["A1", "A2", "A3"])
    game.setup.player_board.place(game.setup.player_submarine, ["B3", "B4"])
    game.setup.player_board.cells["A1"].fire_upon
    game.setup.player_board.cells["A2"].fire_upon
    game.setup.player_board.cells["A3"].fire_upon
    game.setup.player_board.cells["B3"].fire_upon
    game.setup.player_board.cells["B4"].fire_upon

    assert_equal true, game.computer_game_over?
  end

  def test_it_can_end_game
    game = Game.new

    expected1 = "****************************************\n" +
                " ~ ~ ~ ~ ~ ~ ~ ~YOU WON!~ ~ ~ ~ ~ ~ ~ ~ \n" +
                "****************************************\n"

    result, stdout, stderr = OStreamCatcher.catch do
      game.end_game(true, nil)
    end

    assert_equal expected1, stdout

    expected2 =  "****************************************\n" +
                 "~ ~ ~ ~ ~ ~ ~ ~ ~I WON!~ ~ ~ ~ ~ ~ ~ ~ ~\n" +
                 "****************************************\n"

    result, stdout, stderr = OStreamCatcher.catch do
      game.end_game(nil, true)
    end

    assert_equal expected2, stdout
  end
end