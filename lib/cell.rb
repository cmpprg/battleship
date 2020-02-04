class Cell
  attr_reader :coordinate, :ship

  def initialize coordinate
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship != nil ? false : true
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
    if !empty? && @ship.sunk?
      "X"
    elsif !empty?
      if is_player
        return "S" unless fired_upon?
        "H"
      else
        return "." unless fired_upon?
        "H"
      end
    else
      return "." unless fired_upon?
      "M"
    end
  end

end
