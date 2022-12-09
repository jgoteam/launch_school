def when_retire
  current_year = Time.now.year
  puts "What is your age?"
  current_age = gets.chomp.to_i
  puts "At what age would you like to retire?"
  retirement_age = gets.chomp.to_i
  puts "It's #{current_year}. You will retire in #{current_year + (retirement_age - current_age)}."
  puts "You have only #{retirement_age - current_age} years of work to go!"
end
