def fibonacci(num)
  return 1 if [1,2].include?(num)
  fibonacci(num - 2) + fibonacci(num - 1)
end
