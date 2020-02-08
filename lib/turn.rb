require_relative 'setup'
class Turn

  attr_reader :setup
  def initialize
    @setup = Setup.new
  end

  def start_game
    #@setup.introduction TODO
    @setup.computer_setup
    @setup.player_setup
    take_turn
  end

  def take_turn
    board_renders
    puts "Enter the coordinate for your shot:"
    player_shot_implementation
    comp_shot_implementation
    take_turn # if !end_game? TODO
  end

  def board_renders
    puts "=============COMPUTER BOARD============="

    puts @setup.computer_board.render

    puts "==============PLAYER BOARD=============="

    puts @setup.player_board.render(true)
  end

  def player_shot_implementation
    shot_coord = ""
    loop do
      shot_coord = @setup.gather_input.upcase
      break if shot_valid?(shot_coord)
    end
    @setup.computer_board.fire_upon(shot_coord)
  end

  def shot_valid?(coord)
    validate_coordinate_exists?(coord) &&
    validate_cell_fired_upon?(coord)
  end

  def validate_coordinate_exists?(coordinate)
    if !@setup.computer_board.valid_coordinate?(coordinate)
      puts "Coordinate does not exist on the board, please enter another coordinate: "
      false
    else
      true
    end
  end

  def validate_cell_fired_upon?(coordinate)
    if !@setup.computer_board.not_fired_upon.include?(coordinate)
      puts "Coordinate has already been fired upon, please enter another coordinate: "
      false
    else
      true
    end
  end

  def comp_shot_implementation
    comp_shot = @setup.player_board.coordinate_not_fired_upon
    @setup.player_board.fire_upon(comp_shot)
  end
end
