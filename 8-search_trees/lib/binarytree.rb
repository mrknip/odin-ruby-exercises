require_relative 'node'
# The methods operating on the tree as a whole
#
#
module BinaryTree  
  def self.build_tree(ary)
    
    @tree = Node.new(ary[0])

    ary[1..-1].each do |value|
      insert(value, @tree)
    end

    @tree
  end

  def self.insert(value, node)
    case value <=> node.value
    when -1
      node.left ? insert(value, node.left) : node.left = Node.new(value)
    when 1
      node.right ? insert(value, node.right) : node.right = Node.new(value)
    end
  end
end