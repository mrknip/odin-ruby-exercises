class Player

  attr_accessor :type, :sign, :name
  
  def initialize
    @sign = ""
    @type = :human
    @name = ""
  end

  def get_spot
    puts "Please choose a column (1 - 3)"
    row = gets.chomp.to_i
    puts "Please choose a row (1 - 3)"
    col = gets.chomp.to_i
    system('cls')
    return [3 - col, row-1]
  end

  # private

  def is_human?
    true if type == :human
  end
  
end