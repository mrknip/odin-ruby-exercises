require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'


module TicTacToe

  describe Player do
  
    describe '#move' do
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
        expect(@player.next_move_state([2,3], @board)).to be_a Board
      end
      
      it 'returns a board with a different object ID' do
        expect(@player.next_move_state([2,3], @board).object_id).not_to eq @board.object_id
      end
      
      it 'returns a board with a grid with a different object ID' do
        expect(@player.next_move_state([2,3], @board).grid.object_id).not_to eq @board.grid.object_id
      end
      
      it 'leaves the board alone' do
        @player.next_move_state([2,3], @board)
        expect(@board.grid).to eq [["X", nil, nil], ["O", "X", "O"], [nil, "X", "O"]]
      end
    end  
    
    describe '#valid_moves_and_states' do
      before :each do 
        @board = Board.new(grid: [["X", nil, nil], ["O", "X", "O"], ["X", "X", "O"]])
        @player = Player.new({marker: "O"})
      end
      
      it 'returns a list of valid moves as keys' do
        expect(@player.valid_moves_and_states(@board).keys).to eq [[2,3], [3,3]]
      end
      
      it 'returns a list of board states as values' do
        expect(@player.valid_moves_and_states(@board).values[0]).to be_a Board
      end
      
    end
    
    describe '#rank_moves' do
      before :each do 
        @player = Player.new({marker: "X"})
      end
      
      it 'returns moves that would make a line' do
        board = Board.new(grid: [["X", nil, "X"], ["X", "O", "O"], ["O", nil, "X"]])
        expect(@player.rank_moves(board)).to eq [[2,3]]
      end
      
      it 'returns moves that would block a line' do
        board = Board.new(grid: [[nil, nil, nil], ["X", "O", nil], ["O", nil, nil]])
        expect(@player.rank_moves(board)).to eq [[3,3]]
      end
      
      it 'ranks winning lines above blocking lines consistently' do
        board = Board.new(grid: [[nil, nil, nil], ["X", nil, "X"], ["O", nil, "O"]])
        expect(@player.rank_moves(board).first).to eq [2,2]
        board2 = Board.new(grid: [[nil, nil, nil], ["O", nil, "O"], ["X", nil, "X"]])
        expect(@player.rank_moves(board2).first).to eq [2,1]
      end
      
      it 'ranks blocking lines above making a non-blocked line' do
        board = Board.new(grid: [[nil, nil, nil], ["O", "O", nil], ["X", nil, nil]])
        expect(@player.rank_moves(board).first).to eq [3,2]
      end
      
      it 'chooses a fork over a single non-blocked line' do
        board = Board.new(grid: [["X", "O", nil], [nil, nil, "X"], ["O", nil, nil]])
        expect(@player.rank_moves(board).first).to eq [3,1]
      
      end
      
    end
    
  end
end