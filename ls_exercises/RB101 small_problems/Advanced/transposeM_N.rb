def transpose(matrix)
  rows = matrix[0].size
  columns = matrix.count { |el| el.is_a?(Array) }
  (0...rows).each_with_object([]) do |row, new_matrix|
    new_matrix << (0...columns).each_with_object([]) { |column, new_row| new_row << matrix[column][row] }
  end
end

p transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) == [[1]]

