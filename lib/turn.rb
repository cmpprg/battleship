require_relative 'setup'
class Turn

  def initialize
    @setup = Setup.new
  end

  def start_game
    @setup.computer_setup
    @setup.player_setup
    playing_the_game
  end

  def playing_the_game
    puts "=============COMPUTER BOARD============="

    puts @setup.computer_board.render

    puts "==============PLAYER BOARD=============="

    puts @setup.player_board.render(true)

    puts "Enter the coordinate for your shot:"

    shot_coord = @setup.gather_input

    if !@setup.computer_board.valid_coordinate?(shot_coord)
      puts "Please enter a valid coordinate:"
      @setup.computer_board.valid_coordinate?(shot_coord)
    else
      true
    end
  end

  #fire_upon a cell, both player and computer

  # puts "Your shot on A CELL was a ----.
  #       My shot on A CELL was a ----."
  #
  # #end game with
  #
  # puts "I won!"
  #
  # #or
  #
  # puts "You won!"
end