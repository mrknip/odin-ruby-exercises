require './lib/knight'

describe Knight do
  it 'has a colour' do
    expect(subject.colour).to eq :white
  end

  describe '#valid?' do
    context 'when given a valid move' do
      it 'returns true' do
        expect(subject.valid?([0,0], [1,2])).to be true
        expect(subject.valid?([1,2], [0,0])).to be true
      end
    end

    context 'when given an invalid move' do
      it 'returns false' do
        expect(subject.valid?([0,0], [0,0])).to be false
        expect(subject.valid?([2,2], [3,3])).to be false
      end
    end

  end
end