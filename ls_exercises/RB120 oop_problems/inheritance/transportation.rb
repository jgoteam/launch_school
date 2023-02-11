module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

tacoma = Transportation::Truck.new

puts tacoma