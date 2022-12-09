def word_lengths(string)
  string.split(' ').map { |word| "#{word} #{word.size}" }
end
