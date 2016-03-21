module TicTacToe

  class Board

    attr_accessor :grid

    def initialize(args = {})
      @grid = args.fetch(:grid, default_grid)
    end

    def update_at(coord, marker)
      grid_spot = arrayify(coord)
      grid[grid_spot[0]][grid_spot[1]] = marker
    end
    
    def whats_at(coord)
      grid_spot = arrayify(coord)
      grid[grid_spot[0]][grid_spot[1]]
    end
    
    def game_over
      return :win if line_on_board?
      return :draw if board_full?
      false
    end
    
    def check_valid(input)
      return :off_board unless is_on_board?(input)
      return :is_taken unless is_empty?(input)
      arrayify(input)
    end

    def winning_lines
      grid + grid.transpose + diagonals
    end
    
    def line_on_board?
      winning_lines.each do |line|
        return true if line.uniq.size == 1 && line.compact.size == line.length
      end
      false
    end
    
    def number_of_blocks(marker)
      count = 0
      winning_lines.each do |line|
        count += 1 if line.compact.size == line.length && line.count(marker) == 1
      end
      count
    end
    
    def give_valid_moves # in human coords
      moves = []
      grid.each_with_index do |row, r_index|
        row.each_with_index do |square, c_index|
          moves << [c_index + 1, 3 - r_index] if square.nil?
        end
      end
      moves
    end
    
    private

    def board_full?
      grid.flatten.all? { |spot| spot != nil }
    end
    
    def default_grid
      [[nil,nil,nil], 
       [nil,nil,nil], 
       [nil,nil,nil]]
    end
    
    def arrayify(spot_input)
      [grid.length - spot_input[1], spot_input[0] - 1]
    end
    
    def diagonals
      [ [grid[0][0], grid[1][1], grid[2][2]], 
        [grid[2][0], grid[1][1], grid[0][2]] ]
    end
    
    def is_on_board?(input)
      spots = arrayify(input)
      spots.all? {|n| (0..2).include? n }
    end

    def is_empty?(input)
      spot = arrayify(input)
      grid[spot[0]][spot[1]].nil?
    end
  end
end
