class Knight
  attr_reader :colour

  def initialize(colour = :white)
    @colour = colour
    @position = []
  end

  def valid?(from, to)
    x_diff = (from[0] - to[0]).abs
    y_diff = (from[1] - to[1]).abs

    if x_diff == 1
      return false unless y_diff == 2
    elsif x_diff == 2
      return false unless x_diff == 1
    else
      return false
    end

    true
  end

  def self.legal_moves
      [[1, 2], 
       [1, -2], 
       [2, 1], 
       [2, -1], 
       [-1, -2], 
       [-1, 2], 
       [-2, 1], 
       [-2, -1]]
  end
end