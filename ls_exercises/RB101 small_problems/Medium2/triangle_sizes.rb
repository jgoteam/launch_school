def triangle(*sides)
  return :invalid if sides.size != 3
  sides = sides.map(&:to_f)
  return :invalid if sides.any? { |side| side >= sides.sum - side }
  [:equilateral, :isosceles, :scalene][sides.uniq.size - 1]
end

