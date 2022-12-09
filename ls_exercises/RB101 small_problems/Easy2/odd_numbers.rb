def odd_to_hundred
  puts (1..99).select { |num| num.odd? }
end

# Further exploration
def odd_to_hundred2
  1.upto(99) { |num| puts num if num.odd? }
end
