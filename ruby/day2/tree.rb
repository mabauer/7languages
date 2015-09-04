#!/usr/bin/env ruby

# A node is a tree :-)
class Tree

	# Mixin Enumerable, requires that == and each are defined
	include Enumerable

	attr_accessor :children, :node
	
	def initialize(name, children=[])
		@children = children
		@node = name
	end	
		
	def visit(&block)
		block.call self.node 
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
			if self.node == other.node
				return true
			end
		end
		return false
	end
	
	def self.node_from_dsl(node, child_exps)
		if !child_exps || child_exps.empty?
			return Tree.new(node, [])
		else
			children = []
			for child in child_exps.keys
				children << node_from_dsl(child, child_exps[child])
			end
 			return Tree.new(node, children)
			# More compact way: 
 			# return Tree.new(node, child_exps.inject([]) { | children, child | children << self.node_from_dsl(child[0], child[1]) })
		end
	end
	private_class_method :node_from_dsl			
	
	def self.from_dsl(dsl = nil)
		if dsl.size > 1
			raise ArgumentError, "Tree has more than one roots"
		end
		node = dsl.keys[0]
		return node_from_dsl(node, dsl[node])
	end
	
	def to_dsl
		result = {}
		if children.empty?
			result[node] = {}
		else
			child_exps = {}
	 		for c in children
	 			child_exps.merge!(c.to_dsl)
	 		end
	 		result[node] = child_exps
	 	end
	 	return result
	end	

end

demo_tree = Tree.new("Animal", 
	[Tree.new("Fish"), Tree.new("Bird"), Tree.new("Mammals", 
		[Tree.new("Whale"), Tree.new("Monkey")])])
		
puts demo_tree.to_s

# Visit all nodes		
demo_tree.visit_all {|node| puts "Visiting node #{node}."}

# TODO: Try each -- without block, it should return an Enumerable
# e = demo_tree.each
# puts e.class.to_s

# Make use of Enumerable functionality
# Test if a certain element is there
puts ("A monkey is an animal") if demo_tree.include?("Monkey")

# Join
arr = demo_tree.inject([]) {| result, c | result << c }
puts "Array: #{arr}"

arr = demo_tree.to_a
puts "Enumerable.to_a: #{arr}"

# VERY simple DSL for trees
demo_tree_dsl = {
	'Animal' => {
		'Fish' => nil,
		'Bird' => nil,
		'Mammal' => {
			'Whale' => nil,
			'Donkey' => nil
		}
	}
}
demo_tree = Tree.from_dsl(demo_tree_dsl)
arr = demo_tree.inject([]) {| result, c | result << c }
puts "Array: #{arr}"

family_tree_dsl = {
	'grandpa' => {
		'dad' => {
			'child1' => {},
			'child2' => {}
		},
		'uncle' => {
			'child3' => {},
			'child4' => {}
		}
	}
}
family_tree = Tree.from_dsl(family_tree_dsl)
arr = family_tree.inject([]) {| result, c | result << c }
puts "Array: #{arr}"

# A forest has several roots, therefore it causes an ArgumentError
forest_dsl = {
	'root1' => {
		'leave1' => nil,
		'leave2' => nil
	},
	'root2' => {
		'leave3' => nil,
		'leave4' => nil
	}
}
begin
	invalid_tree = Tree.from_dsl(forest_dsl)
	arr = invalid_tree.inject([]) { | result, c | result << c }
	puts "Array: #{arr}"
rescue StandardError => e
	puts "Error: #{e}"
end

puts "#{family_tree.to_dsl}"
