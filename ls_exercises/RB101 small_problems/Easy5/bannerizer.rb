# Further exploration
# Utilizing `Array#Insert`: wraps text, !break words, not dynamic
LINE_LIMIT = 80

def text_chopper(text)
  char_count = 0
  all_chars = text.chars
  (0..all_chars.size - 1).step(LINE_LIMIT - 8) do |limit| # -8 for padding
    limit.downto(0) do |position|
      if all_chars[position] == ' '
        all_chars.insert(position, "\n")
        break
      end
    end
  end
  all_chars.join.split("\n")
end

def print_in_box(text)
  line_count = (text.size / LINE_LIMIT).ceil + 2 # +1 to account for padding
  chopped_text = text_chopper(text)
  horizontal_line = '+' + '-' * (LINE_LIMIT - 2) + '+'
  side_walls = '|' + ' ' * (LINE_LIMIT - 2) + '|'

  puts horizontal_line
  puts side_walls
  line_count.times do |count|
    puts '|' + "#{chopped_text[count]}".center(LINE_LIMIT - 2) + '|'
  end
  puts side_walls
  puts horizontal_line
  puts
end

print_in_box("On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammeled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.")
