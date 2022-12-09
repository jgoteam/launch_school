cats = {billy: "XL", bob: "L", tony: "M", jack: "M", jane: "S"}

cats.keys.each do |name|
  print name.to_s + " "
end

cats.values.each do |size|
  print size + " "
end

cats.each do |name, size|
  print name.to_s + ": " + size + " "
end