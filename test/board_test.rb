require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new

    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.length
    assert_instance_of Cell, board.cells["A1"]
  end

  def test_if_coordinate_is_valid
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?(".")
  end

  def test_it_can_validate_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, [""])
    assert_equal false, board.valid_placement?(cruiser, ["/", "A2", "A3"])
    assert_equal false, board.valid_placement?(submarine, ["B1", "C1", "D1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal true, board.valid_placement?(submarine, ["D3", "D4"])
  end

  def test_coordinates_given_are_same_length_as_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, board.valid_placement?(cruiser, ["C2", "C3", "C4"])
  end

  def test_horizontal_letters
    board = Board.new

    assert_equal true, board.horizontal_letters?(["A1", "A2"])
    assert_equal false, board.horizontal_letters?(["A1", "B2", "D3"])
    assert_equal true, board.horizontal_letters?(["B1", "B2", "B3"])
    assert_equal false, board.horizontal_letters?(["C3", "B2"])
  end

  def test_horizontal_numbers
    board = Board.new

    assert_equal false, board.horizontal_numbers?(["A1", "A3", "A4"])
    assert_equal true, board.horizontal_numbers?(["B1", "B2", "B3"])
    assert_equal false, board.horizontal_numbers?(["D3", "C2"])
    assert_equal true, board.horizontal_numbers?(["C2", "C3"])
  end

  def test_vertical_numbers
    board = Board.new

    assert_equal false, board.vertical_numbers?(["A1", "A2", "A4"])
    assert_equal true, board.vertical_numbers?(["A4", "B4", "C4"])
    assert_equal false, board.vertical_numbers?(["C3", "D4"])
    assert_equal true, board.vertical_numbers?(["B2", "C2"])
  end

  def test_vertical_letters
    board = Board.new

    assert_equal false, board.vertical_letters?(["A1", "A2", "B2"])
    assert_equal true, board.vertical_letters?(["B2", "C2", "D2"])
    assert_equal false, board.vertical_letters?(["D1", "D3"])
    assert_equal true, board.vertical_letters?(["B1", "C1"])
  end

  def test_check_empty_method
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cruiser_coordinates = ["A1", "A2", "A3"]
    submarine_coordinates = ["A1", "B1"]

    assert_equal true, board.check_empty?(cruiser_coordinates)
    board.place(cruiser, cruiser_coordinates)
    assert_equal false, board.check_empty?(submarine_coordinates)
  end

  def test_ship_place_method
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    coordinates = ["A1", "A2", "A3"]
    cell1 = board.cells["A1"]
    cell2 = board.cells["A2"]
    cell3 = board.cells["A3"]

    board.place(cruiser, coordinates)

    assert_equal cruiser, cell1.ship
    assert_equal cruiser, cell2.ship
    assert_equal cell2.ship, cell3.ship
  end

  def test_valid_placement_against_overlapping_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_boards_render_method

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expected =  "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n"

    assert_equal expected, board.render

    player_expected = "  1 2 3 4 \n" +
                      "A S S S . \n" +
                      "B . . . . \n" +
                      "C . . . . \n" +
                      "D . . . . \n"


    assert_equal player_expected, board.render(true)
  end

  def test_render_method_can_take_a_hit
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    board.place(submarine, ["C3", "D3"])

    player_expected = "  1 2 3 4 \n" +
                      "A H S S . \n" +
                      "B . M . . \n" +
                      "C . . X . \n" +
                      "D . . X . \n"


    board.cells["A1"].fire_upon
    board.cells["B2"].fire_upon
    board.cells["C3"].fire_upon
    board.cells["D3"].fire_upon

    assert_equal player_expected, board.render(true)
  end

  def test_not_fired_upon_method
    board = Board.new

    assert_equal 16, board.not_fired_upon.length
    assert_equal true, board.not_fired_upon.keys.include?("A1")

    board.cells["A1"].fire_upon
    board.cells["D3"].fire_upon

    assert_equal 14, board.not_fired_upon.length
    assert_equal false, board.not_fired_upon.keys.include?("A1")
    assert_equal false, board.not_fired_upon.keys.include?("D3")
  end

  def test_coordinate_not_fired_upon_method
    board = Board.new
    coord = board.coordinate_not_fired_upon

    assert board.not_fired_upon.keys.include?(coord)

    board.cells[coord].fire_upon
    coord2 = board.coordinate_not_fired_upon

    assert board.not_fired_upon.keys.include?(coord2)
  end

  def test_if_a_cell_has_been_fired_upon
    board = Board.new

    assert_equal false, board.fired_upon?("A1")

    board.fire_upon("A1")

    assert board.fired_upon?("A1")
  end
end
