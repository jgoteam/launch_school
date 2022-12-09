def time_of_day(num)
  hours, minutes = num.divmod(60)
  formatted_hr = "%02d" % hours.modulo(24)
  formatted_min = "%02d" % minutes
  "#{formatted_hr}:#{formatted_min}"
end


=begin

# divmod method

  divmod(other) returns [q, r] where:

  q = (self / other).floor
  r = self % other
