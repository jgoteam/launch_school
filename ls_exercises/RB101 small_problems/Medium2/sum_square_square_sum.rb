def sum_square_difference(n)
  sq_of_sums = (1..n).to_a.sum ** 2
  sum_of_sqs = (1..n).to_a.map { |i| i**2 }.sum
  sq_of_sums - sum_of_sqs
end
