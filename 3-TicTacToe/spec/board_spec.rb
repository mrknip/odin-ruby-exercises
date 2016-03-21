require_relative '../lib/board.rb'
require_relative '../lib/game.rb'

module TicTacToe

  describe Board do

    it 'can be initialised with a :grid argument' do
      expect { TicTacToe::Board.new(grid: "grid") }.to_not raise_error
    end
    
    it 'makes a grid with 3 rows by default' do
      board = Board.new
      expect(board.grid.size).to be == 3
    end
    
    it 'makes a grid with 3 columns by default' do
      board = Board.new
      board.grid do |row|
        expect(row.each.size).to be == 3
      end
    end
    
    describe '#grid' do
    
      it 'returns the grid' do
        board = Board.new(grid: "arg")
        expect(board.grid).to eq "arg"
      end
    end
    
    describe '#whats_at' do
    
      it 'returns the grid contents at standard x/y coordinates' do
        board = Board.new(grid: [["X", nil, nil], [nil, nil, nil], [nil, nil, nil]])
        expect(board.whats_at([1,3])).to eq "X"
      end
    end
    
    describe '#update_at' do
      
      it 'changes the grid contents at standard x/y coordinates' do
        board = Board.new(grid: [["X", nil, nil], [nil, nil, nil], [nil, nil, nil]])
        expect(board.update_at([1,3], "Bongs")).to eq "Bongs"
      end
    end
    
    describe '#check_game_status' do
      
      it 'returns :win when line_on_board? is true' do
        board = Board.new
        allow(board).to receive(:line_on_board?) { true }
        expect(board.game_over).to eq :win
      end
      
      it 'returns :draw if line_on_board? is false and is_full? is true' do
        board = Board.new
        allow(board).to receive(:line_on_board?) { false }
        allow(board).to receive(:board_full?) { true }
        expect(board.game_over).to eq :draw
      end
      
      it 'returns false if line_on_board? and is_full? are false' do
        board = Board.new
        allow(board).to receive(:line_on_board?) { false }
        allow(board).to receive(:board_full?) { false }
        expect(board.game_over).to eq false
      end
      
      it 'returns :win when there is a straight line on the board' do
        board = Board.new(grid: [["X", "X", "X"], [nil, nil, nil], [nil, nil, nil]])
        expect(board.game_over).to eq :win
      end
      
      it 'returns :win when there is a diagonal line on the board' do
        board = Board.new(grid: [["X", nil, "X"], [nil, "X", nil], [nil, nil, "X"]])
        expect(board.game_over).to eq :win
      end
      
      it 'does not return :win when there is a mixed line on the board' do
        board = Board.new(grid: [["X", "O", "X"], [nil, nil, nil], [nil, nil, nil]])
        expect(board.game_over).to eq false
      end
      
      it 'returns :draw when the board is full' do
        board = Board.new(grid: [["X", "O", "X"], [nil, "X", nil], [nil, nil, "X"]])
        expect(board.game_over).to eq :win
      end
    end
    
    describe '#check_valid' do
        
      it 'returns :off_board when is_on_board? returns false' do 
        board = Board.new
        allow(board).to receive(:is_on_board?) { false }
        expect(board.check_valid([4,5])).to eq :off_board
      end
      
      it 'returns :is_taken when is_empty? returns false' do
        board = Board.new
        allow(board).to receive(:is_empty?) { false }
        expect(board.check_valid([1,2])).to eq :is_taken
      end

      context 'move is off the board' do
      
        it 'returns :off_board when move is off board' do 
          board = Board.new
          expect(board.check_valid([45, 67])).to eq :off_board
        end
        
      end
      
      it 'returns :is_taken when marker already in spot' do
        board = Board.new(grid: [["X", "O", "X"], [nil, "X", nil], [nil, nil, "X"]])
        expect(board.check_valid([1,3])).to eq :is_taken
      end
      
      it 'returns valid array if move is valid' do
        board = Board.new(grid: [["X", "O", "X"], [nil, "X", nil], [nil, nil, "X"]])
        expect(board.check_valid([1,2])).to be_an Array
      end
      
      
      
    end
  end

end