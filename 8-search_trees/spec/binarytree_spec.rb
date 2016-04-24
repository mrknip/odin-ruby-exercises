require './lib/binarytree'

describe BinaryTree::Tree do

  describe '#build_tree' do
    context 'when given a single value array' do
      subject { BinaryTree::Tree.new([4]) }
      
      it 'returns a tree' do
        expect(subject).to be_a BinaryTree::Tree
        expect(subject.root).to be_a BinaryTree::Node
      end

      it 'returns a tree with no children at the root' do
        expect(subject.root.left).to eq nil
      end

      it 'returns a tree with a root with value 4' do
        expect(subject.root.value).to eq 4
      end
    end
    
    context 'with a sorted array' do
      subject { BinaryTree::Tree.new([4,6,9]) }
      
      let(:root) { subject.root}
      
      it 'returns a tree with the first value as the root' do
        expect(root.value).to eq 4
      end

      it 'places all values on the right' do
        expect(root.right.value).to eq 6 
        expect(root.right.right.value).to eq 9
      end

      it 'places no values on the left' do
        expect(root.left).to eq nil
        expect(root.right.left).to eq nil
      end
    end

   context 'with an unsorted array' do
      subject { BinaryTree::Tree.new([4,9,6,2]) }
      let(:root) { subject.root }
      
      it 'returns a tree with the first value as the root' do
        expect(root).to be_a BinaryTree::Node
        expect(root.value).to eq 4
      end

      it 'places higher values on the right' do
        expect(root.right.value).to eq 9 
      end

      it 'places lower values on the left' do
        expect(root.left.value).to eq 2
        expect(root.right.left.value).to eq 6
      end
    end
  end
  
  describe '.bfs' do
    let(:tree) { BinaryTree::Tree.new [3,2,5,9,6] }
    subject { tree.bfs(target) }

    context 'when the target is not in the array' do      
      let(:target) { 34 }

      it 'returns -1' do
        expect(subject).to eq -1
      end
    end

    context 'when the target is in the array' do
      let(:target) { 5 }

      it 'returns a node' do
        expect(subject).to be_a BinaryTree::Node
      end

      it 'returns a node with the target value' do
        expect(subject.value).to eq 5
      end      
    end
  end

  describe '.dfs' do
    let(:tree) { BinaryTree::Tree.new [3,2,6,4,5,9,7] }
    subject { tree.dfs(target) }

    context 'when the target is not in the array' do      
      let(:target) { 34 }

      it 'returns -1' do
        expect(subject).to eq -1
      end
    end

    context 'when the target is in the array' do
      let(:target) { 7 }

      it 'returns a node' do
        expect(subject).to be_a BinaryTree::Node
      end

      it 'returns a node with the target value' do
        expect(subject.value).to eq 7
      end      
    end
  end
end
