#!/usr/bin/env ruby

# Always true.
def tell_the_truth
	true 	# or: return true
end


# Uses hashes and symbols
def evaluate(options = {})
	if options[:debug] 
		puts "Debug mode."
	end
	if options[:units] == :metric
		puts "Using metric units."
	else 
		puts "Using inches and foots."
	end
end


# Demos hashes
def hashes
	numbers = {1 => 'one', 2 => 'two'}
	puts "#{numbers[1]}"
	puts "#{numbers[2]}"
	
	stuff = {:array => [1, 2, 3], :string => 'Hello, world!', :number => 3.12 }
	puts "#{stuff}"
	puts "#{stuff[:number]}"

	evaluate( :debug => true, :units => :metric )
	evaluate( :debug => false, :units => :us )
end


# Extends Fixnum with new homegrown methods which mimic 'times' 
class Fixnum

	# Custom times method using yield and an implicit block
	def times_v1
		i = self
		while i > 0
			i = i - 1
			yield i
		end
	end
	
	# Custom times method referencing the block with an ampersand
	def times_v2(&block)
		i = self
		while i > 0
			i = i - 1
			if block.arity ==1 
				block.call(i)
			else
				block.call
			end
		end
	end
	
	# Custom times method using a regular function object
	def times_v3(proc)
		i = self
		while i > 0
			i = i - 1
			if proc.arity == 1
				proc.call(i)
			else
				proc.call
			end 
		end
	end	

end


# Demos blocks
def blocks
	n = 3
	n.times_v1 {puts "holy moly"}
	
	n = 4
	n.times_v1 do 
		puts "holy moly" 
	end
	
	n = 5
	n.times_v2 {puts "honkey donkey"}
	
	n = 2
	n.times_v3 lambda {puts "hokey pokey"}
	# n.times_v3 {puts "hokey pokey"} will fail.
	
	n = 4
	n.times_v2 do |x|
		puts "honkey donkey #{x}" 
	end
	
	n = 2
	n.times_v3 lambda { |x| puts "hokey pokey #{x}" }

end
	 

puts "#{tell_the_truth}"
hashes
blocks

