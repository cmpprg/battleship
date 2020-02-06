require_relative 'ship'
require_relative 'board'
require_relative 'computer_placement'
class Battleship
  attr_reader :cruiser, :submarine, :computer_board, :player_board

  def initialize
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @player_board = Board.new
  end

  def start
    puts "Welcome to BATTLESHIP"
    welcome()
  end

  def play_game
    computer_setup
  end

  def player_setup

  end

  def computer_setup
    computer_placement = ComputerPlacement.new(@computer_board)
    computer_placement.choice(@cruiser)
    computer_placement.choice(@submarine)
    puts "I have laid out my ships on the grid"
    require "pry"; binding.pryear
  end

  def welcome
    puts "Enter p to play. Enter q to quit"
    input = gets.chomp.downcase
    return if input == "q"
    return play_game() if input == "p"
    puts "Incorrect input. Please try again"
  end
end
