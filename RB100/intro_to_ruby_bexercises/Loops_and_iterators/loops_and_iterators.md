1. [2, 3, 4, 5, 6]
2. 

while true
  puts "Type 'STOP' to stop."
  answer = gets.chomp
  if answer == "STOP"
    break
  end
end

3. 

def count_to_zero(num)
  if num < 0
    return
  end
  puts num
  count_to_zero(num - 1)
end
