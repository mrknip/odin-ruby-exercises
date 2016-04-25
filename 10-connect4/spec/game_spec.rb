require 'spec_helper'

describe Game do
  context 'when initialised without parameters' do
    let(:grid) { subject.grid }
    
    it 'has a 7x6 grid' do
      expect(grid.columns.size).to eq 7
      expect(grid.columns[0].size).to eq 6
    end

    it 'has two players' do
      expect(subject.player1).not_to eq nil
      expect(subject.player2).not_to eq nil
    end
  end

  context 'when initialised with parameters' do
    let(:grid) { Grid.new(5,6) }
    
    subject { Game.new({   grid: grid,
                        player1: :white,
                        player2: :black} ) }

    it 'has the specified parameters' do
      expect(subject.grid.columns.size).to eq 5
      expect(subject.player1).to eq :white
      expect(subject.player2).to eq :black
    end
  end

  describe '#play' do
    let(:grid) { subject.grid }
    let(:player1) { subject.player1 }

    it 'takes input' do
      allow($stdin).to receive(:gets) { 2 }
      expect($stdin).to receive(:gets)
      subject.play
    end

    it 'updates the grid with an array' do
      allow($stdin).to receive(:gets) { 2 }
      allow(grid).to receive(:has_a_line?) { true }
      expect(grid).to receive(:place_counter).with(2, player1)
      subject.play
    end

    it 'checks for a win' do
      allow($stdin).to receive(:gets) { 2 }
      allow(grid).to receive(:has_a_line?) { true }

      expect(grid).to receive(:has_a_line?)
      subject.play
    end

    context 'when player wins' do
      it 'updates the screen' do
        allow($stdin).to receive(:gets) { 2 }
        allow(grid).to receive(:has_a_line?) { true }

        expect(subject).to receive(:render).with(:win)
        subject.play
      end

      it 'exits the game'
    end

    context 'when no win' do
      it 'updates the screen' do
        allow($stdin).to receive(:gets) { 2 }
        allow(grid).to receive(:has_a_line?).and_return(false, true)

        expect(subject).to receive(:render).twice
        subject.play
      end

      it 'switches players' do
        allow($stdin).to receive(:gets) { 2 }
        allow(grid).to receive(:has_a_line?).and_return(false, true)

        expect(subject).to receive(:render).once.with(:ongoing)
        expect(subject).to receive(:render).once.with(:win)
        subject.play
      end

      it 'runs again' do
        allow($stdin).to receive(:gets) { 2 }
        allow(grid).to receive(:has_a_line?).and_return(false, true)

        expect(subject).to receive(:player_input).twice
        subject.play
      end
    end
  end
end