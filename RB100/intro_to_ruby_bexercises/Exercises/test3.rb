a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

new_arr = []

a.each do |x|
  new_arr.push(x.split(" "))
end

new_arr.flatten!

p new_arr
