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


end