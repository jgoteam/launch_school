# without using / or % operators
def century(num)
  counter, base = num.digits.partition.with_index { |_,idx| [0, 1].include?(idx) }
  counter = (1..99).include?(counter.reverse.join.to_i) ? 1 : 0
  combined = base.empty? ? '1' : (base.reverse.join.to_i + counter).to_s
  if ('1'..'3').include?(combined)
    combined + ['st', 'nd', 'rd'][ combined.to_i - 1 ]
  elsif ('11'..'19').include?(combined)
    combined + 'th'
  elsif ('1'..'2').include?(combined[-1])
    combined + ['st', 'nd'][ combined[-1].to_i - 1 ]
  else
    combined + 'th'
  end
end
