require './lib/board'


module TicTacToe
  class Player

    attr_accessor :type, :marker, :name, :next_move_state
    
    def initialize(args = {})
      @marker = args.fetch(:marker, "")
      @type = args.fetch(:type, :human)
      @name = args.fetch(:name, "")
    end

    def move(board)
      
      if rank_moves(board).size >= 1
        return rank_moves(board)[0]
      end
      
      if board.grid.flatten.all? {|s| s == nil}
        move = [rand(4), rand(4)]
        return move
      end
      puts "MOVED"
      [rand(4), rand(4)]
    end
    
    def next_move_state(coord, board)
      next_move_grid = board.grid.map do |row|
                          row.map do |spot|
                            spot ? spot.dup : nil
                          end
                        end
      next_move_state = Board.new(grid: next_move_grid)
      next_move_state.update_at(coord, marker)
      next_move_state
    end
    
    def valid_moves_and_states(board)
      valid_move_states = {}
      valid_moves = board.give_valid_moves
      valid_moves.each do |coord|
        valid_move_states[coord] = next_move_state(coord, board)
      end
      valid_move_states
    end
    
    def rank_moves(board)
      valid_moves = valid_moves_and_states(board)
      
      good_moves = []
      valid_moves.each do |move, move_state|
        (good_moves.unshift(move)) if move_state.line_on_board? 
        (good_moves.push(move)) if move_state.number_of_blocks(marker) > board.number_of_blocks(marker)
      end
      good_moves    
    end
    
  end
end