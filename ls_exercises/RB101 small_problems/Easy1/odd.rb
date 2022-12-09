def is_odd?(num)
  num % 2 == 1
end

=begin
We are defining a method named is_odd? with one parameter num. It will return
the evaluated result of the last expression, which in this case is
`num % 2 == 1`. This expression will return a boolean value, which will also be
the return value of this method.

Review --
ruby ALWAYS will return the evaluated result of the last expression in a method, unless an explicit
return comes before.