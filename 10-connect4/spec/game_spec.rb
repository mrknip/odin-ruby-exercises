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
end