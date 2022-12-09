def word_sizes(string)
  length_sizes = {}
  string.split(' ').each do |word|
    length_sizes[word.size] ? length_sizes[word.size] += 1 : length_sizes[word.size] = 1
  end
  length_sizes
end
