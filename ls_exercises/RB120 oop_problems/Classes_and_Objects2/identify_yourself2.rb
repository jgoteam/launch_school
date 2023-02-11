class Cat

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{@name}!"
  end

end

kitty = Cat.new('Sophie')
puts kitty #"I'm Sophie!"