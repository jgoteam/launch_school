def bubble_sort!(arr)
  loop do
    no_swap = true
    sorted = []
    (0...arr.size - 1).each do |idx|
      next if sorted.any?(idx)
      if (arr[idx] <=> arr[idx + 1]) == 1
        arr[idx + 1], arr[idx] = arr[idx], arr[idx + 1]
        no_swap = false
      else
        sorted << idx
      end
    end
    return arr if no_swap
  end
end

# fun one