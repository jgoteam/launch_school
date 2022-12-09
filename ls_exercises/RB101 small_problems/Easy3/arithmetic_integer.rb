operators = ['+', '-', '*', '/', '%', '**']

puts "Enter the first number: "
first_num = gets.chomp.to_i
puts "Enter the second number: "
second_num = gets.chomp.to_i

operators.each { |operator| puts "#{first_num} #{operator} #{second_num} = #{first_num.send(operator, second_num)}" }