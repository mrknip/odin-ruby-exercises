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
    
    context 'with a sorted array' do
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

   context 'with an unsorted array' do
      subject { BinaryTree.build_tree([4,9,6,2]) }
      
      it 'returns a tree with the first value as the root' do
        expect(subject).to be_a BinaryTree::Node
        expect(subject.value).to eq 4
      end

      it 'places higher values on the right' do
        expect(subject.right.value).to eq 9 
      end

      it 'places lower values on the left' do
        expect(subject.left.value).to eq 2
        expect(subject.right.left.value).to eq 6
      end
    end
  end
  
  describe '.bfs' do
    
    let(:tree) { BinaryTree.build_tree [3,2,5,9,5] }

    context 'when the target is not in the array' do
      
      let(:target) { 34 }

      it 'returns -1' do
        expect(BinaryTree.bfs(target, tree)).to eq -1
      end
    end

    context 'when the target is in the array' do
      
      let(:target) { 5 }

      it 'returns a node' do
        expect(BinaryTree.bfs(target, tree)).to be_a BinaryTree::Node
      end

      it 'returns a node with the target value'
    end
  end
end
