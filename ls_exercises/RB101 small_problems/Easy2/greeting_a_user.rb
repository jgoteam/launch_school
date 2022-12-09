def greet_user
  print "What is your name? "
  name = gets.chomp
  puts name[-1] == '!' ? "HELLO #{name[0..-2].upcase}. WHY ARE WE SCREAMING?" : "Hello #{name}."
end
