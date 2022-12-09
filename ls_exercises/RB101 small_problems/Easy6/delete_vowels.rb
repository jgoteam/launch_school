def remove_vowels(string)
  string.map { |word| word.delete('AEIOUaeiou') }
end
