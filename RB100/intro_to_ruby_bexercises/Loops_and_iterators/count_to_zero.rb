def count_to_zero(num)
  if num < 0
    return
  end
  puts num
  count_to_zero(num - 1)
end

count_to_zero(5)
count_to_zero(-5)