def right_triangle2(height)
  1.upto(height) { |num| puts ('*' * num).rjust(height) }
end

# Further Exploration

# Choose from which corner the right angle is for the triangle
# Top left to bottom right
=begin
1====2
|    |
3====4
=end

def right_triangle(height, choice)
  case choice
  when 1
    height.downto(1) { |num| puts ('*' * num).ljust(height) }
  when 2
    height.downto(1) { |num| puts ('*' * num).rjust(height) }
  when 3
    1.upto(height) { |num| puts ('*' * num).ljust(height) }
  when 4
    1.upto(height) { |num| puts ('*' * num).rjust(height) }
  end
end

right_triangle(9, 1)
right_triangle(9, 2)
right_triangle(9, 3)
right_triangle(9, 4)