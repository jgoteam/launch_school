# mutating
def reverse!(arr)
  idx_counter = 0
  arr_copy = arr.map(&:itself)
  (arr.size - 1).downto(0) do |copy_idx|
    arr[idx_counter] = arr_copy[copy_idx]
    idx_counter += 1
  end
  arr
end
