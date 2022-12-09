def running_total(arr)
  arr.map.with_index { |_, idx| arr[0..idx].sum }
end
