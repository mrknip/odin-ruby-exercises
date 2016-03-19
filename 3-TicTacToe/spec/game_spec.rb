require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'


describe Game do
  
  before :each do
    @game = Game.new  
  end
  
  it 'has a board' do
    @game.board.should be_an_instance_of Board
  end
  
  it 'has two players' do
    @game.players.size.should be == 2
  end
  
  describe '#play' do
    it 'asks for and assigns names to players' do
      @game.stub(:gets).and_return("First one", "Second one")
      @game.send(:set_up, @game.players)
      
      @game.players[0].name.should be == "First one"
      @game.players[1].name.should be == "Second one"
    end
    
    it 'starts with player 1' do
      @game.send(:current_player).should be == @game.players[0]
    end
  
    it 'checks for a win'
  
    it 'checks for a draw'
  
    it 'switches players at the end of each turn'

    it 'exits the game once it has finished'
  end
end