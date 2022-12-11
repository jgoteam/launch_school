def triangle(*angles)
  return :invalid if angles.sum != 180 || angles.any? { |i| i <= 0 }
  return :right if angles.include?(90)
  angles.sort.max > 90 ? :obtuse : :acute
end
