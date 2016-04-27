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
    let(:player2) { subject.player2 }

    before(:example) do
      allow($stdin).to receive(:gets) { 2 }
      allow(grid).to receive(:has_a_line?) { true }
      allow(grid).to receive(:place_counter)
      
      allow(subject).to receive(:render)
      allow(subject).to receive(:prompt)
      allow(subject).to receive(:game_over)
    end

    it 'takes input' do
      expect(subject).to receive(:player_input)

      subject.play
    end

    it 'updates the grid with an array' do
      expect(grid).to receive(:place_counter).with(2, player1)

      subject.play
    end

    it 'checks for a win' do
      expect(grid).to receive(:has_a_line?)

      subject.play
    end

    context 'when player wins' do
      it 'updates the screen' do
        expect(subject).to receive(:render).once.with(:ongoing)
        expect(subject).to receive(:render).once.with(:win)

        subject.play
      end

      it 'exits the game' do
        expect(subject).to receive(:game_over)

        subject.play
      end
    end

    context 'when no win' do
      before(:example) do
        allow($stdin).to receive(:gets) { 2 }
        allow(grid).to receive(:has_a_line?).and_return(false, true)
        allow(grid).to receive(:place_counter).and_return(true)        
      end

      it 'updates the screen' do  
        expect(subject).to receive(:render).twice.with(:ongoing)
        expect(subject).to receive(:render).once.with(:win)
        
        subject.play
      end

      it 'switches players' do        
        expect(subject).to receive(:update).once.with(2, player1)
        expect(subject).to receive(:update).once.with(2, player2)

        subject.play
      end

      it 'updates move between turns' do
        allow($stdin).to receive(:gets).and_return(2, 3)
        expect(subject).to receive(:update).once.with(2, player1)
        expect(subject).to receive(:update).once.with(3, player2)

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

  describe '#player_input' do
    before(:example) do 
      allow(subject).to receive(:prompt)
      allow($stdin).to receive(:gets)
    end

    context 'before input is validated' do
      before do
        allow(subject).to receive(:validate!) { 2 }
      end

      it 'shows a prompt' do
        expect(subject).to receive(:prompt)
        subject.player_input
      end

      it 'gets input from the player' do
        expect($stdin).to receive(:gets)
        subject.player_input
      end
    end

    context 'when receiving one numeric input' do
      it 'returns an integer' do
        allow($stdin).to receive(:gets) { "2\n" }
        expect(subject.player_input).to be_an Integer

        allow($stdin).to receive(:gets) { 2 }
        expect(subject.player_input).to be_an Integer
      end
    end

    context 'when receiving a non-numeric input, followed by a numeric input' do   
      it 'repeats input process once' do
        allow($stdin).to receive(:gets).and_return('beans', '2')
        expect($stdin).to receive(:gets).twice
        subject.player_input
      end
    end
  end

  describe '#update' do
    let(:grid) { subject.grid }

    before(:example) do
      allow($stdin).to receive(:gets) { "2" }
      allow(grid).to receive(:has_a_line?) { true }
      
      allow(subject).to receive(:render)
      allow(subject).to receive(:prompt)
    end

    it 'sends an integer and symbol to the grid' do
      expect(grid).to receive(:place_counter).with(kind_of(Numeric), instance_of(Symbol))
      subject.play
    end
  end

  describe '#render' do
    before do
      @win_msg = "WIN"

      allow(subject).to receive(:system)
    end

    it 'displays a board with no counters when no moves made' do
      expect{ subject.render(:ongoing) }.not_to output(/O/).to_stdout
    end

    it 'displays counters as moves made' do
      subject.update(0, :blue)
      expect{ subject.render(:ongoing) }.to output(/O/).to_stdout
    end

    it 'displays win only when passed :win' do
      expect{ subject.render(:ongoing) }.not_to output(/#{@win_msg}/).to_stdout
      expect{ subject.render(:win) }.to output(/#{@win_msg}/).to_stdout
    end
  end
end
