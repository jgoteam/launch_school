def fibonacci_last(num)
  first, last = [0, 1]
  2.upto(num) { |i| first, last = [last, (first + last) % 10] }
  last.to_s[-1].to_i
end

# Further Exploration
def fibonacci_last(num)
    arr = (2..59).each_with_object([0, 1]) { |i, arr| arr << arr[-2, 2].sum % 10 }
    arr[num % 60]
end