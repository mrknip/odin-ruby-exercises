require './lib/board'
require './lib/player'
require './lib/display'


module TicTacToe
  class Game
    attr_reader :board
    attr_accessor :players
    
    def initialize(board = Board.new, players = [Player.new, Player.new])
      @players = players
      @board = board
    end

    def play
      set_up(players)
      loop do
        Display.clear_screen
        Display.show(:board, {board: board})
        take_turn
        end_game(board.game_over) if board.game_over 
        next_player
      end
    end  
    
    private
    
    def set_up(players, n = 2)
      Display.clear_screen
      n.times do
        get_name(current_player)
        get_marker(current_player)
        get_type(current_player)
        Display.show(:deets, {:player => current_player} )
        next_player if n > 1
      end
    end

    def get_type(player)
      loop do
        Display.show(:type_plz)
        case gets.chomp.downcase
        when "y" then player.type = :human; break
        when "n" then player.type = :computer; break
        end
      end
    end
    
    def get_name(player)
      Display.show(:name_plz)
      player.name = gets.chomp
    end

    def get_marker(player)
      loop do
        Display.show(:marker_plz)
        player.marker = gets.chomp[0]
        players[1].other_marker = player.marker
        redo unless player.marker =~ /\S/
        player.marker == players[1].marker ? Display.show(:marker_taken, {:player => current_player} ) : break
      end
    end
    
    def get_spot
      Display.show(:col_plz)
      col = gets.chomp.to_i
      Display.show(:row_plz)
      row = gets.chomp.to_i
      return [col, row]
    end
    
    def check_status(board)
      end_game(:win) if board.has_a_line?
      end_game(:draw) if board.is_full?
    end
    
    def end_game(result)
      Display.clear_screen
      Display.show(:board, {board: board})
      Display.show(result, {:player => current_player} )
      exit
    end
    
    def current_player
      players[0]
    end
    
    def other_player
      players[1]
    end
    
    def next_player
      players.reverse!
    end

    def take_turn
      loop do 
        Display.show(:deets, {:player => current_player} )
        spot = get_spot if current_player.type == :human
        spot = current_player.move(board) if current_player.type == :computer
        if board.check_valid(spot).is_a? Array
          board.update_at(spot, current_player.marker)
          break
        else
          Display.clear_screen
          Display.show(:board, {board: board})
          Display.show(board.check_valid(spot))
        end
      end
    end
    
  end
end