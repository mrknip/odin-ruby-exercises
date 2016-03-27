require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'


module TicTacToe

  describe Player do
  
    describe '#move' do
      it 'gives a random move if there are no ranked options' do
        board = Board.new
        player = Player.new
        allow(board).to receive(:give_valid_moves) { [[2,2]] }
        expect(player.move(board)).to eq [2,2]
      end
      
      it 'wins the game when able' do
        board = Board.new(grid: [["X", nil, "X"], ["O", nil, "O"], [nil, nil, nil]])
        player = Player.new({marker: "O"})
          
        expect(player.move(board)).to eq [2,2]
      end
      
      it 'blocks lines when able' do
        board = Board.new(grid: [[nil, nil, nil], ["O", "X", nil], ["X", nil, nil]])
        player = Player.new({marker: "O"})
        
        expect(player.move(board)).to eq [3,3]
      end
      
    
    end
  
    describe '#next_move_state' do
      before :each do 
        @board = Board.new(grid: [["X", nil, nil], ["O", "X", "O"], [nil, "X", "O"]])
        @player = Player.new({marker: "O"})
      end
      
      it 'returns a board if it gets a board' do
        expect(@player.next_move_state([2,3], @board, @player.marker)).to be_a Board
      end
      
      it 'returns a board with a different object ID' do
        expect(@player.next_move_state([2,3], @board, @player.marker).object_id).not_to eq @board.object_id
      end
      
      it 'returns a board with a grid with a different object ID' do
        expect(@player.next_move_state([2,3], @board, @player.marker).grid.object_id).not_to eq @board.grid.object_id
      end
      
      it 'leaves the board alone' do
        @player.next_move_state([2,3], @board, @player.marker)
        expect(@board.grid).to eq [["X", nil, nil], ["O", "X", "O"], [nil, "X", "O"]]
      end
    end  
    
    describe '#valid_moves_and_states' do
      before :each do 
        @board = Board.new(grid: [["X", nil, nil], ["O", "X", "O"], ["X", "X", "O"]])
        @player = Player.new({marker: "O"})
      end
      
      it 'returns a list of valid moves as keys' do
        expect(@player.valid_moves_and_states(@board, @player.marker).keys).to eq [[2,3], [3,3]]
      end
      
      it 'returns a list of board states as values' do
        expect(@player.valid_moves_and_states(@board, @player.marker).values[0]).to be_a Board
      end
      
    end
    
    describe '#rank_moves' do
      before :each do 
        @player = Player.new({marker: "X", other_marker:"O"})
      end
      
      it 'returns moves that would make a line' do
        board = Board.new(grid: [["X", nil, "X"], ["X", "O", "O"], ["O", nil, "X"]])
        expect(@player.rank_moves(board, @player.marker).first).to eq [2,3]
      end
      
      it 'returns moves that would block a line' do
        board = Board.new(grid: [[nil, nil, nil], ["X", "O", nil], ["O", nil, nil]])
        expect(@player.rank_moves(board, @player.marker).first).to eq [3,3]
      end
      
      it 'ranks winning lines above blocking lines consistently' do
        board = Board.new(grid: [[nil, nil, nil], ["X", nil, "X"], ["O", nil, "O"]])
        expect(@player.rank_moves(board, @player.marker).first).to eq [2,2]
        board2 = Board.new(grid: [[nil, nil, nil], ["O", nil, "O"], ["X", nil, "X"]])
        expect(@player.rank_moves(board2, @player.marker).first).to eq [2,1]
      end
      
      it 'ranks blocking lines above making a non-blocked line' do
        board = Board.new(grid: [[nil, nil, nil], ["O", "O", nil], ["X", nil, nil]])
        expect(@player.rank_moves(board, @player.marker).first).to eq [3,2]
      end
      
      it 'ranks a fork over a single non-blocked line' do
        board = Board.new(grid: [["X", "O", nil], [nil, nil, "X"], ["O", nil, nil]])
        expect(@player.rank_moves(board, @player.marker).first).to eq [3 ,1]
      end
      
      it 'ranks forcing opponent to forgo fork over making the first non-blocking line' do
        board = Board.new(grid: [[nil, nil, "O"], [nil, "X", nil], ["O", nil, nil]])
        expect(@player.rank_moves(board, @player.marker).first).to eq [3,2]
      end
    
    describe '#block_makes_fork?' do
      it 'returns true when player blocking makes a fork' do
        board = Board.new(grid: [["X", nil, "O"], [nil, "X", nil], ["O", nil, nil]])
        expect(@player.block_makes_fork?(board, "O")).to be true
      end
      
      it 'returns false when player cannot move to make a fork' do
        board = Board.new(grid: [[nil, "O", nil], [nil, nil, "X"], ["O", nil, nil]])
        expect(@player.block_makes_fork?(board, "X")).to be false
      end
      
    end
    
    end
    
  end
end