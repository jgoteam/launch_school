def count_occurrences(vehicles)
  counts = {}
  vehicles.each do |vehicle|
    if counts[vehicle.upcase.to_sym]
      counts[vehicle.upcase.to_sym] += 1
    else
      counts[vehicle.upcase.to_sym] = 1
    end
  end
  puts counts
end
