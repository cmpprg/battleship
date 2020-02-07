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

    shot_implementation

  end

  def shot_implementation
    shot_coord = @setup.gather_input.upcase
    validate_coordinate_exists?(shot_coord)
    validate_cell_fired_upon?(shot_coord)
    puts "the end"
  end

  def validate_coordinate_exists?(coordinate)
    if !@setup.computer_board.valid_coordinate?(coordinate)
      puts "Coordinate does not exist on the board, please enter another coordinate: "
      return shot_implementation
    end
    puts "valid coordinate"
  end

  def validate_cell_fired_upon?(coordinate)
    if @setup.computer_board.cells[coordinate].fired_upon?
      puts "Coordinate has already been fired upon, please enter another coordinate: "
      return shot_implementation
    end
    puts "not fired upon"
    @setup.computer_board.cells[coordinate].fire_upon
    puts @setup.computer_board.render(true)
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