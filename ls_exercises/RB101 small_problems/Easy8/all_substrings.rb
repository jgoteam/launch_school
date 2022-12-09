def leading_substr(str)
  (1..str.size).each_with_object([]) { |num, arr| arr << str[0, num] }
end

def substrings(str)
  str.size.times.each_with_object([]) do |idx, arr|
    arr << leading_substr(str[idx...str.size])
  end.flatten
end
