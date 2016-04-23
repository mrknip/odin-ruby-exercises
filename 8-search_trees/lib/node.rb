module BinaryTree
  class Node
    attr_accessor :left, :right, :value

    def initialize(value = nil)
      @value = value
    end

    # def insert(n)
      
    #   case n <=> value
    #   when -1 then left.insert
    #   when 1 then right.insert
    #   end
    # end
  end
end