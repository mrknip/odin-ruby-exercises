module Hangman
  class Menu
    class << self
      def start_menu
        display = "=======\nHANGMAN\n=======\n"\
                 "Would you like to [s]tart a new game or [l]oad an old game?\n"
        responses = {'s' => :new, 'l' => :load }
        response = ""

        until responses.keys.include? response
          $stdout.print display
          response = $stdin.gets.chomp.downcase  
        end

        responses[response]
      end

      def load_menu
        display = 'Please enter a save game name: '
        
        $stdout.print display
        response = $stdin.gets.chomp.downcase
        response
      end

      def player_guess
        display = 'Guess a letter: '

        guess = ""
        while guess =~ /\W/ || guess.size != 1
          $stdout.print display
          guess = $stdin.gets.chomp
        end
        guess.upcase
      end

      def game_over
        # display 'Game Over'/'The result was #{result}'
        # Any key to continue
      end
    end
  end
end