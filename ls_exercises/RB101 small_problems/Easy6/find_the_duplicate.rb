def find_dup(arr)
  arr.select { |el| arr.count(el) == 2}.first
end

=begin

Further exploration

Enumerable#tally method returns a new hash:
  - with the keys being the unique elements of enumerable
  - and the values being the counts of those unique elements
  - With a hash passed in as an argument, that hash will be modified by the method - and that same hash will be returned.

  tally -> new_hash
  tally(hash) -> hash

  So...
=end

def find_dup(arr)
  arr.tally.key(2)
end