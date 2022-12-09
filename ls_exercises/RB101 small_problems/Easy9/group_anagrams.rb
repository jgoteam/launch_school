def anagrams(arr)
  anagram_arr = []
  arr.each_with_index do |word, idx_zero|
    each_arr = []
    (idx_zero...arr.size).each { |idx| each_arr << arr[idx] if arr[idx_zero].chars.sort == arr[idx].chars.sort }
    anagram_arr << each_arr if !each_arr.empty?
  end
  anagram_arr
end