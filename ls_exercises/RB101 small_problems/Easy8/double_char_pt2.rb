def double_consonants(string)
  string.chars.map do |char|
    char =~ /[a-z]/i && char =~ /[^aeiou]/i ? char * 2 : char
  end.join
end
