def rotate_string(input)
  input[1..-1] + input[0]
end

def rotate_rightmost_digits(num, digit)
  new_num = num.to_s[0...-digit] + rotate_string(num.to_s[-digit...num.size])
  new_num.to_i
end

def max_rotation(num)
  copy = num.to_s
  rotate_count = copy.size
  rotate_count.times { |x| copy = rotate_rightmost_digits(copy.to_s, (rotate_count - x)) }
  copy.to_i
end