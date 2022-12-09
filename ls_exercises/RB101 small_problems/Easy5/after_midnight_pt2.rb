def after_midnight(time)
  hours = time[0, 2] == '24' ? '00' : time[0, 2]
  minutes = time[-2, 2]
  total_minutes = hours.to_i * 60 + minutes.to_i
end

def before_midnight(time)
  inverse = 1440 - after_midnight(time)
  inverse == 1440 ? 0 : inverse
end