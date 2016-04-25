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

  def [](col, row)
    @columns[col][row]
  end

  def on_grid?(position)
    return false unless position.first.between?(0, 6) || position.last.between?(0, 5)
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

  def linear_spot_check?(position)
    spotnode = { position: position, value: grid[position], neighbours: [], depth: 1 }
    stack = [spotnode]

    until stack.empty?
      cur_spot = stack.first
      spots_adjacent_to(cur_spot[:position]).each do |neighbour|
        if neighbour
        stack.unshift({position: neighbour, neighbours: [], depth: 2})
        end
      end
    end
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