class Person

  def age=(age)
    @age = double(age)
  end

  def age
    double(@age)
  end

  private

  def double(n)
    n * 2
  end

end

person1 = Person.new
person1.age = 20
puts person1.age