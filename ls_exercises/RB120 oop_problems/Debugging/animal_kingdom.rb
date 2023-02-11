class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower) # Added parameters so that only the necessary arguments are passed up
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

=begin

The error is on line 37. If we invoke `super` without any arguments and without parentheses, this will pass all arguments that was passed to
`initialize` on line 36 to a method with the same name in the superclass. The `initialize` method in the superclass `Bird` has two parameters,
and `super` on line 37 is trying to pass it three arguments, which is why this results in an error.

To remedy this, one could add two parameters, representing the two arguments to be sent to the method of the same name in the superclass.