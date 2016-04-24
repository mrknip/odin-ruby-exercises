module BinaryTree
  class Node
    attr_accessor :left, :right, :value, :visited

    def initialize(value = nil)
      @value = value
      @visited = false
    end
  end
end