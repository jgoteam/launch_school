def interweave(arr1, arr2)
  new_arr = []
  arr1.size.times do |num|
    new_arr.append(arr1[num])
    new_arr.append(arr2[num])
  end
  new_arr
end
