#!/usr/bin/env ruby

# A node is a tree :-)
class Tree

	# Mixin Enumerable, requires that == and each are defined
	include Enumerable

	attr_accessor :children, :node_name
	
	def initialize(name, children=[])
		@children = children
		@node_name = name
	end	
		
	def visit(&block)
		block.call self.node_name 
		# In 7 languages: block.call self
	end
	
	def visit_all(&block)
		visit &block
		children.each {|c| c.visit_all &block }
	end
	
	def each(&block)
		visit_all(&block)
	end
	
	def ==(other)
		if other
			if self.node_name == other.node_name
				return true
			end
		end
		return false
	end
	
end

demo_tree = Tree.new("Animal", 
	[Tree.new("Fish"), Tree.new("Bird"), Tree.new("Mammals", 
		[Tree.new("Whale"), Tree.new("Monkey")])])
		
puts demo_tree.to_s

# Visit all nodes		
demo_tree.visit_all {|node| puts "Visiting node #{node}."}

# Try each
# e = demo_tree.each
# puts e.class.to_s

# Make use of Enumerable functionality
# Test if a certain element is there
puts ("A monkey is an animal") if demo_tree.include?("Monkey")

# Join
arr = demo_tree.inject([]) { | result, c | result << c }
puts "Array: #{arr}"

arr = demo_tree.to_a
puts "Enumerable.to_a: #{arr}"
