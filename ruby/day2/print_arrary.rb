#!/usr/bin/env ruby

# Prints the contents of an array of sixteen numbers, four umbers at a time.

numbers = (1..16).to_a

# Using each
i = 1
numbers.each do |n|
	print "#{n}\t"
	if (i % 4) == 0
		puts
	end
	i = i + 1
end

# Using each_slice
numbers.each_slice(4) do |a|
	a.each do |n|
		print "#{n}\t"
	end
	puts
end

# Or even shorter
numbers.each_slice(4) {|a| a.each {|n| print "#{n}\t"}; puts }