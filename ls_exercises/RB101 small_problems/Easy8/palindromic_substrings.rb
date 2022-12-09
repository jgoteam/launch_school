# style 1
def palindrome?(str)
  str == str.reverse && str.size > 1
end

def palindromes(str)
  str.size.times.each_with_object([]) do |idx, arr|
    (1..str.size).each { |i| arr << str[idx, i] if palindrome?(str[idx, i]) }
  end
end

# style 2
def leading_substr(str)
  (1..str.size).each_with_object([]) do |num, arr|
    arr << str[0, num] if str[0, num] == str[0, num].reverse && str[0, num].size > 1
  end
end

def palindromes(str)
  str.size.times.each_with_object([]) do |idx, arr|
    arr << leading_substr(str[idx...str.size])
  end.flatten
end
