require_relative '../lib/menu'

describe Hangman::Menu do
  
  describe '#start_menu' do

    it 'displays start menu when start selected' do
      expect($stdout).to receive(:print) # TODO: Add detail to test
      allow($stdin).to receive(:gets).and_return "s\n"
      Hangman::Menu.start_menu
    end

    it 'returns :new when start new game ("s") selected' do
      allow($stdin).to receive(:gets).and_return "s\n"
      expect(Hangman::Menu.start_menu).to eq :new
    end

    it 'returns :load when start new game ("l") selected' do
      allow($stdin).to receive(:gets).and_return "l\n"
      expect(Hangman::Menu.start_menu).to eq :load
    end

    it 'returns nothing until s or l selected' do
      allow($stdin).to receive(:gets).and_return "d\n", "d\n", "l\n"
      expect($stdin).to receive(:gets).exactly(3).times
      expect(Hangman::Menu.start_menu).to eq :load
    end

    describe '#player_guess' do
      it 'gets a single character from player' do
        allow($stdin).to receive(:gets).and_return("g\n")
        Hangman::Menu.player_guess
        expect($stdin).to have_received(:gets).once
      end

      it 'repeats input requests from player when guess invalid' do
        allow($stdin).to receive(:gets).and_return("ARGARIG\n", "@\n", "g\n")

        Hangman::Menu.player_guess
        expect($stdin).to have_received(:gets).exactly(3).times
        expect(Hangman::Menu.player_guess).to eq 'G'
      end
    end
  end
end
