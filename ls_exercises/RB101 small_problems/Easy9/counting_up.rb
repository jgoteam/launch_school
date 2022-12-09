def sequence(num)
  (1..num).entries
end

# Further Exploration
def sequence(num)
  num > 0 ? (1..num).entries : (num..1).entries
end
