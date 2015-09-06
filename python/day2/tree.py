#!/usr/bin/env python

# A simple tree implementation -- including an iterator to work with the tree.

# A node is a tree :-)
class Tree(object):

    def __init__(self, name, children=[]):
        self.children = children
        self.node = name

    # Required to be iterable        
    def __iter__(self):
        return TreeIterator(self)
        
    def visit(self, action):
        action(self.node) 
    
    def visit_all(self, action):
        self.visit(action)
        for c in self.children:
            c.visit_all(action)
            
    def as_list(self):
        result = []
        result.append(self.node)
        for c in self.children:
            result.extend(c.as_list())
        return result

    def to_dsl(self):
        result = {}
        if self.children == []:
            result[self.node] = {}
        else:
            child_exps = {}
            for c in self.children:
                child_exps.update(c.to_dsl())
            result[self.node] = child_exps
        return result  
        
    @classmethod
    def node_from_dsl(cls, node, child_exps):
        if not child_exps or child_exps == {}:
            return cls(node, [])
        else:
            children = []
            for (child, child_exp) in child_exps.iteritems():
                children.append(cls.node_from_dsl(child, child_exp)) 
            return cls(node, children)
                
    
    @classmethod
    def from_dsl(cls, dsl):
        children = []
        if len(dsl) == 1:
            node = dsl.keys()[0]
            return cls.node_from_dsl(node, dsl[node])
        else:
            print "Error: Not a tree."
                   
            

# An iterator for our tree.
# This is not perfect since it duplicates the tree's nodes in a list
class TreeIterator(object):

    def __init__(self, tree):
        self.nodes = tree.as_list()
        self.index = 0
        
        
    def __iter__(self):
        return self    
        
    def next(self):
        if self.index < len(self.nodes):
            result = self.nodes[self.index]
            self.index += 1
            return result
        else:
            raise StopIteration

            
# Try the features
demo_tree = Tree("Animal", [
    Tree("Fish"), 
    Tree("Bird"), 
    Tree("Mammals", [
        Tree("Whale"), 
        Tree("Monkey")
    ])
])
        
# Visit all nodes
def print_node(node):
    print "Visiting node %s" % node
            
demo_tree.visit_all(print_node)

# Convert the tree to an array
nodes = demo_tree.as_list()
print "Nodes (as array): %s" % nodes

# Works, because Tree is iterable (and defines an iterator)
for node in demo_tree:
    print "%s" % node
    
# VERY simple DSL for trees
# The same tree build with the DSL
animals_as_dsl = {
    'Animal': {
        'Fish': {}, 
        'Bird': {},
        'Mammals': {
            'Whale': {}, 
            'Monkey': {}
        }, 
    }
}
print "DSL: \n%s" % animals_as_dsl

animals = Tree.from_dsl(animals_as_dsl)
print "DSL->tree->DSL: \n%s" % animals.to_dsl()


