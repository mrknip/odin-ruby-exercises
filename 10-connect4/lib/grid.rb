class Grid
  attr_reader :columns

  def initialize(columns = 7, rows = 6)
    @columns = Array.new(columns) { Array.new(rows) }
  end

  def place_counter(column, counter)
    raise "Invalid move" unless columns[column]
    raise "Column full" unless columns[column].include? nil
    
    spot = columns[column].index(nil)
    @last_move = [column, spot]
    columns[column][spot] = counter
  end

  def value(position)
    @columns[position.first][position.last]
  end

  def on_grid?(position)
    return false unless position.first.between?(0, 6) && position.last.between?(0, 5)
    true
  end

  def full?
    return true unless columns.flatten.include? nil
    false
  end

  def has_a_line?
    return true if line_in_any_direction? @last_move
    
    # This tests all spots
    # @columns.each_with_index do |col, cidx| 
    #   col.each_with_index do |row, ridx| 
    #     return true if full_line_check? [cidx, ridx]
    #   end
    # end

    false
  end

  def line_in_any_direction?(position)
    directions.each do |direction|
      return true if line_in_direction?(position, direction)
    end
    false
  end

  def line_in_direction?(position, direction, length = 1)
    return true if length == 4
    
    adj_position = position.zip(direction).map { |s,n| s + n }
    return false unless on_grid? adj_position

    counter = value(position)
    adj_counter = value(adj_position)
    return false unless adj_counter && counter == adj_counter

    line_in_direction?(adj_position, direction, length += 1)
  end

  def directions
    [[-1, 1], [0, 1], [1, 1],
     [-1, 0],         [1, 0],
     [-1,-1], [0,-1], [1,-1]]
  end
end
