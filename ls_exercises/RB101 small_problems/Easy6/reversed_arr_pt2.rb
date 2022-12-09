# non-mutating
def reverse(arr)
  input_counter = arr.size - 1
  output_counter = 0
  new_arr = []
  until output_counter == arr.size
    new_arr[output_counter] = arr[input_counter]
    output_counter += 1
    input_counter -= 1
  end
  new_arr
end

# Further Exploration
def reverse(arr)
  arr.each_with_object([]) { |el, arr| arr.prepend(el) }
end

def reverse(arr)
  arr.inject([],:prepend)
end
