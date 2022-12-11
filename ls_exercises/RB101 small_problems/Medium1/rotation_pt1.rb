# 1st attempt
def rotate_array(arr)
  new_arr = arr.dup
  new_arr.append(arr[0]).delete_at(0)
  new_arr
end

# Further exploration incorporating approach from given solution
def rotate(input)
  if input.class == Array
    input[1..-1] + [input[0]]
  elsif input.class == String
    input[1..-1] + input[0]
  elsif input.class == Integer
    (input.to_s[1..-1] + input.to_s[0]).to_i
  end
end