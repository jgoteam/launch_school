def string_to_signed_integer(string)
  neg = false
  if string[0] == '-' || string[0] == '+'
    neg = true if string[0] == '-'
    string = string.reverse.chop.reverse
  end
  num_hsh = {'0'=> 0, '1'=>1, '2'=>2, '3'=>3, '4'=>4, '5'=>5, '6'=>6, '7'=>7, '8'=>8, '9'=>9}
  num_arr = string.chars.map { |char| num_hsh[char] if (48..57).to_a.include?(char.ord) }
  counter = num_arr.size - 1
  int = 0
  num_arr.each do |num|
    int += num * 10 ** counter
    counter -= 1
  end
  neg ? int * -1 : int
end