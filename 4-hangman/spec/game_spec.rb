require_relative '../lib/game'

describe Hangman::Game do 

  
  describe '#init' do
    it 'selects a random word within a range and stores it' do
      g = Hangman::Game.new
      g.init(5,12)
      expect(g.word).to be_a String
    end
  end

  describe '#player_guess' do
    it 'validates to make sure input is an English character'

    it 'compares input with the stored word'
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