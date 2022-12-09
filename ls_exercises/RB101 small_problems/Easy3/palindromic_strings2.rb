def real_palindrome?(string)
  allowed_chars = ('0'..'9').to_a + ('a'..'z').to_a
  to_eval = string.downcase.chars.select { |char| allowed_chars.include?(char) }
  to_eval == to_eval.reverse
end
