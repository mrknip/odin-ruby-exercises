require_relative '../lib/game.rb'

describe Game do 

  describe '#setup' do   
    it 'asks codesetter to set code' do
      g = Game.new
      expect(g.codesetter).to receive(:set_code).with(4)
      g.setup 
    end
  end

  describe '#get_colour' do
    it 'return red if input is r' do
      stub_input = double
      stub_string = Codesetter::COLOURS.values.sample
      allow(stub_input).to receive(:gets).and_return("#{stub_string}\n")
      g = Game.new({input: stub_input})

      expect(Codesetter::COLOURS.keys).to include g.get_colour
    end

    # NB THIS TEST ASSUMES '@' IS NOT A VALID INPUT
    it 'will not accept incorrect symbols' do
      stub_input = double
      stub_string = Codesetter::COLOURS.values.sample
      allow(stub_input).to receive(:gets).and_return("@\n", "@\n", "@\n", "@\n", "@\n", "@\n", "@\n", "@\n", "@\n", "#{stub_string}\n")
      g = Game.new({input: stub_input})
      
      expect(Codesetter::COLOURS.keys).to include g.get_colour
      end
  end

  describe '#get_guess' do
    it 'returns an array of four colours' do
      stub_input = double
      stub_string = Codesetter::COLOURS.values.sample
      stub_colour = Codesetter::COLOURS.keys.sample
      allow(@codesetter).to receive(:code).and_return([stub_colour, stub_colour, stub_colour, stub_colour])
      allow(stub_input).to receive(:gets).and_return("#{stub_string}\n")
      g = Game.new({input: stub_input})
      expect(g.get_guess.size).to eq 4
    end
  end



end