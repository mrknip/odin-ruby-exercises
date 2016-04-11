require_relative 'menu'

module Hangman
  class Control
    def initialize(game = Game.new)
      @game = game
      start_state
    end

    attr_accessor :game

    def start_state
      type = Menu.start_menu
      case type
      when 'f' then Menu.load_menu
      when 's' then game.new_game
      end
      play_state
    end

    def play_state
      # run turn menu
      # game.update_from_guess 
      # game.state
      # when win/lose go to end_state
      # otherwise re-run play_state
    end

    def end_state
      # display result
      # go to start_menu
    end

  end
end
