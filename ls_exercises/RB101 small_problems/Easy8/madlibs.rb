def madlibs
  answers = {'noun' => '', 'verb' => '', 'adjective' => '', 'adverb' => ''}
  answers.size.times do |num|
    puts "Enter a(n) #{answers.keys[num]}: "
    input = gets.chomp
    answers[answers.keys[num]] = input
  end
  puts "Do you #{answers['verb']} your #{answers['adjective']} #{answers['noun']} #{answers['adverb']}? That's hilarious!"
end
