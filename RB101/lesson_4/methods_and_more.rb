=begin

# 1

[1, 2, 3].select do |num|
  num > 5
  'hi'
end


The select method is called on the array object [1, 2, 3], with the do..end block on lines 1 through 4 passed in as an argument. The select method
  will call the given block once for each element in this array object, and will evaluate the return value of the passed block each time.
  If the return value of the passed block is 'truthy', then that element will be selected; if the return value is 'falsey', then it will not be selected.
  The select method will then return a new collection containing all of these selected elements.
  Since Ruby methods return the value of the last expression in blocks, the return value of the above `select` method call will always be `truthy`,
  and will alway be selected. Thus, the `select` method call will return a new collection, with the same elements as the array object [1, 2, 3] it
  was called on.

The return value of the select method call above will be a new array object [1, 2, 3]. Not that this array object will be a different array object
than the array object the select method was originally called on on line 1, as select will return a new collection.


# ['ant', 'bat', 'caterpillar'].count { |str| str.include?('z') }
# vs.
# ['ant', 'bat', 'caterpillar'].count do |str|
#   str.include?('z')
# end

=begin
{} blocks binds more tightly than do..end blocks ??
=end

#3. The 'reject' method returns a collection of elements that have been evaluated as 'falsy' aka false or nil. NOT truthy!!

=begin

#4

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

Predicted output:

{'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}

#5

hash = { a: 'ant', b: 'bear' }
hash.shift
p hash # {:b => 'bear'}
# we can test by using the p method

#6

['ant', 'bear', 'caterpillar'].pop.size # 10, as it takes the size of the return value of pop, which is the last element of the array.\
# it should be 11, as caterpillar has 11 letters, not 11.

#7

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# Mission:
#   - return value of the block?
#   - reasoning?
#   - return value of any? what is the output?

# The return value of the block would be true. This is the case as each element in the array, starting from index 0, is evaluated. The last two elements
# is not evaluted as ruby already has an element that evalutes as true. Noted the return value of the block is determined by the last statement of the block
# return value is true, with the output of:
# 1


#8
arr = [1, 2, 3, 4, 5]
p arr.take(2)
p arr

# the take method takes one parameter; that argument determines how many elements will be returned, starting from index 0.

#9

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# Noted that map ALWAYS outputs an array, and that for an if statement, if the condition is not evaluated as true, then it returns 'nil'.

#10

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# Predicted output: [1, nil, nil]
=end




