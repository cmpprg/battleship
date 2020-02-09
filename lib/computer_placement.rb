class ComputerPlacement

  attr_reader :board, :board_cells

  def initialize(board)
    @board = board
    @board_cells = @board.cells.keys
    @coordinates = []
  end

  def choice(ship)
    validate?(ship)
    @board.place(ship, @coordinates)
  end

  def validate?(ship)
    until @board.valid_placement?(ship, @coordinates) do
      @coordinates = total_potentials(ship).sample
    end
    true
  end

  def total_potentials(ship)
    horizontal_potentials(ship) + vertical_potentials(ship)
  end

  def horizontal_potentials(ship)
    letter_count = 65
    horizontal_subset = {}

    row_quantity().times do
      horizontal_subset[letter_count.chr.to_sym] = @board_cells.find_all do |cell|
                                                    cell[0] == letter_count.chr
                                                  end
      letter_count += 1
    end
    row_potentials = horizontal_subset.map do |_letter, coordinates|
      coordinates.each_cons(ship.length).to_a
    end
    row_potentials.flatten!(1)
  end

  def vertical_potentials(ship)
    column_count = 1
    vertical_subset = {}

    row_quantity().times do
      vertical_subset[column_count] = @board_cells.find_all do |cell|
        cell[1].to_i == column_count
      end
      column_count += 1
    end
    column_potentials = vertical_subset.map do |_number, coordinates|
      coordinates.each_cons(ship.length).to_a
    end
    column_potentials.flatten!(1)
  end

  def row_quantity
    @board_cells.map { |cell| cell[0] }.uniq.length
  end
end
