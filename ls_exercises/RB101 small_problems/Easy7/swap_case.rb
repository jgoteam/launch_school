def swapcase(string)
  string.chars.map do |char|
    if ('A'..'Z').include?(char)
      (char.ord + 32).chr
    elsif ('a'..'z').include?(char)
      (char.ord - 32).chr
    else
      char
    end
  end.join
end
