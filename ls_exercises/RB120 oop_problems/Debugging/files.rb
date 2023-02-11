class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file
  end

  def to_s
    "#{name}.#{FORMAT}" # FORMAT should instead be `self.class::FORMAT`
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

# The error here has to do with understanding the lexical scope of constants in Ruby.
# In the code, our various constant definitions for FORMAT are being defined in the subclasses `MP3File`,
# `VectorGraphicsFile`, and `MarkdownFile`.
# Lexical scope means access is limited to the same block of code.
# In this case, there is no FORMAT constant defined within the File class. This class also does
# not have any mixins or superclasses, which would qualify as being in the same block of code.
# Because of this, the code above will throw an error, as an object referenced by `FORMAT` can not be found.
# A simple fix would be to give Ruby the lookup path to the CONSTANT definitions, located within each of
# the aforementioned subclasses.