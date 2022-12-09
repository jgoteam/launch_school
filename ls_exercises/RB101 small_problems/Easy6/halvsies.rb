def halvsies(arr)
  arr.partition.with_index { |_,idx| idx < (arr.size/2.0).ceil }
end
