require './lib/ship'
require './lib/battleship'
require './lib/computer_placement'

cruiser = Ship.new("Cruiser", 3)
battleship = Battleship.new
computer_placement = ComputerPlacement.new

computer_placement.horizontal_potentials(cruiser)

