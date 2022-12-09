def all_caps(word)
  if word.length > 10
    word.upcase
  else
    word
  end
end 

puts all_caps("this is more than ten characters")
puts all_caps("lowercase")