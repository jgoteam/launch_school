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
