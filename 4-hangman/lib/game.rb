module Hangman
  class Game
    attr_reader :word

    def init(x = 5, y = 12)
      @word = possible_words('./data/5desk.txt', (x..y)).sample.chomp.upcase
    end

    def possible_words(file, range)
      File.foreach(file).select do |line|
        range.include? line.chomp.size
      end
    end

    def player_guess
      loop do
        guess = $stdin.gets.chomp
        redo if guess =~ /\W/ || guess.size > 1
        return guess.upcase
      end
    end
  end
end
