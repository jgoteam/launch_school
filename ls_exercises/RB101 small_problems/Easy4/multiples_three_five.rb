def multisum(num)
  to_sum = []
  (3..num).step(3) { |i| to_sum << i }
  (5..num).step(5) { |i| to_sum << i }
  to_sum.uniq.sum
end
