#!/usr/bin/env ruby

# Uses metaprogramming to handle CSV files in a convenient way.

module ActsAsCsv

    # Will be called if the module is included into some class 'base'
    def self.included(base)
        base.extend(ClassMethods)
    end

    # Class methods to be mixed in     
    module ClassMethods

        def acts_as_csv
            include InstanceMethods
        end
 
    end
    
    # Instance methods to be mixed in
    module InstanceMethods
    
        attr_accessor :headers, :contents

        def initialize
            read
        end

        # Reads in a CSV file (derived from the class name)
        def read
            @contents = []
            filename = self.class.to_s.downcase + '.txt'
            file = File.new(filename)

            # Split the header row (and remove unneeded leading and trailing white spaces)
            @headers = file.gets.split(',')
            @headers.each do |header|
                header.strip!
            end

            # Split the rest of the rows (and remove unneeded leading and trailing white spaces)
            file.each do |row|
                values = row.split(',')
                values.each do |value|
                    value.strip!
                end
                @contents << values
            end
        end

        # Applies 'block' to each row (as CsvRow)        
        def each(&block)
            @contents.each do |row|
                values = Hash[headers.zip(row)]
                row_obj = CsvRow.new(values)
                block.call(row_obj)
            end
        end
    
    end   
   
    # Represents a row, dynamically adds methods for each header/column name   
    class CsvRow
   
        def initialize(values={})
            @values = values
        end

        # Use override method missing to return a value for method calls 
        # corresponding to known headers        
        def method_missing(name, *args)
            if @values[name.to_s]
                return @values[name.to_s]
            else 
                raise NoMethodError, "undefined method \'#{name.to_s}\' for #{self.to_s}"
            end
        end
        
    end
    
end

class RubyCsv
    include ActsAsCsv
    acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.contents.inspect

m.each do |row|
    puts row.one
    puts row.two
    
    # This will result in an error:
    puts row.three
end
