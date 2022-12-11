def rotate_string(input)
  input[1..-1] + input[0]
end

def rotate_rightmost_digits(num, digit)
  new_num = num.to_s[0...-digit] + rotate_string(num.to_s[-digit...num.size])
  new_num.to_i
end