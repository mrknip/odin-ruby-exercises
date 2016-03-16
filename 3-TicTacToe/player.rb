class Player

  attr_reader :type, :symbol, :name

  def initialize(name, symbol)
    @symbol = symbol
    @type = :human
    @name = name
  end

  def get_spot
    puts "Please choose a column (1 - 3)"
    row = gets.chomp.to_i
    puts "Please choose a row (1 - 3)"
    col = gets.chomp.to_i
    return [3 - col, row-1]
  end

  # private

  def is_human?
    true if type == :human
  end
  
end