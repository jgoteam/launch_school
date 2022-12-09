def repeat(string, num)
  num.times { puts string }
end

repeat("Hello", 3)

=begin

We are defining a method called repeat, which takes two parameters, `string` and `num`.

On line 5, the repeat method is being called (or invoked,) and is being passed the arguments string object "Hello" and the (literal) integer 3.
They are assigned to the local variables `string` and `num`, which are scoped to the method.
The method times is called on the object `num` with a block. The code in the block is executed the number of times specified by the value assigned
to the local variable num, which in this case is 3. Wihin the block, the method puts is called, with the argument string passed in. Puts will have the side effect
of printing the value of string to the screen, which will be done three times. Puts has a return value of nil, which times does not use; time will return
the same value it was given..(unless it was not given a block, in which case it would return an enumerator.)

Therefore, line 5 will output "Hello" three times, each on its own line, and have a return value of 3.

Review --
Why use methods?
  - Don't loops and iterators also solve the problem of not having to type common code over and over again?
  - Methods give you the flexibility to use common code at different places!
  - Thinking of methods as "chunks of code that return a value" (From "Programming Ruby")

Arguments versus Parameters:
Though sometimes used interchangably, the distinction between arguments and parameters is important.
Parameters:
  - can be identified alongside the method definition, and in the body of the definition method (with the same name as alongside the definition)
  - Parameters can be thought of *placeholders* for the argument in the definition of a method.
    - when an method with parameters is called, (OR is invoked,), the arguments are passed in, replacub of the parameters into the method.
      - The parameter is not passed in...!
  - Parameters do not contain a value.

Arguments:
  - On the other hand, arguments DO contain a value and are passed into the method.
  - The value or reference is assigned to the local variable, which has the same name as the parameter.
    - This last point likely clouds the discernment between parameter and argument.

the `print` and `puts` method have a reutrn value of nil...



