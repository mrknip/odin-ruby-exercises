module TicTacToe

  class Display
    class << self
    
      def show(message, params = {})
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
              when :board then render_board(params[:board].grid || board.grid)
              end
      end

      def clear_screen
        system('cls')
      end
    
      private 
      
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
    end
    
  end


end
