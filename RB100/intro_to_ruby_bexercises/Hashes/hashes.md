1. 
family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }

immediate_family = family.select { |k, v| k = "brothers" || k = "sisters" }

new_array = immediate_family.flatten

2. 
cats = {billy: "XL", bob: "L", tony: "M"}
humans = {jack: "M", jane: "S"}

all_creatures = cats.merge(humans)

puts all_creatures
puts cats

cats.merge!(humans)

puts all_creatures
puts cats

3. 
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

4. 
person[:name]

5. 
cats = {billy: "XL", bob: "L", tony: "M", jack: "M", jane: "S"}

if cats.value?("M")
  puts "Found."
else
  puts "Not found."
end

6. 
The first hash has the key 'x' as a symbol. The second hash has the key 'x' as a string.

7. 
B. There is no included method of 'keys' for the class Array in Ruby.