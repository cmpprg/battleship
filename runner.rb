require './lib/ship'
require './lib/board'
require './lib/battleship'
require './lib/computer_placement'

computer_board = Board.new
player_board = Board.new
cruiser = Ship.new("Cruiser", 3)
battleship = Battleship.new
computer_placement = ComputerPlacement.new(computer_board)


computer_placement.choice(cruiser)
computer_board.render(true)