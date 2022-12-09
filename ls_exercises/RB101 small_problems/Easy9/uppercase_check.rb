def uppercase?(str)
  only_letters = str.chars.select { |char| char =~ /[a-z]/i }
  !only_letters.any? { |el| el =~ /[a-z]/ }
end
