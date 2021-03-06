require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"
require "./lib/ship"

class CellTest < Minitest::Test

  def test_it_exists
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_instance_of Cell, cell
  end

  def test_attributes
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_equal coordinate, cell.coordinate
    assert_nil cell.ship
  end

  def test_cell_empty_method
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_equal true, cell.empty?
  end

  def test_place_ship_method
    coordinate = "A1"
    cell = Cell.new(coordinate)
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

  def test_fired_upon_method
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_equal false, cell.fired_upon?
  end

  def test_fire_upon_method
    coordinate = "A1"
    cell = Cell.new(coordinate)
    cell.fire_upon

    assert_equal true, cell.fired_upon?

    coordinate = "A1"
    cell = Cell.new(coordinate)
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end

  def test_render_method_no_ship
    coordinate = "A1"
    cell = Cell.new(coordinate)

    assert_equal ".", cell.render

    cell.fire_upon

    assert_equal "M", cell.render
  end

  def test_render_method_with_ship
    coordinate = "A1"
    cell = Cell.new(coordinate)
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal ".", cell.render

    cell.fire_upon

    assert_equal "H", cell.render
  end

  def test_render_method_for_player_with_ship
    coordinate = "A1"
    cell = Cell.new(coordinate)
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal "S", cell.render(true)

    cell.fire_upon

    assert_equal "H", cell.render(true)
  end

  def test_render_method_if_ship_sunk?
    coordinate = "A1"
    cell = Cell.new(coordinate)
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    cell.fire_upon
    cell.fire_upon
    
    assert_equal "X", cell.render
  end
end
