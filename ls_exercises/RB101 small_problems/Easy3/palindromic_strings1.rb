def palindrome?(string)
  string == string.reverse
end

# Further exploration - without using reverse, if, unless, case, or reverse..
def palindrome?(collection)
  reverse_copy = collection.class.new
  index_counter = collection.size - 1
  until reverse_copy.size == collection.size
    reverse_copy << collection[index_counter]
    index_counter -= 1
  end
  reverse_copy == collection
end
