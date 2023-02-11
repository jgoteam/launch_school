module Walkable
  def walk
    puts "#{name} #{gait} foward"
  end
end

class Noble
  include Walkable
  attr_reader :title, :name

  def initialize(name, title)
    @name = name
    @title = title
  end

  def walk
    print "#{title} "
    super
  end

  private

  def gait
    "struts"
  end
end


byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"