def reverse_words(words)
  words.split(' ').each { |word| word.reverse! if word.size >= 5 }.join(' ')
end
