def which_lights_on?(num)
  hsh = (1..num).map { |num| [num, false] }.to_h
  (1..num).each do |i|
    hsh.keys.each { |num| hsh[num] = !hsh[num] if num % i == 0 }
  end
  hsh.keys.select { |key| hsh[key] }
end
