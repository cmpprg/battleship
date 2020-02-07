require_relative 'ship'
require_relative 'board'
require_relative 'computer_placement'
class Setup
  attr_reader :computer_cruiser, :computer_submarine, :computer_board,:player_cruiser, :player_submarine, :player_board

  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
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
    cell_input(@player_cruiser)
    puts @player_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces)"
    cell_input(@player_submarine)
    #start game in turn_class
  end

  def cell_input(ship)
    user_input = gather_input.upcase.split
    cell_verification(ship, user_input)
    placement_verification(ship, user_input)
    @player_board.place(ship, user_input)
  end

  def placement_verification(ship, coordinates)
    if !@player_board.valid_placement?(ship, coordinates)
      puts "Those are invalid coordinates. Please try again:"
      cell_input(ship)
    end
    true
  end

  def cell_verification(ship, coordinates)
    if !coordinates.all?{|coord| player_board.valid_coordinate?(coord)}
      puts "Those are invalid coordinates. Please try again:"
      cell_input(ship)
    end
    true
  end


  def computer_setup
    computer_placement = ComputerPlacement.new(@computer_board)
    computer_placement.choice(@computer_cruiser)
    computer_placement.choice(@computer_submarine)
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
