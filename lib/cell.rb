class Cell
  attr_reader :coordinate, :ship

  def initialize coordinate
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    @ship != nil ? false : true
  end

  def place_ship(input_ship)
    @ship = input_ship
  end

  def fired_upon?
    false
  end

end
