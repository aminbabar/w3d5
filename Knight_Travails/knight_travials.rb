require_relative "../skeleton/lib/00_tree_node.rb"

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

end

p KnightPathFinder.valid_moves([2,1])