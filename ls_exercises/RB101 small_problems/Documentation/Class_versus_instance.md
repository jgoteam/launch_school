Class versus instance methods

ruby-doc source: https://ruby-doc.org/core-2.5.0/File.html#method-c-path

To illustrate the difference between Class versus instance methods, we are using File::path and File#path...

- `File::path` indicates that this `path` method is a method for the class `File`. This is what the double colon `::` communicates.
- `File#path` indicates that this `path` method is an instance method, for an object created of the class `File`. This is what the pound symbol `#` communicates.

```ruby
p File.path("test_folder/testfile2.txt")          #=> "test_folder/testfile2.txt"

input = File.new("test_folder/testfile.md", "w")
p input.path            #=> "test_folder/testfile.md"
```


