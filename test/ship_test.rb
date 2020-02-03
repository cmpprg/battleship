require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_it_has_attributes
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
  end

  def test_it_has_health
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
  end

  def test_it_starts_not_sunk
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cruiser.sunk?
  end

  def test_it_can_take_a_hit
    cruiser = Ship.new("Cruiser", 3)

    cruiser.hit

    assert_equal 2, cruiser.health

    cruiser.hit

    assert_equal 1, cruiser.health
    assert_equal false, cruiser.sunk?

    cruiser.hit

    assert_equal true, cruiser.sunk?
  end
end