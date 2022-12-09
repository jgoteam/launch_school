def clean_up(string)
  cleaned_up = []
  string.chars.each do |char|
    if ('a'..'z').include?(char)
      cleaned_up << char
    else
      cleaned_up << ' ' if cleaned_up.empty? || cleaned_up[-1] != ' '
    end
  end
  cleaned_up.join
end
