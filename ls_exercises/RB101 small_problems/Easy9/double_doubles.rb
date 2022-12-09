def twice(num)
  num.to_s[0..(num.to_s.size / 2 - 1)] * 2 == num.to_s ? num : num * 2
end