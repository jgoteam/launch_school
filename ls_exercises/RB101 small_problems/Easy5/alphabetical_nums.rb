# first try
def alphabetical_nums(num_arr)
  word_arr = "zero, one, two, three, four, five, six, seven, " \
             "eight, nine, ten, eleven, twelve, thirteen, " \
             "fourteen, fifteen, sixteen, seventeen, " \
             "eighteen, nineteen".split(', ')
  num_converter = (0..19).each_with_object({}) do |num, hsh|
    hsh[num] = word_arr[num]
  end
  num_arr.sort_by { |num| num_converter[num] }
end

# more concise
word_arr = %w(zero one two three four five six seven
             eight nine ten eleven twelve thirteen
             fourteen fifteen sixteen seventeen
             eighteen nineteen)

def alphabetical_nums2(num_arr)
 num_arr.sort_by { |num| word_arr[num] }
end
