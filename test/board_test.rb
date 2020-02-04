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
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_it_can_validate_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal true, board.valid_placement?(submarine, ["D3", "D4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
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
end
