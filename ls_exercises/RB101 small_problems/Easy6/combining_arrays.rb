def merge(arr1, arr2)
  (arr1 + arr2).uniq.sort
end

# arr1 | arr2 returns a set union - a merged array with duplicates removed
