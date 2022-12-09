1. 
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each { |x| puts x}

2. 
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each do |x|
  if x > 5
    puts x
  end
end

3. 
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
new_arr = arr.select { |x| x % 2 == 1}

4. 
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.push(11)
arr.unshift(0)

5. 
arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
arr.pop
arr.push(3)

6. 
arr = [3, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.uniq!
# get rid of duplicates from the given arr, mutating the caller

7. 
Both are structs. The makeup of hashes are key:value pairs. The makeup of arrays are any values, including other arrays. Arrays generally easier to sort.

8. 
{:billy => 20, :bob => 25}
{billy: 20, bob: 25}

9. 
(1) h[:b]
(2) h[:e] = 5
(3) h.delete_if {|k, v| v < 3.5}

10. 
Yes, hash values can be arrays. You can also have an array of hashes.

hash with arrays: 
{1: [1, 2, 3], 2: [4, 5, 6,], 3: [7, 8, 9]}

array with hashes: 
[{a: 1}, {b: 2}, {c: 3}]

11. 
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts.each_with_index do |(k, v), i|
  contacts[k][:email] = contact_data[i][0]
  contacts[k][:address] = contact_data[i][1]
  contacts[k][:phone] = contact_data[i][2]
end

puts contacts

12. 
puts contacts["Joe Smith"][:e-mail]

puts contacts["Sally Johnson"][:phone]

13. 
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

# part 1

arr.delete_if {|x| x.start_with?('s')}

puts arr
puts ""

# part 2

arr.push('snow', 'slippery', 'salted roads')

arr.delete_if { |x| x.start_with?('s', 'w')}

puts arr

14.
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
new_arr = []

a.each do |x|
  new_arr.push(x.split(" "))
end

new_arr.flatten!

p new_arr

15.
"These hashes are the same!"

16.
This was done using iteration already in #11.