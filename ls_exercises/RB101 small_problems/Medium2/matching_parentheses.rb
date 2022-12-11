# first try...example of limited conceptual understanding of problem
def balanced?(str)
  return true if str.count('()') == 0
  return false if str.count('(') != str.count(')')
  str_copy = str.dup
  str_copy.delete!("^()")
  arr = []
  str_copy.chars.each { |char| arr << char if char == '(' || char == ')' }
  if arr.size == 2
    return false if arr.join == ')('
  else
    until arr.size == 2
      if arr[0] == '(' && arr[-1] == ')'
        arr.shift
        arr.pop
      else
        return false
      end
    end
  end
  true
end
