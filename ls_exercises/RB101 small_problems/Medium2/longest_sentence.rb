text = File.open("pg84.txt", "r")
sentences = text.read.split(/\.|\?|!/)

longest = ""
sentences.each { |sentence| longest = sentence if sentence.size > longest.size }

puts longest