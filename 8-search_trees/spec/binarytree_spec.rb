require './lib/binarytree'

describe BinaryTree do

  describe '.build_tree' do
    context 'with a single value array' do
      subject { BinaryTree.build_tree([4]) }
      
      it 'returns a node' do
        expect(subject).to be_a BinaryTree::Node
      end

      it 'returns a node with no children' do
        expect(subject.left).to eq nil
      end

      it 'returns a node with value 4' do
        expect(subject.value).to eq 4
      end
    end
    
    context 'with a sorted array and no balancing' do
      subject { BinaryTree.build_tree([4,6,9]) }
      
      it 'returns a tree with the first value as the root' do
        expect(subject).to be_a BinaryTree::Node
      end

      it 'returns a tree with a root of 4' do
        expect(subject.value).to eq 4
      end

      it 'places all values on the right' do
        expect(subject.right.value).to eq 6 
        expect(subject.right.right.value).to eq 9
      end

      it 'places no values on the left' do
        expect(subject.left).to eq nil
        expect(subject.right.left).to eq nil
      end
    end


  end
  
end
