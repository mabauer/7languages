#!/usr/bin/env ruby

def study1

	puts "Hello, world!"
	
	# Executable blocks
	properties = ['object oriented', 'duck typed', 'productive', 'fun']
	properties.each {|property| puts "Ruby is #{property}!"}
		
	# Loops
	i = 1
	while i <= 10
		puts "Markus"
		i = i + 1
	end
	
	for i in 1..10
		puts "This is sentence number #{i}"
	end
	
	s = ''
	for i in 0..79
		s = s + i.modulo(10).to_s 
	end
	puts s
	
	# Strings and pattern matching
	# Strings start from index 0
	s = "Hello, Ruby!"
	puts s
    puts "\'Ruby\' starts at index #{s.index("Ruby")}" # or: puts s.index("Ruby").to_s

	# Replace __ with the string's length
	s = "This is a string with length __"
	puts s.sub!('__') { |match| s.length.to_s }
	
	# Check if an expression matches
	s = "Use the force"
	regexp = /force/
	i = s =~ regexp
	puts "\'#{regexp.source}\' matches \'#{s}\' in position #{i}." 
	
	# Extract an e-mail address from a string.
	regexp = /([\w\-]+(\.[\w\-])*)+@([\w\-]+\.)+[a-zA-Z]{2,}/
	s = "Just drop me an e-mail under Markus.Bauer@cas.de"
    m1 = s.match(regexp) 
	puts m1.to_s if m1

	# This one should not match
	s = "Markus Bauer, Markus.Bauer@cas, mkbauer.@web.de"
    m1 = s.match(regexp) 
	puts m1.to_s if m1

	# Duck typing: Ruby is typed. 
	# However, objects do not have to use a common superclass to be able to understand the same method.
	numbers = ['1', 1.5, 2, 3.14159, 100, '100.0']
	types = numbers.map {|number| number.class }
	numbers_as_ints = numbers.map {|number| number.to_i }
	puts "#{numbers}"
	puts "#{types}"
	puts "#{numbers_as_ints}"

end	

study1
	