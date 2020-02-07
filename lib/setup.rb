require_relative 'ship'
require_relative 'board'
require_relative 'computer_placement'
class Setup
  attr_reader :cruiser, :submarine, :computer_board, :player_board

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @player_board = Board.new
  end

  def start
    puts "Welcome to BATTLESHIP"
    welcome_implement
  end

  def play_game
    puts computer_setup
    player_setup
  end

  def player_setup
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces)"
    user_input = gather_input
    cell_verification(user_input)
    #verify valid cells, write error message if invalid
    #verify valid placement, write error messages if invalid
    #place the ship at the coordinates given.
    #render board showing cruiser placed

    # puts "Enter the squares for the Submarine(2 spaces)"
    #verify valid cells, write error message if invalid
    #verify valid placement, write error messages if invalid
    #place the ship at the coordinates given.
    #render board showing cruiser placed

  end

  def cell_verification(coordinates)
    coordinates.split.all?{|coord| player_board.valid_coordinate?(coord)}
  end

  def computer_setup
    computer_placement = ComputerPlacement.new(@computer_board)
    computer_placement.choice(@cruiser)
    computer_placement.choice(@submarine)
    "I have laid out my ships on the grid"
  end

  def welcome_implement
    puts "Enter p to play. Enter q to quit"
    user_input = gather_input
    welcome(user_input)
  end

  def welcome(input)
    return p "Okay Bye" if input.downcase == "q"
    return play_game if input.downcase == "p"
    puts "Incorrect input. Please try again."
    welcome_implement
  end

  def gather_input
    print ">> "
    x = gets.chomp
  end
end
