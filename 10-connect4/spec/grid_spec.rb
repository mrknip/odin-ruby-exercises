require 'spec_helper'

describe Grid do
  it 'makes a six by seven grid' do
    expect(subject.columns.size).to eq 7
    expect(subject.columns[0].size).to eq 6
  end

  describe '#value' do
    it 'returns the spot at a point on the grid' do
      subject.place_counter(3, 'test')
      expect(subject.value [3,0]).to eq 'test'
    end
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
  end

  describe '#on_grid?' do 
    it 'returns true for an empty spot' do
      expect(subject.on_grid?([3,3])).to be true  
    end

    it 'returns true for a full spot' do
      subject.place_counter(3, 'X')
      expect(subject.on_grid?([3,0])).to be true  
    end

    it 'returns false for a spot off the board' do
      expect(subject.on_grid?([7,6])).to be false  
    end
  end

  describe '#full?' do
    subject { Grid.new(2,1) }
      
    before do
      subject.place_counter(0, 'X')
    end

    it 'returns false when the grid is not full' do
      expect(subject.full?).to be false
    end

    it 'returns true when the grid is full' do
      subject.place_counter(1, 'O')

      expect(subject.full?).to be true
    end
  end

  describe '#col_full?' do
    subject { Grid.new(2,1) }

    it 'returns false when a column is not full' do
      expect(subject.col_full?(1)).to be false
    end

    it 'returns true when the grid is full' do
      subject.place_counter(1, 'O')

      expect(subject.col_full?(1)).to be true
    end
  end

  describe '#has_a_line?' do
    it 'returns true when there are four in a column' do
      4.times { subject.place_counter(3, "X") }

      expect(subject).to have_a_line
    end

    it 'does not carry count over between columns' do
      3.times { subject.place_counter(3, 'O') }
      3.times { subject.place_counter(3, 'X') }
      subject.place_counter(4, 'X')
      3.times { subject.place_counter(4, 'O') }

      expect(subject).not_to have_a_line
    end

    it 'returns false when there are not four in a column' do
      3.times { subject.place_counter(3, "X") }
      3.times { subject.place_counter(3, "O") }

      expect(subject).not_to have_a_line
    end

    it 'returns true when there are four in a row' do
      (0..3).each {|n| subject.place_counter(n, 'X')}

      expect(subject).to have_a_line
    end

    it 'returns true when there are four in a diagonal' do
      (1..3).each { |n| n.times { subject.place_counter(n ,'O') } }
      (0..3).each { |n| subject.place_counter(n, 'X') }

      expect(subject).to have_a_line
    end
  end
end