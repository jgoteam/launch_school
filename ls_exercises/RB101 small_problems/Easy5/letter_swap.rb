def swap(string)
  word_arr = string.split(' ')
  word_arr.each do |word|
    first_and_last = [word[0], word[-1]]
    word[0] = first_and_last[1]
    word[-1] = first_and_last[0]
  end
  word_arr.join(' ')
end

# After reading solution..learning syntax of parallel assignment here...
# word[0], word[-1] = string[-1], string[0]