require_relative 'setup'
class Turn

  def initialize
    @setup = Setup.new
  end

  def start(play)
    puts "Welcome to BATTLESHIP"
    while play
      play = @setup.welcome?
      if play
        @setup.initialize_new
        @setup.computer_setup
        @setup.player_setup
        game
      end
    end
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
        validate_cell_fired_upon?(coordinate)
  end

  def validate_coordinate_exists?(coordinate)
    if !@setup.computer_board.valid_coordinate?(coordinate)
      puts "Coordinate does not exist on the board, please enter another coordinate: "
      false
    else
      true
    end
  end

  # consider changing name to validate_cell_not_fired_upon?
  def validate_cell_fired_upon?(coordinate)
    if @setup.computer_board.fired_upon?(coordinate)
      puts "Coordinate has already been fired upon, please enter another coordinate: "
      false
    else
      true
    end
  end

  #this validation is unecessary as the computers shot already coms from an array of not shot at cells
  def computer_shot_implementation
    comp_shot = ""
    loop do
      comp_shot = @setup.player_board.coordinate_not_fired_upon
      break if !@setup.player_board.fired_upon?(comp_shot)
    end
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
      puts "You won!"
    else
      puts "I won!"
    end
  end

end