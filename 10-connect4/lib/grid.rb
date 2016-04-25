class Grid
  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Array.new(6) }
  end

  def place_counter(column, counter)
    raise "Invalid move" unless @columns[column]
    raise "Column full" unless @columns[column].include? nil
    
    spot = @columns[column].index(nil)
    @columns[column][spot] = counter
  end

  def on_grid?(spot)
    return false unless spot.first.between?(0, 6) || spot.last.between?(0, 5)
    true
  end

  def has_a_line?
    return true if linear_check?(columns)
    return true if linear_check?(rows)
    false
  end

  def linear_check?(grid) 
    value = ""
    grid.each do |line|
      count = 0
      line.each do |spot|
        next unless spot
        if count == 0 || spot == value
          count += 1
        else
          count = 1
        end
        return true if count == 4
        value = spot
      end
    end
    return false
  end

  def linear_spot_check?(spot)
    stack = []

    spotnode = {position: spot, neighbours: [], depth: 1}
  end

  def neighbours
    [[-1, 1], [0, 1], [1, 1],
     [-1, 0],         [1, 0],
     [-1,-1], [0,-1], [1,-1]]
  end

  def spots_adjacent_to(spot)
    spots = neighbours.map do |neighbour|
              spot.zip(neighbour).map { |s,n| s + n }
            end.select { |spot| spot.valid? }
  end

  def rows
    columns.transpose
  end
end