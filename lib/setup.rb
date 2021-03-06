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

  def computer_setup
    computer_placement = ComputerPlacement.new(@computer_board)
    computer_placement.choice(@computer_cruiser)
    computer_placement.choice(@computer_submarine)
    "I have laid out my ships on the grid"
  end

  def player_setup
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
    player_ship_setup(@player_cruiser)
    puts @player_board.render(true)
    player_ship_setup(@player_submarine)
  end

  def player_ship_setup(ship)
    puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces)"
    cell_input(ship)
  end

  def cell_input(ship)
    user_input = ""
    loop do
      user_input = gather_input.upcase.split
      break if coordinates_valid?(ship, user_input)
    end
    @player_board.place(ship, user_input)
  end

  def coordinates_valid?(ship, coordinates)
    cell_verification?(ship, coordinates) &&
    placement_verification?(ship, coordinates)
  end

  def cell_verification?(ship, coordinates)
    if !coordinates.all?{|coord| player_board.valid_coordinate?(coord)}
      puts "Those coordinates do not exist on the board. Please choose other coordinates:"
      false
    else
      true
    end
  end

  def placement_verification?(ship, coordinates)
    if !@player_board.valid_placement?(ship, coordinates)
      puts "Those are invalid coordinates. Please choose other coordinates:"
      false
    else
      true
    end
  end

  def gather_input
    print ">> "
    gets.chomp
  end
end
