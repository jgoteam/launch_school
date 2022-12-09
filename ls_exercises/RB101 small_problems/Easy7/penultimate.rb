def penultimate2(string)
  string.split(' ')[-2]
end

# Further Exploration

def penultimate(string)
  word_count = string.split(' ').count
  if word_count <= 1
    string
  elsif word_count.even?
    string.split(' ')[word_count / 2 - 1..word_count / 2].join(' ')
  else
    string.split(' ')[word_count / 2]
  end
end

=begin
Edge cases
  empty string, or one word string
    -return self
  even number
    -return two middle words
=end