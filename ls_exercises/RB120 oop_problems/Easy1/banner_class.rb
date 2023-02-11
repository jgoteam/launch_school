# Further Exploration: wraps text, !break words
class Banner
  def initialize(message, width = message.size + 4)
    @message = message
    @width = width > 175 ? 175 : width
  end

  def to_s
    [horizontal_rule, empty_line, message_lines(text_chopper), empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{ "-" * @width }-+"
  end

  def empty_line
    "| #{ " " * @width } |"
  end

  def message_lines(text_chopper)
    (0...text_chopper.size).map do |slice_idx|
      "| #{text_chopper[slice_idx].center(@width)} |"
    end
  end

  def text_chopper
    char_count = @message.chars
    (0..all_chars.size - 1).step(@width - 8) do |limit| # -8 for padding
      limit.downto(0) do |position|
        break all_chars.insert(position, "\n") if all_chars[position] == ' '
      end
    end
    all_chars.join.split("\n")
  end
end
