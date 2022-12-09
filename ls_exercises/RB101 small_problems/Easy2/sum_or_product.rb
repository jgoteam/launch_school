
base_num = nil
loop do
  puts "Please enter an integer greater than 0: "
  base_num = gets.chomp.to_i
  break if base_num >= 0
  puts "That's not an integer greater than 0. Please try again."
end
sum_or_product = nil
loop do
  puts "Enter 's' to compute the sum. Enter 'p' to compute the product."
  sum_or_product = gets.chomp.downcase
  break if sum_or_product == 's' || sum_or_product == 'p'
  puts "That's not a valid input. Please enter either 's' for sum or 'p' for product."
end

case sum_or_product
when 's'
  puts "The sum of the integers between 1 and #{base_num} is #{(1..base_num).to_a.sum}."
else
  puts "The product of the integers between 1 and #{base_num} is #{(1..base_num).to_a.reduce(:*)}."
end

