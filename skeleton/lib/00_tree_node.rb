class PolyTreeNode
    attr_reader :parent, :value, :children

    def initialize(val)
        @parent = nil
        @value = val
        @children = []
    end

    def parent=(node)
        unless @parent.nil?
            #Remove self from parent's children
            @parent.children.delete(self)
        end
        @parent = node
        unless node.nil?
            @parent.children << self unless @parent.children.include?(self)
        end
    end

    def add_child(node)
        node.parent = self unless self.children.include?(node)
    end

    def remove_child(child)
        if @children.include?(child)
            child.parent = nil
        else
            raise "This node is not a child"
        end
    end

    def dfs(target)
        return self if self.value == target
        return nil if self.children.empty?

        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            if queue.first.value == target
                return queue.first
            else
                queue += queue.first.children
                queue.shift
            end
        end
        nil
    end



end



