module Hangman
  class Game

    def init(x = 5, y = 12)
      @word = possible_words('./data/5desk.txt', (x..y)).sample
    end

    def word
      @word
    end

    def possible_words(file, range)
      File.foreach(file).map do |line|
        next unless (range).include? line.size
        line.chomp.upcase
      end
    end


  end
end
