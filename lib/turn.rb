require_relative 'setup'
class Turn

  def initialize
    @setup = Setup.new
  end

  def start_game
    @setup.initialize_new
    #need to welcome @setup.introduction
    @setup.computer_setup
    @setup.player_setup
    take_turn
  end

  def take_turn
    puts "=============COMPUTER BOARD============="

    puts @setup.computer_board.render

    puts "==============PLAYER BOARD=============="

    puts @setup.player_board.render(true)

    puts "Enter the coordinate for your shot:"

    shot_implementation

  end

  def shot_implementation
    player = fire_on_shot_implementation
    computer = computer_shot_implementation
    shot_results(player, computer)
  end

  def fire_on_shot_implementation
    coordinate = player_shot_implementation
    @setup.computer_board.cells[coordinate].fire_upon
    player_game_over?(coordinate)
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

  def validate_cell_fired_upon?(coordinate)
    if @setup.computer_board.cells[coordinate].fired_upon?
      puts "Coordinate has already been fired upon, please enter another coordinate: "
      false
    else
      true
    end
  end

  def computer_shot_implementation
    comp_shot = @setup.player_board.cells.keys.sample
    until !@setup.player_board.cells[comp_shot].fired_upon?
      comp_shot = @setup.player_board.cells.keys.sample
    end
    @setup.player_board.cells[comp_shot].fire_upon
    computer_game_over?(comp_shot)
  end

  def print_cell_results(render)
    return "miss" if render == "M"
    return "hit" if render == "H"
    "sunk"
  end

  def shot_results(player, computer)
    player_render = print_cell_results(@setup.computer_board.cells[player].render)
    computer_render = print_cell_results(@setup.player_board.cells[computer].render)
    puts "Your shot on #{player} was a #{player_render}."
    puts "My shot on #{computer} was a #{computer_render}."
    take_turn
  end

  def player_game_over?(coordinate)
    if @setup.computer_cruiser.sunk? && @setup.computer_submarine.sunk?
      end_game(true, nil)
      false
    else
      coordinate
    end
  end

  def computer_game_over?(coordinate)
    if @setup.player_cruiser.sunk? && @setup.player_submarine.sunk?
      end_game(nil, true)
      false
    else
      coordinate
    end
  end

  def end_game(player_results, computer_results)
    if player_results || !computer_results
      puts "You won!"
    else
      puts "I won!"
    end
    replay
  end

  def replay
    puts "Enter 'p' to play again or 'q' to quit: "
    replay_input = @setup.gather_input.downcase
    if replay_input == "p"
      start_game
    elsif replay_input == "q"
      return "Thank You! Please play again."
    else
      puts "This is not an option, please enter a valid input."
      replay
    end
  end
end