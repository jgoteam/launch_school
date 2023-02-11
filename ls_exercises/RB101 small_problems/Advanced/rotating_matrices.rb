# Visual approach
def rotate90(matrix)
  row_count = matrix[0].size
  column_count = matrix.count { |el| el.is_a?(Array) }
  (0...row_count).each_with_object([]) do |row_idx, new_matrix|
    new_row = (column_count - 1).downto(0).each_with_object([]) do |column_idx, row|
                row << matrix[column_idx][row_idx]
              end
    new_matrix << new_row
  end
end
