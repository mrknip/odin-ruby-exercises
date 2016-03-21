require './lib/board'


module TicTacToe
  class Player

    attr_accessor :type, :marker, :name, :other_marker
    
    def initialize(args = {})
      @marker = args.fetch(:marker, "")
      @other_marker = args.fetch(:other_marker, "")
      @type = args.fetch(:type, :human)
      @name = args.fetch(:name, "")
    end

    def move(board)
      return best_move(board, marker) unless rank_moves(board, marker).empty?
      board.give_valid_moves.sample
    end
    
    def next_move_state(coord, board, marker)
      deep_copy(board).update_at(coord, marker)
    end
    
    def deep_copy(board)
      copy_grid = board.grid.map do |row|
                    row.map do |spot|
                      spot ? spot.dup : nil
                    end
                  end
      Board.new(grid: copy_grid)
    end
    
    def valid_moves_and_states(board, marker)
      valid_move_states = {}
      board.give_valid_moves.each do |coord|
        valid_move_states[coord] = next_move_state(coord, board, marker)
      end
      valid_move_states
    end
    
    def rank_moves(board, marker)
      good_moves = {}
      
      valid_moves_and_states(board, marker).each do |move, move_state|
        if move_state.line_on_board? 
          (good_moves[move] ||= 1); next
        elsif move_state.number_of_blocks(marker) > board.number_of_blocks(marker)
          (good_moves[move] ||= 2); next
        elsif move_state.number_of_nonblocks(marker) == 2  
          (good_moves[move] ||= 3); next
        elsif (move_state.number_of_nonblocks(marker) == 1) && !block_makes_fork?(move_state, other_marker)
          (good_moves[move] ||= 4); next
        elsif fork_possible?(board, other_marker) && does_not_allow_fork?(move_state, other_marker)
          (good_moves[move] ||= 5); next
        elsif move == [2,2]
          (good_moves[move] ||= 6); next
        elsif [[1,3],[3,3],[3,1],[3,3]].include? move
          (good_moves[move] ||= 7); next  
        end
      end
      good_moves.sort_by {|move, score| score }.map {|p| p[0] }
    end
    
    def best_move(board, marker)
      rank_moves(board, marker).first
    end
    
    def nonblock_difference(before, after, marker)
      return after.number_of_nonblocks(marker) - before.number_of_nonblocks(marker)
    end
    
    def block_makes_fork?(board, other_marker)
      valid_moves_and_states(board, other_marker).any? do |move, state|
        (state.number_of_nonblocks(other_marker) == 2) && (state.number_of_blocks(other_marker) > board.number_of_blocks(other_marker))
      end
    end
    
    def fork_possible?(board, marker)
      valid_moves_and_states(board, marker).any? do |move, state|
        state.number_of_nonblocks(marker) >= 2 
      end
    end
    
    def does_not_allow_fork?(board, marker)
      valid_moves_and_states(board, marker).all? do |move, state|
        state.number_of_nonblocks(marker) < 2 
      end
    end
  end
end