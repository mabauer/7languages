#!/usr/bin/env ruby

# A simple grep


# Search for 'expr' in 'filename', if 'filename' is not provided use STDIN instead.
def grep(expr, filename='')
	if filename == ''
		lines = STDIN.readlines
	else
		begin
			File.open(filename, "r") do |f|
				lines = f.readlines
			end
		rescue SystemCallError => e
			STDERR.puts "#{filename}: Error: could not read from file (#{e})."
			return
		end
	end
	for line in lines
		if line =~ Regexp.new(expr)
			puts "#{filename}: #{line}"
		end
	end

end


if ARGV.size < 1
	# No arguments: print usage message
	STDERR.puts "Usage: #{File.basename($0)} expr file..."
elsif ARGV.size ==1
	# One argument: assume it's the search expression and search in STDIN
	grep(ARGV[0])
else
	# Multiple arguments: the first is the search term, the rest are the files to be searched
	expr = 	ARGV[0]
	puts "#{expr}"
	(1..ARGV.size-1).each do |i|
		grep(expr, ARGV[i])
	end
end