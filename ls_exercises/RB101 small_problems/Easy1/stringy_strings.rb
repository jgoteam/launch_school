def stringy(num)
  (1..num).to_a.map { |i| i.odd? ? 1.to_s : 0.to_s }.join
end
