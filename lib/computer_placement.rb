require_relative 'board'
class ComputerPlacement

  def initialize
    @board = Board.new
  end

  def horizontal_potentials(ship)
    board_cells = @board.cells.keys
    letter_count = 65
    horizontal_subset = {}

    row_quantity().times do
      horizontal_subset[letter_count.chr.to_sym] = board_cells.find_all do |cell|
                                                    cell[0] == letter_count.chr
                                                  end
      letter_count += 1
    end
    row_potentials = horizontal_subset.map do |_letter, coordinates|
      coordinates.each_cons(ship.length).to_a
    end
    row_potentials.flatten!(1)
  end

  def row_quantity
    @board.cells.keys.map { |cell| cell[0] }.uniq.length
  end
end