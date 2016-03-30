require_relative '../lib/game'

describe Hangman::Game do
  describe '#init' do
    it 'selects a random word and stores it' do
      g = Hangman::Game.new
      g.init(5, 12)
      expect(g.word).to be_a String
    end

    it 'selects a word within a given range' do
      count = 1
      g = Hangman::Game.new
      10.times do
        count += 1
        g.init(5, 12)
        expect(g.word.size).to be >= 5
        expect(g.word.size).to be <= 12
      end
    end
  end

  describe '#player_guess' do
    it 'gets a single character from player' do
      g = Hangman::Game.new
      allow($stdin).to receive(:gets).and_return("g\n")
      g.player_guess
      expect($stdin).to have_received(:gets).once
    end

    it 'repeats input requests from player when guess invalid' do
      g = Hangman::Game.new
      allow($stdin).to receive(:gets).and_return("ARGARIG\n", "@\n", "g\n")

      g.player_guess
      expect($stdin).to have_received(:gets).exactly(3).times
      expect(g.player_guess).to eq 'G'
    end
  end

  describe '#check_guess' do
    it 'matches one instance of a letter'

    it 'matches multiple instances of a letter'

    it 'returns appropriately when '
  end

  it 'lowers the count after each incorrect guess'

  it 'ends the game when all letters are revealed'

  it 'ends the game when all guesses are up'
end
