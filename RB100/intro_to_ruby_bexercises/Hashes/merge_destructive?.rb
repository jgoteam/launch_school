cats = {billy: "XL", bob: "L", tony: "M"}
humans = {jack: "M", jane: "S"}

all_creatures = cats.merge(humans)

puts all_creatures
puts cats

cats.merge!(humans)

puts all_creatures
puts cats