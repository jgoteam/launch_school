def transpose(matrix)
  row_size = matrix[0].size
  matrix.map.with_index do |_, idx|
    transposed_row = []
    row_size.times { |i| transposed_row << matrix[i][idx] }
    transposed_row
  end
end

# Further Exploration
def transpose!(matrix)
  matrix_copy = matrix.map(&:itself)
  matrix.map!.with_index do |_,idx|
    [matrix_copy[0][idx], matrix_copy[1][idx], matrix_copy[2][idx]]
  end
end