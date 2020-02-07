require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship'
require './lib/board'
require './lib/computer_placement'

class ComputerPlacementTest < Minitest::Test

  def test_it_exists
    board = Board.new
    computer_placement = ComputerPlacement.new(board)

    assert_instance_of ComputerPlacement, computer_placement
  end

  def test_it_has_attributes
    board = Board.new
    computer_placement = ComputerPlacement.new(board)

    assert_equal board, computer_placement.board
    assert_equal board.cells.keys, computer_placement.board_cells
  end

  def test_it_can_place_a_ship
    board = Board.new
    computer_placement = ComputerPlacement.new(board)
    cruiser = Ship.new("Cruiser", 3)

    computer_placement.stubs(:choice).returns(["A1", "A2", "A3"])
  end

  def test_it_can_validate_potential_coordinates
    board = Board.new
    computer_placement = ComputerPlacement.new(board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, computer_placement.validate?(cruiser)
    assert_equal true, computer_placement.validate?(submarine)
  end

  def test_it_can_return_total_potentials
    board = Board.new
    computer_placement = ComputerPlacement.new(board)
    cruiser = Ship.new("Cruiser", 3)

    expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]

    assert_equal expected, computer_placement.total_potentials(cruiser)
  end

  def test_it_can_return_horizontal_potentials
    board = Board.new
    computer_placement = ComputerPlacement.new(board)
    cruiser = Ship.new("Cruiser", 3)

    expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"]]

    assert_equal expected, computer_placement.horizontal_potentials(cruiser)
  end

  def test_it_can_return_vertical_potentials
    board = Board.new
    computer_placement = ComputerPlacement.new(board)
    cruiser = Ship.new("Cruiser", 3)

    expected = [["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]

    assert_equal expected, computer_placement.vertical_potentials(cruiser)
  end

  def test_it_can_return_row_quantity
    board = Board.new
    computer_placement = ComputerPlacement.new(board)

    assert_equal 4, computer_placement.row_quantity
  end
end