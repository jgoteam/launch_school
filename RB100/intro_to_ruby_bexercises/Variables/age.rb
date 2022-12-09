# output only for 20 y/o

puts "How old are you?"
age = gets.chomp

for i in 1..4 
  puts "In #{10 * i} years you will be: "
  puts age.to_i + 10 * i
end
 