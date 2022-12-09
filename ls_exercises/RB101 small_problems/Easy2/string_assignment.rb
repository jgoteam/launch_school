name = 'Bob'
save_name = name
name.upcase!
puts name, save_name

# Before running...
=begin

The above code should output BOB two times, one on its own line.

Why?

The object of 'Bob' is assigned to the variable `name`. `name`, in other words, is referencing the string object 'bob'.
On line 2, the object referenced by the variable `name` is now assigned to the variable `save name`. At this point, both
the variable `name` and `save_name` are both referencing the same string object `bob`
On line 3, the mutating method `upcase!` is invoked on the object that the variable `name` is referencing, which is `bob`.
Since `upcase!` is a mutating method, it mutates the caller, which is this same object that both `name` and `save_name`
are referencing. That object now has the value of 'BOB'.
On line 4, puts method is called, with two arguments of `name` and `save_name` passed in. Since we know that both of these
variables point to the same string object 'BOB', this puts will print that to the screen two times, one for each variable reference,
each on its own line.
=end
