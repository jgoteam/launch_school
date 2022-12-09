def staggered_case2(string)
  needs = {up: true, down: false}
  string.chars.map do |char|
    if ('A'..'Z').include?(char.upcase) && needs[:up] == true
      needs[:up] = false
      needs[:down] = true
      char.upcase
    elsif ('a'..'z').include?(char.downcase) && needs[:down] == true
      needs[:up] = true
      needs[:down] = false
      char.downcase
    else
      char
    end
  end.join
end

# Noted in hindsight that only one status value is needed
# Refactored
def staggered_case(string)
  needs_up = true
  string.chars.map do |char|
    if ('A'..'Z').include?(char.upcase) && needs_up
      needs_up = !needs_up
      char.upcase
    elsif ('a'..'z').include?(char.downcase) && !needs_up
      needs_up = !needs_up
      char.downcase
    else
      char
    end
  end.join
end
