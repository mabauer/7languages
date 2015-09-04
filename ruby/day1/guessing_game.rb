#!/usr/bin/env ruby

def guess_a_number

	puts "Guess my number, use ENTER to quit."
	
	secret = rand(99) +1
	
	begin
		print "Your guess: "
		
		# gets will add '\n' to input, chomp removes it
		input = gets.chomp
		
		if '' == input
			break
		end
			
		guess = input.to_i
		
		if guess < secret
			puts "Your guess is way to low!"
		elsif guess > secret
			puts "Your guess is way to high!"
		else
			puts "Congrats: You've guessed my number #{secret}."
		end
 	
 	end until guess == secret
		
	puts "Good bye."		

end

guess_a_number