require_relative 'node'
# The methods operating on the tree as a whole
#
#
module BinaryTree  
  class Tree
    attr_reader :root
    
    def initialize(ary)
      build_tree(ary)
    end

    def build_tree(ary)
      @root = Node.new(ary[0])

      ary[1..-1].each do |value|
        insert(value, @root)
      end
    end

    def insert(value, node)
      case value <=> node.value
      when -1
        node.left ? insert(value, node.left) : node.left = Node.new(value)
      when 1
        node.right ? insert(value, node.right) : node.right = Node.new(value)
      end
    end

    # NB: It is not necessary to mark nodes as visited for a binary search
    # as each node has one parent only. Code 
    def bfs(target, queue = [root])
      return -1 if queue.empty?

      node = queue.shift
      return node if node.value == target
      # node.visited = true
      
      queue << node.left if node.left # && node.left.visited == false
      queue << node.right if node.right # && node.right.visited == false
      
      bfs(target, queue)
    end

    def bfs_iterative(target, queue = [root])
      until queue.empty?
        node = queue.shift
        return node if node.value == target
        # node.visited = true
  
        queue << node.left if node.left # && node.left.visited == false
        queue << node.right if node.right # && node.right.visited == false
      end

      return -1
    end

    def dfs(target, stack = [root])
      return -1 if stack.empty?
      
      node = stack.first
      return node if node.value == target
      node.visited = true

      if node.left && !node.left.visited
        stack.unshift(node.left) 
      elsif node.right && !node.right.visited
        stack.unshift(node.right)
      else
        stack.shift  
      end

      dfs(target, stack)
    end

    def dfs_iterative(target, stack = [root])
      until stack.empty?
        node = stack.shift
        return node if node.value == target
        node.visited = true

        if node.left && !node.left.visited
          stack.unshift(node.left) 
        elsif node.right && !node.right.visited
          stack.unshift(node.right)
        else
          stack.shift  
        end
      end
      -1
    end
  end
end
