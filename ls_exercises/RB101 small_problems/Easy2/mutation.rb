array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.map { |value| value.upcase if value.start_with?('C', 'S') }
puts array2

# What will the code output? Why?

=begin

Line 1 initiates an array with the name `array1` of 8 string objects. Line 2 initiates an array with the name 'array2' with 0 elements, an empty array.
Line 3 invokes the method each with a block, on the object referenced by `array1`. Each element, starting at index 0, will be passed into the block, assigned
to the block variable `value`. The block will be evaluated for each pass. In this case, each element of the array will be appended to array2.
THIS IS THE KEY PORTION ==> It is appending (passing!) the references to the original elements in array1.
In other words, all of the matching index numbers of array1 and array2 are both pointing to the same objects.
This means that if the object is modified, both variables, when called, of course, will show the same modified object.

Line 4 again calls the method each with a block, on the `array1` object. This time, each iteration, passed in as the block variable, will have the
mutating method `upcase!` called on it if it meets the condition of starting with 'C' or 'S'. All elements that meed this condition will their caller
mutated. As stated in the paragraph above, since both of these arrays are pointing to the same object, all changes that occur in array1 will also happen
in array2.

Final values for each variable:
array1 = %w(Moe Larry CURLY SHEMP Harpo CHICO Groucho Zeppo)
array2 = %w(Moe Larry CURLY SHEMP Harpo CHICO Groucho Zeppo)


expected output:
Moe
Larry
CURLY
SHEMP
Harpo
CHICO
Groucho
Zeppo


# Further exploration
This problem is a great illustration for pass by reference, but also for how one should be careful with mutating methods,
and of course, what follows: it is important to know whats going on under the hood, in this case how ruby assigns, passes, manipulates data.

=end
