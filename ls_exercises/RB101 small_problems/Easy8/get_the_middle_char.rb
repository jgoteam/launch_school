def center_of(string)
  string.size.even? ? string[string.size / 2 - 1, 2] : string[string.size / 2]
end
