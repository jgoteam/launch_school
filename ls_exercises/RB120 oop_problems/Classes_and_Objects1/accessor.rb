class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end

end

kitty = Cat.new("Sophie")

kitty.name = "Luna"
kitty.greet