#!/usr/bin/env ruby

# Demos how to access file with and without blocks

# Blocks have the advantage that they can be used to execute some code that
# benefits being sandwiched between code for automatic setup or tear down.
# Example: In File.open this is used for automatically closing a file after working on it.


# Prints a seperator
def print_separator
	40.times {print '-'}
	puts
end


# Demo File.open without blocks
def print_file(filename)
	begin
		file = File.open(filename)
		data = file.read
		puts data
		file.close
		print_separator
 	rescue StandardError => e
		puts "Error: Could not read file \'#{filename}\'."
 	end
end


# Demo File.open with blocks
def print_file_code_blocks(filename)

	# File open can cause en error, therefore check if the fie is readable
	if File.readable?(filename)		
		File.open(filename, "r") do |file|
			data = file.read
			puts data
			print_separator
			# File is closed automagically upon termination of the block
		end
	else
		puts "Error: Could not read file \'#{filename}\'."
	end
end


# Extend File with File.save_open, a more robust replacement for File.open
class File

	# save_open changes the behaviour of open: 
	# the block working with the file is only executed if no error happend when opening the file
	def self.save_open(filename, mode="r", opt={}, &block)
		if block_given? 
			begin 
				file = open(filename, mode, opt)
				block.call(file)
			rescue
				puts "Debug: Error opening file \'#{filename}\'." 
			end
		else
			file = open(filename, mode, opt)
		end 
		return file
	end

end


# Demo save_open without blocks
def print_file2(filename)
	begin
		file = File.save_open(filename)
		data = file.read
		puts data
		file.close
		print_separator
 	rescue StandardError => e
		puts "Error: Could not read file \'#{filename}\'."
 	end
end


# Demo save_open using blocks
def print_file_code_blocks2(filename)
	# File is closed automagically upon termination of the block
	File.save_open(filename, "r") do |file|
		data = file.read
		puts data
		print_separator
	end
end
			

def test_suite(filename)
	print_file(filename)
	print_file_code_blocks(filename)
	print_file2(filename)
	print_file_code_blocks2(filename)
end


# This should work and print the program a couple of times
filename = $0
test_suite(filename)

# This should fail (since the file won't be present)
filename = "invalid-file.123"
test_suite(filename)

