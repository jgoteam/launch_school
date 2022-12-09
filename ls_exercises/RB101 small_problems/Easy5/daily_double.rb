def crunch(string)
  string.chars.chunk { |x| x }.map(&:first).join
end
