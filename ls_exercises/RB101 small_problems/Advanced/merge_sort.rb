def merge(arr1, arr2) #Aiming for maximum clarity and readability
  array1, array2 = arr1.map(&:dup), arr2.map(&:dup)
  sorted= []
  loop do
   sorted << case array1.first <=> array2.first
             when -1
               array1.shift
             when 0
               sorted << array1.shift
               array2.shift
             when 1
               array2.shift
             else
               array2.empty? ? array1.shift : array2.shift
             end
   return sorted if array1.empty? && array2.empty?
  end
 end

def merge_sort(arr)
  merge(merge(arr[0, 1], arr[1, 1]), merge(arr[2, 1], arr[3, 1]))
end

p merge_sort([9, 5, 7, 1]) # [1, 5, 7, 9]
# merge_sort([5, 3]) # [3, 5]
p merge_sort([6, 2, 7, 1, 4]) # [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) # %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) # [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
