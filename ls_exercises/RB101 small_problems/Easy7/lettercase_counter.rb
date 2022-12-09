def letter_case_count(string)
  case_hash = { lowercase: 0, uppercase: 0, neither: 0 }
  string.chars.each do |char|
    if char.ord >= 97 && char.ord <= 122
      case_hash[:lowercase] += 1
    elsif char.ord >=65 && char.ord <= 90
      case_hash[:uppercase] += 1
    else
      case_hash[:neither] += 1
    end
  end
  case_hash
end

def letter_case_count(string)
  up_count = string.count 'A-Z'
  lower_count = string.count 'a-z'
  other_count = string.count '^A-Za-z'
  { lowercase: lower_count, uppercase: up_count, neither: other_count }
end

# 12-07-22 Need to review and practice more with String#count and String#delete