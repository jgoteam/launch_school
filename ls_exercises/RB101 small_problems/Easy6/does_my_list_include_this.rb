def include2?(arr, item)
  arr.any?(el)
end

# using each
def include?(arr, item)
  arr.each { |el| return true if el == item }
  false
end
