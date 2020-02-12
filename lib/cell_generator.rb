class CellGenerator
  attr_reader :height, :width

  def initialize(height = 4, width = 4)
    @height = height
    @width = width
  end

  def last_letter
    alphabet = ("A".."Z").to_a
    letters, quantity = "", @height
    return "width needs to be greater than one" if quantity < 1
    loop do
      quantity, remainder = (quantity-1).divmod(26)
      letters.prepend(alphabet[remainder])
      break if quantity.zero?
    end
    letters
  end

  def generate_letters_range
    ("A"..last_letter).to_a
  end

  def generate_numbers_range
    ("1"..@width.to_s).to_a
  end

  def generate_coordinates
    coordinates = []
    generate_letters_range.each do |letter|
      generate_numbers_range.each do |number|
        coordinates << "#{letter}#{number}"
      end
    end
    coordinates
  end




end
