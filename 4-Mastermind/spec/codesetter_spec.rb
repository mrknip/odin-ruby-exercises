require_relative '../lib/codesetter'


describe Codesetter do

  describe '#set_code' do
    it 'returns a code of n items' do
      cs = Codesetter.new
      expect(cs.set_code(4).length).to eq 4
    end
  
    it 'sets code to a set of four colours' do
      g = Codesetter.new
      g.set_code(4)
      expect((%i[red blue green yellow purple orange])).to include(g.code[0])
    end 
  end

  describe '#check_guess' do
    it 'returns an empty array when none match' do
      g = Codesetter.new
      g.code = ['red', 'red,', 'blue', 'green']
      expect(g.check_guess(['yellow', 'yellow', 'yellow', 'yellow'])).to eq []
    end

    it 'returns an array of one when one matches' do
      g = Codesetter.new
      g.code = ['red', 'red,', 'blue', 'green']
      expect(g.check_guess(['yellow', 'yellow', 'blue', 'yellow']).size).to eq 1
    end

    it 'returns white for a correct colour/wrong place guess' do
      g = Codesetter.new
      g.code = ['red', 'red,', 'blue', 'green']
      expect(g.check_guess(['yellow', 'yellow', 'yellow', 'blue'])).to eq [:white]
    end

    it 'returns black for a correct colour/correct place guess' do
      g = Codesetter.new
      g.code = ['red', 'red,', 'blue', 'green']
      expect(g.check_guess(['yellow', 'yellow', 'blue', 'yellow'])).to eq [:black]
    end

    it 'includes both "half right" and "fully right" guesses' do
      g = Codesetter.new
      g.code = ['red', 'red,', 'blue', 'green']
      expect(g.check_guess(['green', 'yellow', 'blue', 'yellow'])).to eq [:black, :white]
    end

    it 'returns one peg only for duplicate colours in guess' do
      g = Codesetter.new
      g.code = ['red', 'red', 'blue', 'green']
      expect(g.check_guess(['green', 'green', 'yellow', 'yellow'])).to eq [:white]
    end

    it 'returns one peg only for duplicate colours in code' do
      g = Codesetter.new
      g.code = ['red', 'red', 'blue', 'green']
      expect(g.check_guess(['x', 'x', 'red', 'x'])).to eq [:white]
    end

    it 'returns black when the second of two guesses is in the right place' do
      g = Codesetter.new
      g.code = ['red', 'red', 'blue', 'green']
      expect(g.check_guess(['blue', 'yellow', 'blue', 'yellow'])).to eq [:black]
    end

    it 'returns black and not white' do
      g = Codesetter.new
      g.code = [:purple, :purple, :orange, :red]
      expect(g.check_guess([:purple, :red, :red, :red])).to eq [:black, :black]
    end

    it 'returns all black for a correct guess' do
      g = Codesetter.new
      g.code = ['red', 'yellow', 'blue', 'green']
      expect(g.check_guess(['red', 'yellow', 'blue', 'green'])).to eq [:black, :black, :black, :black]
    end

  end


end