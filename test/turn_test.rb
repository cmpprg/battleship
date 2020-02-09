require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'

class TurnTest < Minitest::Test

  def test_for_testing
    turn = Turn.new

    coordinate = "A1"
    assert_equal false, turn.validate_cell_fired_upon?(coordinate)

    turn.setup.computer_board.cells[coordinate].fire_upon

    assert_equal true, turn.validate_cell_fired_upon?(coordinate)
  end
end