def digit_list(num)
  num.to_s.chars.map(&:to_i)
end

=begin
We are defining a method digit_list with one paramter `num`. When the method
is being called (or invoked,) the argument's value is assigned to the local
variable num. From here, the method to_s is called on the object of num; this will
return the num object as a string. This string will be passed to the chars method, which
returns an array of the size of string, with the elements being 1 string, of 1 character
length each. Finally, this array will be passed to the map method, which will return
a transformed array, in this case, with each element of the passed array being converted to
the Integer type.

Review..

=end


