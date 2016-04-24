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

  def self.bfs(target, node = @tree, queue = [node])
    # Starting at the root node - fed in through params
    return -1 if queue.empty?
    
    puts "Visiting: #{queue[0].value}"
    
    # Take node out of the queue
    queue.shift
    
    # Check if we've found it
    return node if node.value == target

    # Mark the node as visited
    node.visited = true
    
    # Add children to the queue, if there are any
    if node.left && node.left.visited == false
      queue << node.left 
      puts "Adding left: #{node.left.value}"
    end
    if node.right && node.right.visited == false
      queue << node.right
      puts "Adding right: #{node.right.value}"
    end
      
    # Do the next in the queue
    bfs(target, queue[0], queue)
  end
  
end