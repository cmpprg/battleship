require_relative 'ship'
require_relative 'board'
require_relative 'computer_placement'
class Setup
  attr_reader :computer_cruiser, :computer_submarine, :computer_board,:player_cruiser, :player_submarine, :player_board
#TEST COMPLETE
  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @player_board = Board.new
  end
#TEST COMPLETE, I DON'T KNOW HOW TO MAKE PUTS NOT SHOW UP.
  def introduction_and_setup
    puts "Welcome to BATTLESHIP"
    welcome_implement
    puts computer_setup
    puts player_setup
  end
#TEST COMPLETE, SAME WITH THE PUTS IN THE TEST.
  def welcome_implement
    user_input = ""
    loop do
      puts "Enter p to play. Enter q to quit"
      user_input = gather_input.downcase
      break if valid_response?(user_input)
    end
    quit_game if user_input == "q"
  end
#TEST COMPLETE
  def valid_response?(response)
    return true if response == "p" || response == "q"
    puts "Incorrect input. Please try again."
    false
  end
#TEST COMPLETE
  def computer_setup
    computer_placement = ComputerPlacement.new(@computer_board)
    computer_placement.choice(@computer_cruiser)
    computer_placement.choice(@computer_submarine)
    "I have laid out my ships on the grid"
  end
#NOT TESTED TODO
  def player_setup
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
    player_cruiser_setup
    puts @player_board.render(true)
    player_submarine_setup
    "Great positions lets take our first turn."
  end
#NOT TESTED TODO
  def player_cruiser_setup
    puts "Enter the coordinates for the Cruiser (3 spaces)"
    cell_input(@player_cruiser)
  end
#NOT TESTED TODO
  def player_submarine_setup
    puts "Enter the coordinates for the Submarine (2 spaces)"
    cell_input(@player_submarine)
  end
#NOT TESTED TODO
  def cell_input(ship)
    user_input = ""
    loop do
      user_input = gather_input.upcase.split
      break if coordinates_valid?(ship, user_input)
    end
    @player_board.place(ship, user_input)
  end
#NOT TESTED TODO
  def coordinates_valid?(ship, coordinates)
    cell_verification(ship, coordinates) &&
    placement_verification(ship, coordinates)
  end
#NOT TESED TODO
  def cell_verification(ship, coordinates)
    if !coordinates.all?{|coord| player_board.valid_coordinate?(coord)}
      puts "Those coordinates do not exist on the board. Please choose other coordinates:"
      false
    else
      true
    end
  end
# NOT TESTED TODO
  def placement_verification(ship, coordinates)
    if !@player_board.valid_placement?(ship, coordinates)
      puts "Those are invalid coordinates. Please choose other coordinates:"
      false
    else
      true
    end
  end

  def quit_game
    abort("Okay Byeeeeeee...")
  end
#DO NOT NEED TO TEST
  def gather_input
    print ">> "
    gets.chomp
  end
end
