class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year)
    super(name, year)
    @parking_allowed = true
  end
end

class Undergraduate < Student; end

