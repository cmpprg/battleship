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

  def test_introduction_and_setup_method
    welcome_implement_spy = Spy.on(@setup, :welcome_implement)
    computer_setup_spy = Spy.on(@setup, :computer_setup)
    player_setup_spy = Spy.on(@setup, :player_setup)
    @setup.introduction_and_setup

    assert welcome_implement_spy.has_been_called?
    assert computer_setup_spy.has_been_called?
    assert player_setup_spy.has_been_called?
  end

  def test_welcome_implement_method_play
    play_gather_input_spy = Spy.on(@setup, :gather_input).and_return("p")
    @setup.welcome_implement

    assert play_gather_input_spy.has_been_called?
    assert @setup.valid_response?(@setup.gather_input)
  end

  def test_welcome_implement_method_quit
    quit_gather_input_spy = Spy.on(@setup, :gather_input).and_return("q")
    quit_game_spy = Spy.on(@setup, :quit_game)
    @setup.welcome_implement

    assert quit_gather_input_spy.has_been_called?
    assert @setup.valid_response?(@setup.gather_input)
    assert quit_game_spy.has_been_called?
  end

  def test_valid_response_method
    play_game_input = "p"
    quit_game_input = "q"
    invalid_input = "$"


    assert @setup.valid_response?(play_game_input)
    assert @setup.valid_response?(quit_game_input)
    assert_equal false, @setup.valid_response?(invalid_input)
  end

  def test_computer_setup_method
    assert_equal "I have laid out my ships on the grid", @setup.computer_setup
    assert_equal 3, @setup.computer_board.cells.values.count { |cell| cell.ship == @setup.computer_cruiser }
    assert_equal 2, @setup.computer_board.cells.values.count { |cell| cell.ship == @setup.computer_submarine }
  end

  def test_player_setup_method
    player_cruiser_setup_spy = Spy.on(@setup, :player_cruiser_setup)
    player_submarine_setup_spy = Spy.on(@setup, :player_submarine_setup)

    assert_equal "Great positions lets take our first turn.", @setup.player_setup
    assert player_cruiser_setup_spy.has_been_called?
    assert player_submarine_setup_spy.has_been_called?
  end

  def test_cell_verfication_method
    good_coordinates = "A2 A3 A4"
    bad_coordinates = "F1, A1, B2"

    assert_equal true, @setup.cell_verification(@computer_cruiser, good_coordinates)

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
