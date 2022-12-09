def staggered_case(string)
  string.chars.map.with_index { |char, idx| idx.even? ? char.upcase : char.downcase }.join
end
