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
      @vars[:move] = player_input

      update(@vars[:move], @vars[:current_player])
      check(@vars[:move])

      render(@vars[:state])
      switch_player
    end
    game_over
  end

  def player_input
    move = :begin
    until legal?(move)
      prompt
      move = validate!($stdin.gets)
    end
    move
  end

  def update(move, player)
    grid.place_counter(move, player)
  end

  def switch_player
    @vars[:current_player] = @vars[:current_player] == @player1 ? @player2 : @player1
  end

  # Validation and grid checking helpers
  def validate!(input)
    input = input.strip =~ /\D/ ? -1 : (input.to_i - 1) if input.is_a? String
    input
  end

  def check(move)
    @vars[:state] = :win if grid.has_a_line? @vars[:move]
    @vars[:state] = :draw if grid.full?
  end

  def legal?(move)
    return if move == :begin
    return error(:no_col) unless move.between?(0,6) 
    return error(:col_full) if grid.col_full?(move)
    true
  end

  def error(type)
    case type
    when :no_col then puts "Please enter a valid column (1 - 7)"
    when :col_full then puts "That column is full"
    end
    false
  end

  # Display methods
  def prompt
    puts "Player: #{@vars[:current_player]}"
    print "Enter a column: "
  end

  def render(gamestate)
    clear_screen
    
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
    puts "  1   2   3   4   5   6   7 \n"

    puts "WIN!!1!\n".magenta.bold if gamestate == :win
    puts "DRAW!!1!\n".magenta.bold if gamestate == :draw
  end

  # Powershell helper methods
  def clear_screen
    system('cls')
  end

  def game_over
    system('exit')
  end
end