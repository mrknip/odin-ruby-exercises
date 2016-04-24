class Board
  Square = Struct.new(:colour, :contents)

  def initialize(width = 8)
    @width = width
    @squares = Array.new(width) { Array.new(width) { Square.new } }
  end

  def [](x, y)
    raise ArgumentError, 'Invalid coordinates' unless @squares[@width - y][x]
    @squares[@width - y][x].contents
  end

  def []=(x, y, content)
    raise ArgumentError, 'Invalid coordinates' unless @squares[@width - y][x]
    @squares[@width - y][x].contents = content
  end

  def size
    @width**2
  end
end