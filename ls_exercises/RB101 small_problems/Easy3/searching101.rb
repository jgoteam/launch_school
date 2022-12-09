num_arr = []
index = 0
until num_arr.size == 6
  display_nums = ['1st', '2nd', '3rd', '4th', '5th', 'last']
  puts "==> Enter the #{display_nums[index]} number:"
  to_add = gets.chomp.to_i
  num_arr << to_add
  index += 1
end

if num_arr[0..4].include?(num_arr[-1])
  puts "The number #{num_arr[-1]} appears in #{num_arr}."
else
  puts "The number #{num_arr[-1]} does not appear in #{num_arr}."
end
