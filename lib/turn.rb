require_relative 'setup'
class Turn

  def initialize
    @setup = Setup.new
  end

  def start_game
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
    player = player_shot_implementation
    computer = computer_shot_implementation
    shot_results(player, computer)
  end

  def player_shot_implementation
    shot_coord = @setup.gather_input.upcase
    until @setup.computer_board.valid_coordinate?(shot_coord) && !@setup.computer_board.cells[shot_coord].fired_upon?
      puts "Invalid coordinate, please enter another coordinate: "
      shot_coord = @setup.gather_input.upcase
    end
    @setup.computer_board.cells[shot_coord].fire_upon
    shot_coord
  end

  def computer_shot_implementation
    comp_shot = @setup.player_board.cells.keys.sample
    until !@setup.player_board.cells[comp_shot].fired_upon?
      comp_shot = @setup.player_board.cells.keys.sample
    end
    @setup.player_board.cells[comp_shot].fire_upon
    comp_shot
  end

  def print_cell_results(render)
    if render == "M"
      "miss"
    elsif render == "H"
      "hit"
    else
      "sunk"
    end
  end

  def shot_results(player, computer)
    player_render = print_cell_results(@setup.computer_board.cells[player].render)
    computer_render = print_cell_results(@setup.player_board.cells[computer].render)
    puts "Your shot on #{player} was a #{player_render}."
    puts "My shot on #{computer} was a #{computer_render}."
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