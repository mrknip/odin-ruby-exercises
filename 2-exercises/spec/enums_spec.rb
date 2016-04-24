require 'spec_helper'
  
describe Enumerable do
  let(:ary) { [1, 2, 3] }
  let(:empty_ary) { [] }
  let(:mixed_ary) { [1, 2, 'three']}
  
  describe '#my_each' do  
    it 'returns self unless a block is given' do
      expect(ary.my_each).to eq [1,2,3]
    end

    it 'applies a block to each item in the array' do
      ary.my_each { |n| empty_ary << n + 1 }
      expect(empty_ary).to eq [2,3,4]
    end

    it 'handles mixed arrays without exception' do
      expect{ mixed_ary.my_each { |n| puts n } }.to output("1\n2\nthree\n").to_stdout
    end
  end

  describe '#my_select' do
    it 'returns self unless a block is given' do
      expect(ary.my_each).to eq [1,2,3]
    end

    it 'returns an array of elements satsifying the block' do
      expect(ary.my_select{ |n| n > 1 }).to eq [2,3]
    end

    it 'returns an array of elements satsifying the block' do
      expect(ary.my_select{ |n| n > 4 }).to be_empty
    end
  end

  describe '#my_inject' do
    it 'raises an error if no block given' do
      expect{ ary.my_inject }.to raise_error LocalJumpError
    end

    context 'when given a valid block ' do
      subject { ary.inject {|m,n| m + n} }
      it 'cumulatively applies the block to the array elements' do
        expect(subject).to eq 6
      end
    end

    context 'when given a valid block and initial value' do
      subject { ary.inject(5) {|m,n| m + n} }
      it 'cumulatively applies the block to the array elements, starting at the given value' do
        expect(subject).to eq 11
      end
    end

    context 'when given a valid symbol' do
      subject { ary.my_inject(:+) }
      it 'cumulatively applies the operation to the array elements' do
        expect(subject).to eq 6
      end
    end

    context 'when given a valid symbol and an initial value' do
      subject { ary.my_inject(5, :+) }
      it 'cumulatively applies the operation to the array elements, starting at the given value' do
        expect(subject).to eq 11
      end
    end

    context 'when given an invalid symbol' do
      it 'should raise an appropriate error' do
        expect{ ary.my_inject(:£) }.to raise_error NoMethodError
      end
    end
  end
end