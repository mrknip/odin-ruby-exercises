require './lib/board'


module TicTacToe
  class Player

    attr_accessor :type, :marker, :name
    
    def initialize(args = {})
      @marker = args.fetch(:marker, "")
      @type = args.fetch(:type, :human)
      @name = args.fetch(:name, "")
    end

    def move(board)
      state = board.grid
      if state.flatten.all? {|s| s == nil}
        move = [rand(4), rand(4)]
        return move
      end
      [rand(4), rand(4)]
    end
    
    # private

    def is_human?
      true if type == :human
    end

    def is_possible_to_win?
      # if board lines any has two self.signs and nil, move to the spot that is nil
      
    end
    
    def lines_to_be_completed
      
    end
    
  end
end