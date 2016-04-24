require_relative 'board'
require_relative 'knight'

class Pathfinder
  PathNode = Struct.new(:position, :parent)

  class << self

    def knight_moves(position, target)
      raise ArgumentError, "Invalid coordinates" unless Board.valid? target

      queue = [PathNode.new(position, nil)]
      
      until queue.empty?      
        pointer = queue.shift
        
        return trace_path(pointer) if pointer.position == target

        legal_moves_from(pointer.position).each do |legal_move|
          queue << PathNode.new(legal_move, pointer)
        end
      end
    end

    def trace_path(pathnode, path = [])
      path.unshift(pathnode.position)
      return path unless pathnode.parent  
      trace_path(pathnode.parent, path)
    end

    def legal_moves_from(position)
      moves = possible_moves.map do |move|
                position.zip(move).map { |a,b| a + b }
              end
      moves.select {|move| move.all? { |coord| (0..7).include? coord } } 
    end

    def possible_moves
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
end