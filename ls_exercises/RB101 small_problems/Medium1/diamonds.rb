def diamond(n)
  num_of_stars = ((1...n).to_a + n.downto(1).to_a).select(&:odd?)
  num_of_stars.map { |count| puts ('*' * count).center(n)  }
end

# Further Exploration
def diamond_shape(n)
  num_of_stars = ((1...n).to_a + n.downto(1).to_a).select(&:odd?)
  num_of_stars.map do |count|
    pattern = count < 2 ? '*' : '*' + ' ' * (count - 2) + '*'
    puts pattern.center(n)
  end
end
