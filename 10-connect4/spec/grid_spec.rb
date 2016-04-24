require 'spec_helper'

describe Grid do
  it 'makes a six by seven grid' do
    expect(subject.columns.size).to eq 7
    expect(subject.columns[0].size).to eq 6
  end

  describe '#place_counter' do
    it 'puts a counter at the bottom of an empty column' do
      subject.place_counter(3, "X")
      expect(subject.columns[3][0]).to eq "X"
    end

    it 'puts a counter at the lowest available spot in the column' do
      2.times { subject.place_counter(3, "X") }
      expect(subject.columns[3][1]).to eq "X"
    end

    it 'raises an error when an invalid column selected' do
      expect { subject.place_counter(7, "X") }.to raise_error "Invalid move"
    end

    it 'raises an error when a column is full' do
      6.times { subject.place_counter(3, "X") }
      expect { subject.place_counter(3, "X") }.to raise_error "Column full"
    end
  end

  describe '#has_a_line?' do
    it 'returns true when there are four in a column' do
      4.times { subject.place_counter(3, "X") }
      expect(subject.has_a_line?).to be true
    end

    it 'returns false when there are not four in a column' do
      3.times { subject.place_counter(3, "X") }
      3.times { subject.place_counter(3, "O") }
      expect(subject.has_a_line?).to be false
    end

    it 'returns true when there are four in a row' do

    end
    
    # context 'with four counters in a row' do
    #   subject do
    #     grid = Grid.new
    #     (0..3).each {|n| grid.place_counter(n, 'X')}
    #     grid
    #   end

    #   it { is_expected.to have_a_line }
    # end
  end
end