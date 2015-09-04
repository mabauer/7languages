#!/usr/bin/env ruby


# Converts an array into a hash
# Examples:
# 	[[1, 3, 5], [0, 2, 4]] -> {1=>[3, 5], 0=>[2, 4]}
# 	[[1, 5, 9], [0, 4], [2], []] -> {1=>[5, 9], 0=>4, 2=>[]}
# If singletons == true, one-element arrays are are preserved:
# 	[[1, 5, 9], [0, 4], [2], []] -> {1=>[5, 9], 0=>[4], 2=>[]}

def array_to_hash(arr, singletons=false)
	hash = {}
	if arr
		for nested in arr
			if nested.class == Array
				values = Array.new(nested)
				if values.length >= 1
					key = values.delete_at(0)
					if !singletons && values.length == 1 
						hash[key] = values[0]
					else
						hash[key] = values
					end
				end
			else
				hash[nested] = []
			end			
		end
	end
	return hash
end

	
traffic_light = {:red => 'red', :yellow => 'yellow', :green => 'green'}
traffic_light_as_array = traffic_light.to_a

puts "#{traffic_light}"
puts "#{traffic_light_as_array}"

numbers = [['one', 1], ['two', 2]]
numbers_as_hash = numbers.to_h

puts "#{numbers}"
puts "#{numbers_as_hash}"

moduli = [[1, 3, 5], [0, 2, 4]]
moduli_as_hash = array_to_hash(moduli)
puts "#{moduli} -> #{moduli_as_hash}"

moduli = [[1, 5], [0, 4], [2], []]
moduli_as_hash = array_to_hash(moduli)
puts "#{moduli} -> #{moduli_as_hash}"

numbers_as_hash = array_to_hash(numbers)
puts "#{numbers} -> #{numbers_as_hash}"
numbers_as_hash = array_to_hash(numbers, true)
puts "#{numbers} -> #{numbers_as_hash}"

simple_array = (1..5).to_a
simple_array_as_hash = array_to_hash(simple_array)
puts "#{simple_array} -> #{simple_array_as_hash}"


