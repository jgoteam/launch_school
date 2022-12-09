def fizzbuzz(first, last)
  (first..last).each do |num|
    if num % 3 == 0 && num % 5 != 0
      print 'Fizz '
    elsif num % 3 != 0 && num % 5 == 0
      print 'Buzz '
    elsif num % 3 == 0 && num % 5 == 0
      print 'FizzBuzz '
    else
      print "#{num} "
    end
  end
  puts
end
