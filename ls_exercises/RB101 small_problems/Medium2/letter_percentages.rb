def letter_percentages(str)
  hsh = {}
  hsh[:uppercase] = (str.count("[A-Z]") / str.length.to_f * 100).round(1)
  hsh[:lowercase] = (str.count("[a-z]") / str.length.to_f * 100).round(1)
  hsh[:neither] = (str.count("^[A-Za-z]") / str.length.to_f * 100).round(1)
  hsh
end

