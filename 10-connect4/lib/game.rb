require 'grid'

class Game
  attr_reader :grid, :player1, :player2

  def initialize(params = {})
    @grid    = params[:grid]    || Grid.new
    @player1 = params[:player1] || :blue
    @player2 = params[:player2] || :red
  end
end