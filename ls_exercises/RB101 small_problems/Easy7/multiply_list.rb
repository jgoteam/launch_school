def multiply_list(arr1, arr2)
  arr1.map.with_index { |el, idx| el * arr2[idx] }
end

# zip method
def multiply_list(arr1, arr2)
  arr1.zip(arr2).map { |subarr| subarr.inject(:*) }
end
