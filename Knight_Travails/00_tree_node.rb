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
        self.children.each do |child| 
            node = child.dfs(target_value)
            return node if node
        end
        nil
    end


    def bfs(target_value)
        queue = [self]
        while !queue.empty?
            if queue[0].value == target_value
                return queue[0]
            else
                queue += queue[0].children
                queue.shift
            end
        end
        return nil
    end

    def inspect
        h = Hash.new
        h[:value] = value
        h[:children] = children.map{|child| child.value}
        h.inspect
    end

end