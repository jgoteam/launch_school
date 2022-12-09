def leading_substrings(str)
  (1..str.size).each_with_object([]) { |num, arr| arr << str[0, num] }
end
