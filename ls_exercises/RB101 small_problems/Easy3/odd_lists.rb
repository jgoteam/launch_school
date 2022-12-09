def oddities(arr)
  arr.select.with_index { |_, idx| idx.even? }
end

def even_stranger(arr)
  arr.select.with_index { |_, idx| idx.odd? }
end

# Further exploration

def oddities2(arr)
  odd_arr = []
  arr.each