arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr.delete_if {|x| x.start_with? 's'}

puts arr
puts ""

# part 2

arr.push('snow', 'slippery', 'salted roads')

arr.delete_if { |x| x.start_with? 's' or x.start_with? 'w' }

puts arr