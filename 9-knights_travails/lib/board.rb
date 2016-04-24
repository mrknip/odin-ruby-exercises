class Board
  Square = Struct.new(:colour, :contents)

  def initialize
    @squares = Array.new(64, Square.new)
  end

  def [](x,y)
    square = (8 * y) + x
    raise ArgumentError, "Invalid coordinates" unless (0..64).include? square
    @squares[square].contents
  end

  def size
    @squares.size
  end
end