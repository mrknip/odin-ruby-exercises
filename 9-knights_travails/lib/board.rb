class Board
  Square = Struct.new(:colour, :contents)

  def initialize(width = 8)
    @width = width
    @squares = Array.new(width ** 2) { Square.new }
  end

  def [](x, y)
    raise ArgumentError, "Invalid coordinates" unless (0..64).include? onedim(x,y)
    @squares[onedim(x,y)].contents
  end

  def []=(x, y, content)
    @squares[onedim(x,y)].contents = content
  end

  def onedim(x,y)
    (8 * y) + x
  end

  def to_twodim(p)
    [p % @width, p / @width]
  end

  def size
    @squares.size
  end
end