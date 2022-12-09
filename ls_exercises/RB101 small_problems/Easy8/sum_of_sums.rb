def sum_of_sums2(num_arr)
  (0...num_arr.size).map { |idx| num_arr[0..idx].sum }.sum
end

# neat!
def sum_of_sums(num_arr)
  (0...num_arr.size).sum { |i| num_arr[i] * (num_arr.size - i) }
end
