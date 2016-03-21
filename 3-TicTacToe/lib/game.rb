require './lib/board'
require './lib/player'

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
        clear_screen
        display(:board)
        take_turn
        end_game(board.game_over) if board.game_over 
        next_player
      end
    end  
    
    private
    
    def display(message, params = {})
      print case message
            when :name_plz then "What is your name? "
            when :marker_plz then "What marker do you want to play as? "
            when :col_plz then "Please choose a column (1 - 3) "
            when :row_plz then "Please choose a row (1 - 3) "
            when :type_plz then "Is this a human player? (y/n)"
            when :deets then "#{params[:player].name} (#{params[:player].type.to_s}) is playing as #{params[:player].marker}\n"
            when :win then "We have a winner!  #{params[:player].name} (#{params[:player].type.to_s}) won as #{params[:player].marker}\n\n"
            when :draw then "It's a draw!\n"
            when :marker_taken then "\"#{params[:player].marker}\" is taken. Please enter a different marker.\n"
            when :marker_empty then "Please enter a marker"
            when :off_board then "Please enter a number between 1 and 3\n\n"
            when :is_taken then "That spot's taken\n\n"
            when :board then render_board(params[:grid] || board.grid )
            end
    end

    def render_board(grid)
      output = "\n"
      grid.each_with_index do |row, index|
        output += "#{grid.length - index} "
        row.each_with_index do |spot, index|
          spot = spot ? spot : " "
          output += ( ( (index + 1) % 3 == 0) ? "#{spot}\n" : "#{spot}|" )
        end
        output += (((index + 1) % 3 == 0) ? "\n  1 2 3\n\n" : "  -----\n")
      end
      output
    end
    
    def clear_screen
      system('cls')
    end
    
    def set_up(players, n = 2)
      clear_screen
      n.times do
        get_name(current_player)
        get_marker(current_player)
        get_type(current_player)
        display(:deets, {:player => current_player} )
        next_player if n > 1
      end
    end

    def get_type(player)
      loop do
        display(:type_plz)
        case gets.chomp.downcase
        when "y" then player.type = :human; break
        when "n" then player.type = :computer; break
        end
      end
    end
    
    def get_name(player)
      display(:name_plz)
      player.name = gets.chomp
    end

    def get_marker(player)
      loop do
        display(:marker_plz)
        player.marker = gets.chomp[0]
        players[1].other_marker = player.marker
        redo unless player.marker =~ /\S/
        player.marker == players[1].marker ? display(:marker_taken, {:player => current_player} ) : break
      end
    end
    
    def get_spot
      display(:row_plz)
      row = gets.chomp.to_i
      display(:col_plz)
      col = gets.chomp.to_i
      return [row, col]
    end
    
    def check_status(board)
      end_game(:win) if board.has_a_line?
      end_game(:draw) if board.is_full?
    end
    
    def end_game(result)
      clear_screen
      display(:board)
      display(result, {:player => current_player} )
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
        display(:deets, {:player => current_player} )
        spot = get_spot if current_player.type == :human
        spot = current_player.move(board) if current_player.type == :computer
        if board.check_valid(spot).is_a? Array
          board.update_at(spot, current_player.marker)
          break
        else
          clear_screen
          display(:board)
          display(board.check_valid(spot))
        end
      end
    end
    
  end
end