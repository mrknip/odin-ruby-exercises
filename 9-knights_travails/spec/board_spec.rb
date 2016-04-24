require './lib/board'

describe Board do 
  it 'contains 64 squares' do
    expect(subject.size).to eq 64
  end

  describe '#[]' do
    it "returns a square's contents" do
      expect(subject[4,5]).to be nil
    end

    it 'raises an error for non-existent squares' do
      expect{ subject[9,9] }.to raise_error ArgumentError
    end
  end

  describe '#[]=' do
    before do
      let(:board) { subject[1,1] = "ROOK" }
    end

    it "sets a square's contents" do
      expect(board[1,1]).to eq "ROOK"
    end
  end
end