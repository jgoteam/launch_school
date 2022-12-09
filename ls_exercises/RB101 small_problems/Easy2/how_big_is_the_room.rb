def room_area
  puts "Enter the length of the room in meters: "
  length = gets.chomp.to_i
  puts "Enter the width of the room in meters: "
  width = gets.chomp.to_i
  square_meters = length * width * 1.00
  square_feet = length * width * 10.7639
  puts "The area of the room is #{square_meters} square meters (#{square_feet} square feet)."
end

# Further exploration
def room_area_extra
  puts "Enter the length of the room in feet: "
  length = gets.chomp.to_i
  puts "Enter the width of the room in feet: "
  width = gets.chomp.to_i
  sq_feet = (length * width * 1.0).round(2)
  sq_meters = (length * width / 10.7639).round(2)
  sq_inches = (length * width * 12.0 * 12).round(2)
  sq_centimeters = (length * width / 10.7639 * 100 * 100).round(2)
  print <<-heredoc
  The area of the room is:
          #{sq_feet} sq feet
          #{sq_meters} sq meters
          #{sq_inches} sq inches
          #{sq_centimeters} sq centimeters
  heredoc
end
