def word_cap(string)
  string.downcase.split(' ').map { |word| word[0].upcase + word[1..word.size - 1]}.join(' ')
end
