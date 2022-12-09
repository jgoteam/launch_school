def buy_fruit(arr)
  arr.each_with_object([]) { |subarr, fruit_arr| subarr[1].times { fruit_arr << subarr[0] } }
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) #
["apples", "apples", "apples", "orange", "bananas","bananas"]