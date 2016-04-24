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
    
  end
end