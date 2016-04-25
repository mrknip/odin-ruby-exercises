require 'grid'

class Game
  attr_reader :grid, :player1, :player2, :vars

  def initialize(params = {})
    @grid    = params[:grid]        || Grid.new
    @player1 = params[:player1]     || :blue
    @player2 = params[:player2]     || :red

    @vars    = params[:game_vars]   || default_vars
  end

  def default_vars
    { :state          => :ongoing,
      :current_player => @player1,
      :move           => 0 }
  end

  def play
    while @vars[:state] == :ongoing
      player_input
      update(@vars[:move], @vars[:current_player])
      render(@vars[:state])
    end
  end

  def player_input
    @vars[:move] = $stdin.gets
  end

  def update(move, player)
    grid.place_counter(move, player)
    @vars[:state] = :win if grid.has_a_line?
    # @vars[:state] = :draw if grid.full?
  end

  def render(gamestate)
    
  end
end