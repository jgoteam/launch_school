1. 
(1) false
(2) false
(3) false
(4) true
(5) true

2. 

def all_caps(word)
  if word.length > 10
    word.upcase
  else
    word
  end
end 

puts all_caps("this is more than ten characters")
puts all_caps("lowercase")

3. 

def range_check(num)
  if (num > 0 && num < 50)
    "#{num} is between 0 and 50."
  elsif (num >51 && num < 100)
    "#{num} is between 51 and 100."
  elsif (num > 100)
    "#{num} is greater than 100."
  else
    "#{num} is not between 0 and 50, not between 51 and 100, not greater than 100."
  end
end

puts "number?"
a = gets.chomp.to_i

puts range_check(a)

4. 
Snippet 1: 
FALSE

Snippet 2: 
Did you get it right?

Snippet 3:
Alright now!

5. 
The error message comes up because the if conditional within the method was not closed. To fix it, 'end' should be inserted after line 5, with the indent in line with the 'if' and 'else'.

6. 
  (1) error
  (2) false
  (3) false
  (4) true
  (5) false
  (6) true

