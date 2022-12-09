def multiply(num1, num2)
  num1 * num2
end

def square(num)
  muliply(num, num)
end

# Further exploration
def exponentize2(num, power)
  case power
  when 0
    1
  when 1
    multiply(num, 1)
  when 2
    multiply(num, num)
  else
    multiply(num, num) * (power - 2) * num
  end
end

# Further exploration with recursion
def exponentize(num, power)
  return 1 if power == 0
  num = multiply(exponentize(num, power - 1), num)
end
