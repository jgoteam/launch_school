def find_fibonacci_index_by_length(num_length)
  fibonacci = [1, 1]
  fibonacci << fibonacci[-2..-1].sum until fibonacci.last.to_s.size == num_length
  fibonacci.find_index(fibonacci.last) + 1
end
