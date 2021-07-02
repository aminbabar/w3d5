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
                node.parent = queue[0]
                queue << node
            end
            queue.shift()
        end
        pos_looked
    end

end

k = KnightPathFinder.new([0,0])

p k.build_move_tree.length
p k.start_node