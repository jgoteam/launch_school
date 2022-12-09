1. 
arr = [1, 3, 5, 7, 8, 11]
num = 3

if arr.include?(number): 
  puts "The number #{num} is in the array."
end

2. 
(1) returns 1
    arr = [["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]] 

(2) returns [1, 2, 3]
    arr = [["b"],["a", [1, 2, 3]] 

3. arr = [["test", "hello", "world"],["example", "mem"]]

  To return "example":

    arr.last.first 

4. 
(1) 3
(2) Error
(3) 8

5. 
a = "e"
b = "A"
c = nil
# Note: Ruby returns nil when out of range, does not give error

6. 
The error is as follows: Where the string 'margaret' is, is where the index number of the array should go. 
It appears the user is attempting to replace the string 'margaret' with 'jody'

To fix: 
names[3] = 'jody'

7. 
cats = ["billy", "bob", "tony"]

cats.each_with_index{ |cat, order| puts "#{order}. #{cat}"}

8. 
a = [1, 2, 3, 4, 5]

b = a.map { |i| i + 2}

p a
p b