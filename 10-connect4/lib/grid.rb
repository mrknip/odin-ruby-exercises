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

  def rows
    columns.transpose
  end
end