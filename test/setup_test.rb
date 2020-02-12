require "minitest/autorun"
require "minitest/pride"
require "./lib/setup"
require "mocha/minitest"
require "spy/integration"

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

  def test_computer_setup_method
    assert_equal "I have laid out my ships on the grid", @setup.computer_setup
    assert_equal 3, @setup.computer_board.cells.values.count { |cell| cell.ship == @setup.computer_cruiser }
    assert_equal 2, @setup.computer_board.cells.values.count { |cell| cell.ship == @setup.computer_submarine }
  end

  def test_player_setup_method
    player_ship_setup_spy = Spy.on(@setup, :player_ship_setup)
    render_board_spy = Spy.on(@setup.player_board, :render)
    @setup.player_setup

    assert render_board_spy.has_been_called?
    assert_equal 2, render_board_spy.calls.count
    assert player_ship_setup_spy.has_been_called?
    assert_equal 2, player_ship_setup_spy.calls.count
  end

  def test_player_ship_setup
    ship = @setup.player_cruiser
    cell_input_spy = Spy.on(@setup, :cell_input)
    @setup.player_ship_setup(ship)

    assert cell_input_spy.has_been_called?
  end

  def test_cell_input_method
    ship = @setup.player_cruiser
    gather_input_spy = Spy.on(@setup, :gather_input).and_return("a1 a2 a3")
    @setup.cell_input(ship)

    assert gather_input_spy.has_been_called?
    assert_equal 3, @setup.player_board.cells.values.count{|object| object.ship == ship}
  end

  def test_coordinates_valid_method
    cruiser = @setup.player_cruiser
    good_coordinates = ["A1", "A2", "A3"]
    not_enough_coordinates = ["A1", "B2"]
    not_on_board_coordinates = ["A3", "A4", "A5"]

    assert @setup.coordinates_valid?(cruiser, good_coordinates)
    assert_equal false, @setup.coordinates_valid?(cruiser, not_enough_coordinates)
    assert_equal false, @setup.coordinates_valid?(cruiser, not_on_board_coordinates)

    submarine = @setup.player_submarine
    overlap_coordinates = ["A2", "B2"]
    @setup.player_board.place(cruiser, good_coordinates)

    assert_equal false, @setup.coordinates_valid?(submarine, overlap_coordinates)
  end

  def test_cell_verification_method
    cruiser = @setup.player_cruiser
    good_coordinates = ["D1", "D2", "D3"]
    bad_coordinates = ["Z1", "Z2"]

    assert @setup.cell_verification?(cruiser, good_coordinates)
    assert_equal false, @setup.cell_verification?(cruiser, bad_coordinates)
  end

  def test_placement_verification_method
    cruiser = @setup.player_cruiser
    good_coordinates = ["B1", "B2", "B3"]
    diagonal_coordinates = ["A1", "B2", "B3"]

    assert @setup.placement_verification?(cruiser, good_coordinates)
    assert_equal false, @setup.placement_verification?(cruiser, diagonal_coordinates)

    submarine = @setup.player_submarine
    overlap_coordinates = ["A2", "B2"]
    @setup.player_board.place(cruiser, good_coordinates)

    assert_equal false, @setup.placement_verification?(cruiser, overlap_coordinates)

  end

end
