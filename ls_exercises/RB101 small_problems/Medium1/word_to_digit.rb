def word_to_digit(str)
  str_copy = str.split(' ').join(' ')
  num_convert = { 'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'}
  num_convert.keys.each { |word| str_copy.gsub!(word, num_convert[word]) }
  str_copy
end
