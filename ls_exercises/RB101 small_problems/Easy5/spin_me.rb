def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

spin_me("hello world") # "olleh dlrow"

=begin
Will the returned string be the same object as the one passed in as an argument or a different object?

No, it will not be. The split method called on the method variable str returns a new array object of substrings, which the `each`` method then iterates through,
with a do..end block passed in as an argument. Within the block, the mutating method `reverse!` is called on each iteration, whose value is assigned to variable
`word` each time the block is executed. The each method will return itself; however, since the aforementioned 'reverse!' method is mutating, the elements of
the array object have been modified - in this case with the string in each element in reverse order.
Finally, the join method called on that modified object, will return a new object, a string joining the elements of the array with the delimiter ' '.
=end