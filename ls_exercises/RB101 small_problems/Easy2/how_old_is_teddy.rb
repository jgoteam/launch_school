def rand_age_for_teddy
  puts "Teddy is #{rand(20..200)} years old!"
end

# Further exploration
def rand_age
  puts "What's your name?"
  name = gets.chomp
  puts "#{name} is #{rand(20..200)} years old!" unless name == ''
  puts "Teddy is #{rand(20..200)} years old!" if name == ''
end

