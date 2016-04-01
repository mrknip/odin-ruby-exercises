require_relative 'fileio'

module Hangman
  class Game
    attr_reader :word
    attr_accessor :progress, :turns_left

    include FileIO

    def initialize(file: nil)
      file ? load(file) : new_game
    end

    def new_game(range: (5..12))
      @word = possible_words('./data/5desk.txt', range).sample.chomp.upcase
      @turns_left = 10
      @progress = set_progress(word)
    end

    def player_guess
      loop do
        guess = $stdin.gets.chomp
        redo if guess =~ /\W/ || guess.size > 1
        return guess.upcase
      end
    end

    def check_guess(letter)
      matches_with_index = word.split('').each_with_index.select { |l, i| l == letter }
      if matches_with_index.empty? 
        @turns_left -= 1
      else 
        matches_with_index.each { |match_index| progress[match_index[1]] = letter }
      end
      progress
    end

    def state
      return :win if progress.compact.length == word.length
      return :lose if turns_left == 0
    end

  private
    def set_progress(word)
      Array.new(word.size)
    end

    def possible_words(file, range)
      File.foreach(file).select do |line|
        range.include? line.chomp.size
      end
    end
  end
end
