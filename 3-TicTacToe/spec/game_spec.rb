require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

module TicTacToe

describe Game do
  
  it 'defaults on starting up to a board and two players' do
    game = Game.new
    expect(game.board).to be_an_instance_of Board
    expect(game.players.size).to eq 2
  end
end

end
