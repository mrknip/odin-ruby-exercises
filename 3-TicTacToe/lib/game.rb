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
  
  def display(message, *additional_info)
    print case message
          when :win then "We have a winner!  #{current_player.name} won as #{current_player.sign}\n"
          when :draw then "It's a draw!\n"
          when :name_plz then "What is your name? "
          when :sign_plz then "What sign do you want to play as? "
          when :board then board.show
          when :sign_taken then "\"#{additional_info[0]}\" is taken. Please enter a different sign.\n"
          end
  end
  
  def check_status(board)
    if board.has_a_line?
      end_game(:win)
    elsif board.is_full?
      end_game(:draw)
    end
  end
  
  def end_game(result)
    display(:board)
    display(result)
    exit
  end
  
  def set_up(players)
    2.times do
      get_name(current_player)
      get_sign(current_player) 
      next_player
    end
  end

  def get_name(player)
    display(:name_plz)
    player.name = gets.chomp
  end

  def get_sign(player)
    display(:sign_plz)
    loop do
      player.sign = gets.chomp[0]
      player.sign == players[1].sign ? display(:sign_taken, player.sign) : break
    end
    puts "You are #{player.sign}" 
  end
  
  def current_player
    players[0]
  end
  
  def next_player
    players.reverse!
  end

  def take_turn
    loop do 
      puts "\n#{current_player.name} (#{current_player.sign})\n=============="
      spot = current_player.get_spot
      
      if board.is_valid?(spot)
        board.update(spot, current_player.sign.to_s)
        break
      end
      
    end
  end

end