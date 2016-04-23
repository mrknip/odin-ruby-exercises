require './lib/node'

describe BinaryTree::Node do
  context 'with value 5 and no children' do
    subject { BinaryTree::Node.new(5) }

    it "has the value it is initalized with" do
      expect(subject.value).to eq 5
    end

    it 'has nil for both children' do
      expect(subject.left).to eq nil
      expect(subject.right).to eq nil
    end
  end

  context 'with value 5 and two children' do
    before do
      @node = BinaryTree::Node.new(5)
      @node.left = BinaryTree::Node.new(3)
      @node.right = BinaryTree::Node.new(6)
    end

    subject { @node }

    it 'returns a node for both children' do
      expect(subject.left).to be_a BinaryTree::Node
      expect(subject.right).to be_a BinaryTree::Node
    end
  end

  describe '#left' do
    it 'sets the left child of a node' do
      node = BinaryTree::Node.new(5)
      expect(node.left).to be nil
      node.left = BinaryTree::Node.new(4)
      expect(node.left).to be_a BinaryTree::Node
      expect(node.left.value).to eq 4
    end
  end

end
