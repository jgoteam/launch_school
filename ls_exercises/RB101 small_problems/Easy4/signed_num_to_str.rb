def signed_integer_to_string(num)
  num_hsh = { 0 => '0', 1 => '1' , 2 => '2', 3 => '3', 4 => '4', 5 => '5' , 6 => '6', 7 => '7', 8 => '8', 9 => '9' }
  string = ""
  if num < 0
    num = num * -1
    string += '-'
  elsif num == 0
    string = ""
  else
    string += '+'
  end
  num.digits.reverse.each { |num| string += num_hsh[num] }
  string
end
