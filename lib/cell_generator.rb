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
  


end
