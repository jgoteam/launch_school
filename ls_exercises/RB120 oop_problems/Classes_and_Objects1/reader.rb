class Cat
  attr_reader :name
  # equivalent to:
  # def name
  #   @name
  # end

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end

end

kitty = Cat.new("Sophie")
kitty.greet