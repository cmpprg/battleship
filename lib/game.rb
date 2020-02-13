require_relative 'setup'
class Game

  attr_accessor :setup

  def initialize
    @setup = nil
  end

  def start(play)
    puts "Welcome to BATTLESHIP"
    while play
      play = welcome?
      if play
        @setup = Setup.new
        @setup.computer_setup
        @setup.player_setup
        game
      end
    end
  end

  def welcome?
    user_input = ""
    loop do
      puts "Enter p to play. Enter q to quit"
      puts ">>"
      user_input = gets.chomp.downcase
      break if valid_response?(user_input)
    end
    return false if user_input == "q"
    true
  end

  def valid_response?(response)
    return true if response == "p" || response == "q"
    puts "Incorrect input. Please try again."
    false
  end

  def game
    loop do
      puts "=============COMPUTER BOARD============="

      puts @setup.computer_board.render

      puts "==============PLAYER BOARD=============="

      puts @setup.player_board.render(true)

      puts "Enter the coordinate for your shot:"

      shot_implementation

      break if player_game_over? || computer_game_over?
    end
  end

  def shot_implementation
    player = fire_on_shot_implementation
    computer = computer_shot_implementation
    shot_results(player, computer)
  end

  def fire_on_shot_implementation
    coordinate = player_shot_implementation
    @setup.computer_board.fire_upon(coordinate)
    coordinate
  end

  def player_shot_implementation
    loop do
      shot_coord = @setup.gather_input.upcase
      break shot_coord if shot_valid?(shot_coord)
    end
  end

  def shot_valid?(coordinate)
    validate_coordinate_exists?(coordinate) &&
        !validate_cell_fired_upon?(coordinate)
  end

  def validate_coordinate_exists?(coordinate)
    if @setup.computer_board.valid_coordinate?(coordinate)
      true
    else
      puts "Coordinate does not exist on the board, please enter another coordinate: "
      false
    end
  end

  def validate_cell_fired_upon?(coordinate)
    if @setup.computer_board.fired_upon?(coordinate)
      puts "Coordinate has already been fired upon, please enter another coordinate: "
      true
    else
      false
    end
  end

  def computer_shot_implementation
    comp_shot = @setup.player_board.coordinate_not_fired_upon
    @setup.player_board.fire_upon(comp_shot)
    comp_shot
  end

  def print_cell_results(render)
    return "was a miss" if render == "M"
    return "was a hit" if render == "H"
    "sunk a ship"
  end

  def shot_results(player, computer)
    player_render = print_cell_results(@setup.computer_board.cells[player].render)
    computer_render = print_cell_results(@setup.player_board.cells[computer].render)
    puts "Your shot on #{player} #{player_render}."
    puts "My shot on #{computer} #{computer_render}."
  end

  def player_game_over?
    if @setup.computer_cruiser.sunk? && @setup.computer_submarine.sunk?
      end_game(true, nil)
      true
    else
      false
    end
  end

  def computer_game_over?
    if @setup.player_cruiser.sunk? && @setup.player_submarine.sunk?
      end_game(nil, true)
      true
    else
      false
    end
  end

  def end_game(player_results, computer_results)
    if player_results || !computer_results
      puts "****************************************"
      puts " ~ ~ ~ ~ ~ ~ ~ ~YOU WON!~ ~ ~ ~ ~ ~ ~ ~ "
      puts "****************************************"
    else
      puts "****************************************"
      puts "~ ~ ~ ~ ~ ~ ~ ~ ~I WON!~ ~ ~ ~ ~ ~ ~ ~ ~"
      puts "****************************************"
    end
  end
end
