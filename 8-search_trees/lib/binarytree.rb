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
    if node.nil?
      node = Node.new(value) 
      return
    end
    
    case value <=> node.value
    when -1
      return (node.left = Node.new(value)) unless node.left 
      insert(value, node.left)
    when 1
      return (node.right = Node.new(value)) unless node.right
      insert(value, node.right)
    end
  end
end