require_relative '../lib/game'

describe Hangman::Game do
  
  # nb Test relies on test.hgm in ./data
  it 'loads a file when load choice selected' do
    g = Hangman::Game.new(file: 'test')
    allow(Ui).to receive(game_choice).and_return("l\n")
    allow(Ui).to receive(load_select).and_return("test\n")
    expect(g.word).to eq 'CORRECTABLE'
  end

  describe '#new_game' do
    it 'selects a random word and stores it' do
      g = Hangman::Game.new
      allow(Ui).to receive(load_select).and_return("test\n")
      expect(g.word).to be_a String
    end

    it 'selects a word within a given range' do
      count = 1
      10.times do
        g = Hangman::Game.new
        count += 1
        expect(g.word.size).to be >= 5
        expect(g.word.size).to be <= 12
      end
    end

    it 'sets up a progress line of the same length' do
      g = Hangman::Game.new    
      expect(g.word.length).to eq g.progress.length
    end
  end

  describe '#check_guess' do
    it 'returns the same progress bar when no letters match' do
      g = Hangman::Game.new      

      g.instance_variable_set(:@word, 'BADGER')
      g.instance_variable_set(:@progress, Array.new(6))

      expect(g.check_guess("Z")).to eq [nil,nil, nil, nil, nil, nil]
    end

    it 'lowers the turns left counter when no letters match' do
      g = Hangman::Game.new

      g.instance_variable_set(:@word, 'BADGER')
      g.instance_variable_set(:@progress, Array.new(6))
      g.check_guess 'Z'
      expect(g.turns_left).to eq 9
    end

    it 'matches one instance of a letter' do
      g = Hangman::Game.new
      
      g.instance_variable_set(:@word, 'BADGER')
      g.instance_variable_set(:@progress, Array.new(6))
      
      expect(g.check_guess('B')).to eq ['B', nil, nil, nil, nil, nil]
      expect(g.turns_left).to eq 10 
    end

    it 'matches multiple instances of a letter' do
      g = Hangman::Game.new
      
      g.instance_variable_set(:@word, 'BOBBIN')
      g.instance_variable_set(:@progress, Array.new(6))
      
      expect(g.check_guess("B")).to eq ['B', nil, 'B', 'B', nil, nil]
    end
  end

  it 'indicates the game is a win when all letters are revealed' do
    g = Hangman::Game.new
    g.instance_variable_set(:@word, 'BOBBIN')
    g.instance_variable_set(:@progress, ['B', 'O', 'B', 'B', 'I', 'N'])

    expect(g.state).to eq :win
  end

  it 'indicates the game is a loss when there are no guesses left' do
    g = Hangman::Game.new
    g.instance_variable_set(:@word, 'BOBBIN')
    g.instance_variable_set(:@progress, ['B', nil, 'B', 'B', 'I', 'N'])
    g.instance_variable_set(:@turns_left, 0)

    expect(g.state).to eq :lose
  end
end
