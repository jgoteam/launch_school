def multiply(num1, num2)
  num1 * num2
end

#  alt
def multiply2(num1, num2)
  [num1, num2].reduce(:*)
end


# Further exploration

=begin
If the first argument is an array, the return value will be also be an array, with the size of the argument times the second argument.
The elements of this array will be copies of the same elements as in the argument passed in. Of note, these copies share the same
references as the originals!

