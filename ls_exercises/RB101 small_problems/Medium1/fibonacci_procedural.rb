# not efficient - no reason to save entire sequence
def fibonacci(num)
  (2..num).each_with_object([0, 1]) { |i, arr| arr << arr[-2, 2].sum }[num]
end

def fibonacci(num)
  first, last = [0, 1]
  2.upto(num) { |i| first, last = [last, first + last] }
  last.to_s[-1]
end
