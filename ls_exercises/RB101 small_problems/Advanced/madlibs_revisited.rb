word_bank = { adjectives: %w(quick lazy sleepy ugly),
              nouns: %w(fox dog head leg),
              verbs: %w(jumps lifts bites licks),
              adverbs: %w(easily lazily noisily excitedly) }

def fill_in(str, word_bank)
  str.split(' ').map do |word|
    if word.include?("%{adjective}")
      word.sub("%{adjective}", word_bank[:adjectives].shuffle.shift)
    elsif word.include?("%{noun}")
      word.sub("%{noun}", word_bank[:nouns].shuffle.shift)
    elsif word.include?("%{verb}")
      word.sub("%{verb}", word_bank[:verbs].shuffle.shift)
    elsif word.include?("%{adverb}")
      word.sub("%{adverb}", word_bank[:adverbs].shuffle.shift)
    else
      word
    end
  end.join(' ')
end

template = File.new("madlib_template1.md", "r")

puts fill_in(template.read, word_bank)
