class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end
  
  def place_ship(input_ship)
    @ship = input_ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship.hit unless empty?
  end

  def render(is_player = false)
    return "X" if !empty? && @ship.sunk?
    return "H" if !empty? && fired_upon?
    return "M" if empty? && fired_upon?
    return "S" if !empty? && is_player
    return "."
  end

end
