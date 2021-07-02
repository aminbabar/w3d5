class PolyTreeNode
    attr_reader :children, :parent, :value
    def initialize(value)
        @value = value
        @parent = nil
        @children =[]
    end

    def parent=(node)
        if @parent != nil
            @parent.children.delete(self)
        end
        @parent = node
        node.children << self if node != nil && !node.children.include?(self) 
    end

    def add_child(child_node)
        @children << child_node
        child_node.parent=self
    end

    def remove_child(child_node)
        raise "node not a child" if !@children.include?(child_node)
        @children.delete(child_node)
        child_node.parent=nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        @children.each do |child| 
            child.dfs(target_value)
        end
    end

    def bfs(target_value)

    end

end