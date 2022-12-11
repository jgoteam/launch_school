def friday_13th(year)
  fridays = 0
  (1..12).each do |month|
    x = Time.new(year, month, 13)
    fridays += 1 if x.friday?
  end
  fridays
end

# not working
def five_fridays(year)
  five_fries = 0
  (1..12).each do |month|
    day = 1
    x = Time.new(year, month, day)
    day += 1 until x.friday?
    fries_count = 1
    until x == nil
      day += 7
      fries_count += 1
    end
    five_fries += 1 if fries_count == 5
  end
end
