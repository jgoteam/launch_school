def integer_to_string(num)
  num_hsh = { 0 => '0', 1 => '1' , 2 => '2', 3 => '3', 4 => '4', 5 => '5' , 6 => '6', 7 => '7', 8 => '8', 9 => '9' }
  string = ""
  num.digits.reverse.each { |num| string += num_hsh[num] }
  string
end
