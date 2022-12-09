def ascii_value(string)
  string.chars.reduce(0) { |sum, char| sum += char.ord }
end

# Further exploration
# The inverse of the 'ord' method is 'chr'