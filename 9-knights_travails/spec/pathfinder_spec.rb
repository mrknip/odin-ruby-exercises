require './lib/pathfinder'

describe Pathfinder do
  describe '#knight_moves' do
    context 'when given a move one step away' do
      subject { Pathfinder.knight_moves([1,1], [2,3]) }

      it 'returns an array containing the single move' do
        expect(subject).to eq [[1,1], [2,3]]
      end
    end

    context 'when given a move two steps away' do
      subject { Pathfinder.knight_moves([1,1], [3,5]) }

      it 'returns an array containing two moves' do
        expect(subject).to eq [[1,1], [2,3], [3,5]]
      end
    end

    context 'when given a move three steps away' do
      subject { Pathfinder.knight_moves([1,1], [4,7]) }

      it 'returns an array containing two moves' do
        expect(subject).to eq [[1,1], [2,3], [3,5], [4,7]]
      end
    end

    context 'when given a move off the board' do
      it 'raises an error' do
        expect { Pathfinder.knight_moves([1,1], [8, 3]) }.to raise_error "Invalid coordinates"
      end
    end
  end
end