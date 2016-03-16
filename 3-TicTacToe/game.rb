require './board'
require './player'

class Game
  attr_reader :board, :players
  
  def initialize
    @players = []
    @board = Board.new
  end

  def play
    setup
    finish_state = ""
    
    while finish_state.empty?
      board.show
      take_turn
      if board.has_a_line?
        finish_state = "win"
        next
      elsif board.is_full?
        finish_state = "draw"
        next
      else
        next_player
      end
    end
    
    board.show
    
    case finish_state
    when "win"
      puts "We have a winner!  #{current_player.name} won as #{current_player.symbol}"
    when "draw"
      puts "We have a draw!"
    end
  end

  private
  
  def setup
    @players << Player.new(get_name("crosses"), "X")
    @players << Player.new(get_name("noughts"), "O")
  end

  def get_name(symbol)
    print "Please enter your name to play as #{symbol}: "
    gets.chomp
  end

  def current_player
    players[0]
  end
  
  def next_player
    players[0], players[1] = players[1], players[0]
  end

  def take_turn
    loop do 
      puts "#{current_player.name} (#{current_player.symbol})\n=============="
      spot = current_player.get_spot
      
      if board.is_valid?(spot)
        board.update(spot, current_player.symbol)
        break
      else
        next
      end
    end
  end
end