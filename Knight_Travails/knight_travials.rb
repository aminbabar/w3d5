require "byebug"
require_relative "00_tree_node.rb"

class KnightPathFinder
    def self.valid_moves(pos)
        row , col = pos
        moves= KnightPathFinder.permutations
        valid=[]
        moves.each do |move|
            r = row + move[0]
            c = col + move[1] 
            valid << [r,c] if r < 8 && r >=0 && c <8 && c >= 0
        end
        valid
    end

    def self.permutations
        nums = [-2,-1,1,2]
        new_arr=[]
        (0...nums.length).each do |i|
            (0...nums.length).each do |j| 
                new_arr << [nums[i],nums[j]] if (nums[i].abs != nums[j].abs) 
            end
        end
        new_arr
    end

    attr_reader :start_node

    def initialize(start_pos)
        @start_pos = start_pos
        @start_node = PolyTreeNode.new(start_pos)
    end

    def build_move_tree
        queue = [@start_node]
        pos_looked = [@start_node.value]
        while !queue.empty?
            KnightPathFinder.valid_moves(queue[0].value).each do |move|
                next if pos_looked.include?(move)
                node = PolyTreeNode.new(move)
                queue[0].add_child(node)
                pos_looked << node.value
                queue << node
            end
            queue.shift()
        end
        pos_looked
    end

    def find_path(end_position)
        final_node=@start_node.dfs(end_position) 
        trace_back_path(final_node)
    end

    def trace_back_path(node)
        arr=[]
        while node.parent != nil
            arr << node.value
            node = node.parent
        end
        arr << node.value
        arr.reverse
    end

end

# k = KnightPathFinder.new([2,2])

# p k.build_move_tree.length
# p k.start_node
# p k.start_node.children[0]
kpf = KnightPathFinder.new([0, 0])
kpf.build_move_tree
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

