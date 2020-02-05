require_relative 'board'
require_relative 'ship'
class Battleship

  def start
    puts "Welcome to BATTLESHIP"
    welcome()
  end

  def welcome
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp.downcase
    return if input == "q"
    return play_game() if input == "p"
    puts "Incorrect input. Please try again"
  end

  def play_game

  end

  def computer_placement
    board = Board.new
    #random cells to pass validate placement
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    x = board.cells.keys
    count = 65
    hash = {}

    4.times do

      hash[count.chr.to_sym] = x.find_all do |cell|
                                cell[0] == count.chr
                              end
      count += 1
    end
    hash








    # #loop until valid placement equals true
    # loop do
    #   #random coordinates
    #   break if valid_placement?(ship, coordinates)
    # end
    # place_ship(submarine)
    # place_ship(cruiser)
  end
end
x = Battleship.new
x.computer_placement