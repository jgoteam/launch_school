=begin
a featured number has these characteristics:
  --must be a multiple of 7
  --every digit must be unique

The task is to find the next featured number greater than the given argument, which will always be an integer,
  and to output an error if it does not exist.
  The main challenge here seems how to return an error + avoid getting into an infinite loop
    -an immediate idea comes to mind of utilizing run time and setting an absurdly high limit; when that limit is reached, an error is displayed
      -use of Timeout, Time modules and/or Benchmark modules could work here
=end

def featured(num)
  i = num

  if i % 7 == 0
    i += 7
  else
    i += 1 until i % 7 == 0
  end

  time_limit = 15 # seconds
  time_start = Time.now

  loop do
    return i if i % 7 == 0 && i.digits == i.digits.uniq && i.odd?
    i += 7
    return "Error: No next possible featured number" if Time.now - time_start > time_limit
  end

end

p featured(12) == 21
p featured(20) == 21
p featured(21) == 35
p featured(997) == 1029
p featured(1029) == 1043
p featured(999_999) == 1_023_547
p featured(999_999_987) == 1_023_456_987

p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements