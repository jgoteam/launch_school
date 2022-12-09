1. 
def has_lab?(string)
  if string =~ /lab/
    puts string
  else
    return
  end
end

has_lab?("laboratory")
has_lab?("experiment")
has_lab?("Pans Labyrinth")
has_lab?("elaborate")
has_lab?("polar bear")

2. 
The code will not print anything to the screen.
It will return a proc object, so the block was passed into the method, and into the given variable.

3. 
Exception handling is the approach and process of handling errors that may come up in one's code.

4. 
def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

5. 
The error occurs because the block was never passed in. The method needs "&block" instead of "block" as its parameter.