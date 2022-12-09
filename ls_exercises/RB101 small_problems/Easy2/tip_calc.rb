def whats_the_tip
  puts "What is the bill?"
  base_bill = gets.chomp.to_i
  puts "What is the tip percentage?"
  tip_rate = gets.chomp.to_i
  puts <<-here
  The tip is: $#{base_bill * tip_rate / 100.0}
  The total is $#{(base_bill * (tip_rate / 100.0 + 1)).round(2)}
  here
end

# Further exploration
def whats_the_tip2
  puts "What is the bill?"
  base_bill = gets.chomp.to_i
  puts "What is the tip percentage?"
  tip_rate = gets.chomp.to_i
  total_tip  = base_bill * tip_rate / 100.0
  total_bill = (base_bill * (tip_rate / 100.0 + 1)).round(2)
  puts <<-here
  The tip is: $#{format("%0.2f", total_tip)}
  The total is $#{format("%0.2f", total_bill)}
  here
end
