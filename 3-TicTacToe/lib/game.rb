require './lib/board'
require './lib/player'

class Game
  attr_reader :board
  attr_accessor :players
  
  def initialize(board = Board.new, player1 = Player.new, player2 = Player.new)
    @players = [player1, player2]
    @board = board
  end

  def play
    set_up(players)
    loop do
      board.show
      take_turn
      check_status(board)
      next_player
    end
  end  
  
  private
  
  def display(board)
  end
  
  def check_status(board)
    if board.has_a_line?
      end_game("win")
    elsif board.is_full?
      end_game("draw")
    end
  end
  
  def end_game(result)
    board.show
    case result
    when "win"
      puts "We have a winner!  #{current_player.name} won as #{current_player.symbol}"
    when "draw"
      puts "We have a draw!"
    end
    exit
  end
  
  def set_up(players)
    players[0].name, players[0].symbol = get_name("crosses"), "X"
    players[1].name, players[1].symbol = get_name("noughts"), "O"
  end

  def get_name(symbol)
    print "Please enter your name to play as #{symbol}: "
    gets.chomp
  end

  def current_player
    players[0]
  end
  
  def next_player
    players.reverse!
  end

  def take_turn
    loop do 
      puts "\n#{current_player.name} (#{current_player.symbol})\n=============="
      spot = current_player.get_spot
      
      if board.is_valid?(spot)
        board.update(spot, current_player.symbol)
        break
      end
      
    end
  end

end