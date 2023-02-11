class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # false
puts ada.location.to_s == grace.location.to_s # true
puts "#{ada.location}" == "#{grace.location}" # true


# Added to_s method call to both sides of the expression on lhne 39. The `location` getter calls
# for `ada` and `grace` would return two different Geolocation objects, with the same values for
# their respective latitude and longitude instance variables. They are still different objects though,
# which is why the line on 39 will return false.

# To remedy this error, one could invoke our custom `to_s` method on location for each side of the expression,
# or use string interpolation for both sides of the expression, which both achieve the same thing:
# calling `to_s` on these Geolocation objects, which will return a string consisting of their latitude and
# longitude values.
