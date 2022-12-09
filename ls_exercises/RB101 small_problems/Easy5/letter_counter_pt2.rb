def word_sizes(string)
  length_sizes = {}
  only_words = string.chars.keep_if { |char| ('a'..'z').include?(char.downcase) || char == ' '}.join
  only_words.split(' ').each do |word|
    length_sizes[word.size] ? length_sizes[word.size] += 1 : length_sizes[word.size] = 1
  end
  length_sizes
end

# String#count and String#delete