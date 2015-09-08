#!/usr/bin/env ruby

# Roman numbers (with some meta programming)

class Roman

    # Override class method method_missing.
    # The method name will be used as the input parameter for the number conversion
    def self.method_missing(name, *args)
        return to_i(name.to_s)
    end
    
    # Convert a string with some roman number into an integer
    def self.to_i(roman)
        roman.gsub!('IV', 'IIII')
        roman.gsub!('IX', 'VIII')
        roman.gsub!('XL', 'XXXX')
        roman.gsub!('XC', 'LXXXX')
        roman.gsub!('CD', 'CCCC')
        roman.gsub!('CM', 'DCCCC')
    
        puts "#{roman}"
        
        # Multiline statement, be sure to end each line with an operator or \
        result = (roman.count("I") +
            roman.count("V") * 5 +
            roman.count("X") * 10 +
            roman.count("L") * 50 +
            roman.count("C") * 100 +
            roman.count("D") * 500 +
            roman.count("M") * 1000)
        return result
    end  
end  

# Regular class method calls
puts Roman.to_i('XI')
puts Roman.to_i('XC')
puts Roman.to_i('MCMLXXXIV')

# via overriding method_missing
puts Roman.MCMLXXXIV

