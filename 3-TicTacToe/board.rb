class Board

  attr_accessor :board

  def initialize
    @board = [ [nil,nil,nil], [nil,nil,nil], [nil,nil,nil] ]
  end
  
  def update(spot, symbol)
    board[spot[0]][spot[1]] = symbol
  end
  
  def show
    puts format_board
  end

  def has_a_line?
    if line_in_row?
      true
    elsif line_in_col?
      true
    elsif line_in_diag?
      true
    else
      false
    end
  end
  
  def is_valid?(spot)
    if !is_on_board?(spot)
      return false
    elsif !is_empty?(spot)
      return false
    else
      return true
    end
  end
  
  def is_full?
    board.all? do |row|
      row.all? { |spot| spot != nil }
    end
  end
  
  private

  def format_board
    display = ["\n"]

    board.each_with_index do |row, index|
      display << "#{[3,2,1][index]}:  "
      row.each_with_index do |col, index|
        spot = (col ? col : " ")
        display << ( ((index + 1) % 3 == 0) ? "#{spot}\n" : "#{spot}|" )
      end
    display << ( ((index + 1) % 3 == 0) ? "\n    1 2 3\n\n" : "    -----\n" )
    end

    display.join
  end
  
  def check(line_array)
    line_array.each do |spots|
      return true if spots.all? {|s| s == "X" } || spots.all? {|s| s == "O" }
    end
    false
  end
  
  def line_in_row?
    check(board)
  end

  def line_in_col?
    check(col_arrays)
  end
  
  def line_in_diag?
    diags = [ [ board[0][0], board[1][1], board[2][2] ], [ board[2][0], board[1][1], board[0][2] ] ]
    check(diags)
  end
  
  # Converts the @board array of rows into an array of columns.  Cols[0] will be leftmost.
  def col_arrays
    cols = [[],[],[]]
    
    board.each do |row|
      row.each_with_index do |col_spot, index|
        cols[index].push(col_spot)
      end
    end
    cols
  end

  def is_on_board?(spot)
    if spot.any? {|n| n < 0 || n > 2 }
      puts "Please enter a number between 1 and 3"
      show
      return false
    else
      true
    end
  end
  
  def whatever_is_at(spot)
    board[spot[0]][spot[1]]
  end
  
  def is_empty?(spot)
    if whatever_is_at(spot) == "X" || whatever_is_at(spot) == "O" 
      puts "That spot's taken"
      show
      return false
    else
      true
    end
  end

end

