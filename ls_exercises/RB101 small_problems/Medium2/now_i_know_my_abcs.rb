BLOCKS = [['B','O'], ['X','K'], ['D','Q'], ['C','P'], ['N','A'],
          ['G','T'], ['R','E'], ['F','S'], ['J','W'], ['H','U'],
          ['V','I'], ['L','Y'], ['Z','M']]

# first_try
def block_word2?(str)
  block_counts = BLOCKS.each_with_object({}) { |block, hsh| hsh[block] = 1 }
  str.upcase.chars.each do |char|
    start_count = block_counts.values.sum
    blocks_left = block_counts.reject { |k, v| v == 0 }
    blocks_left.keys.each do |block|
      if block.include?(char)
        block_counts[block] -= 1
        break
      end
    end
    return false if start_count == block_counts.values.sum
  end
  true
end

# second try
def block_word?(str)
  blocks = [['B','O'], ['X','K'], ['D','Q'], ['C','P'], ['N','A'],
            ['G','T'], ['R','E'], ['F','S'], ['J','W'], ['H','U'],
            ['V','I'], ['L','Y'], ['Z','M']]

  word = str.upcase
  blocks.map! do |block|
    word.include?(block[0]) || word.include?(block[1]) ? 'cats' : block
  end
  blocks.count('cats') == str.length
end

# most concise
def block_word?(str)
  BLOCKS.none? { |block| str.upcase.count(block) >= 2 }
end

# noted that String#count returns the count of the total chars that match, not the entire substring, if these values are different.