def range_check(num)
  if (num > 0 && num < 50)
    "#{num} is between 0 and 50."
  elsif (num >51 && num < 100)
    "#{num} is between 51 and 100."
  elsif (num > 100)
    "#{num} is greater than 100."
  else
    "#{num} is not between 0 and 50, not between 51 and 100, not greater than 100."
  end
end

puts "number?"
a = gets.chomp.to_i

puts range_check(a)