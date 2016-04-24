module BinaryTree
  class Node
    attr_accessor :left, :right, :value, :visited

    def initialize(value = nil)
      @value = value
      @visited = false
    end

    def pp

      "          Node value: #{value}\n
      Left: #{left.value if left} || Right #{right.value if right}"
    end
  end
end