class Grid
  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Array.new(6) }
  end

  def place_counter(column, counter)
    raise "Invalid move" unless @columns[column]
    raise "Column full" unless @columns[column].include? nil
    
    spot = @columns[column].index(nil)
    @last_move = [column, spot]
    @columns[column][spot] = counter
  end

  def [](col, row)
    @columns[col][row]
  end

  def on_grid?(position)
    return false unless position.first.between?(0, 6) && position.last.between?(0, 5)
    true
  end

  def has_a_line?
    return true if full_line_check?(@last_move)
    false
  end

  def full_line_check?(position)
    directions.each do |direction|
      return true if line_in_direction?(position, direction)
    end
    false
  end

  def line_in_direction?(position, direction, length = 1)
    value = @columns[position.first][position.last]

    adj_position = position.zip(direction).map { |s,n| s + n }
    adj_value = @columns[adj_position.first][adj_position.last]

    return false unless on_grid? adj_position
    
    while adj_value == value
        length += 1
        return true if length == 4

        adj_position = adj_position.zip(direction).map { |s,n| s + n }
        adj_value = @columns[adj_position.first][adj_position.last]
    end
    false
  end

  def directions
    [[-1, 1], [0, 1], [1, 1],
     [-1, 0],         [1, 0],
     [-1,-1], [0,-1], [1,-1]]
  end

  def spots_adjacent_to(spot)
    spots = directions.map do |neighbour|
              spot.zip(neighbour).map { |s,n| s + n }
            end.select { |spot| on_grid? spot }
  end

  def rows
    columns.transpose
  end
end