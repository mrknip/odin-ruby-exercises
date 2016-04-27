require_relative 'grid'
require 'colorize'

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
      :move           => [] }
  end

  def play
    render(@vars[:state])

    while @vars[:state] == :ongoing
      player_input

      update(@vars[:move], @vars[:current_player])
      check(@vars[:move])
      render(@vars[:state])
      switch_player
    end
    game_over
  end

  def switch_player
    @vars[:current_player] = @vars[:current_player] == @player1 ? @player2 : @player1
  end

  def player_input
    until move
      prompt
      move = $stdin.gets
      validate!(move)
    end
    @vars[:move] = move.to_i
  end

  def update(move, player)
    grid.place_counter(move, player)
  end

  def check(move)
    @vars[:state] = :win if grid.has_a_line?
    # @vars[:state] = :draw if grid.full?
  end

  def prompt
    puts "Player: #{@vars[:current_player]}"
    print "Enter a column: "
  end

  def render(gamestate)
    
    # Hacked together console display
    # ===============================
    #
    system('cls')
    grid.columns.transpose.reverse.each_with_index do |col, idx| 
      line = []
      col.each do |spot|
        line << " " if spot.nil?
        line << "@".red if spot == :red
        line << "O".cyan if spot == :blue
      end

      print "| #{line.join(" | ")} |\n" 
    end
    puts "-----------------------------\n"
    puts "  0   1   2   3   4   5   6 \n"
    puts "WIN!!1!\n".magenta.bold if gamestate == :win
  end

  def game_over
  end
end