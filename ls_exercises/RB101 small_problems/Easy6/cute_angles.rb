DEGREE = "\xC2\xB0"
def dms(degrees)
  whole_deg = degrees.to_i
  min_and_sec = degrees - whole_deg
  whole_min = (min_and_sec * 60).round(5).to_i
  sec = (min_and_sec * 60 - whole_min)
  whole_sec = (sec * 60).round(5).to_i
  "#{whole_deg}#{DEGREE}#{"%02d" % whole_min}'#{"%02d" % whole_sec}\" "
end
