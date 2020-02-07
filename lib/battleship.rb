require_relative 'ship'
require_relative 'board'
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

  end


end