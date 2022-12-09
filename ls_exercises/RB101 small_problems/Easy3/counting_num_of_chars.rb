print "Please write word or multiple words: "
words = gets.chomp
count = words.split(' ').join.size
puts "There are #{count} characters in \"#{words}\"."